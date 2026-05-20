package com.cscm.backend.service;

import com.cscm.backend.entity.Notification;
import com.cscm.backend.enums.TypeNotification;
import com.cscm.backend.repository.NotificationRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.ReactiveRedisTemplate;
import org.springframework.http.codec.ServerSentEvent;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.core.publisher.Sinks;

import java.time.Duration;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Service
@RequiredArgsConstructor
@Slf4j
public class NotificationService {

    private final NotificationRepository notificationRepository;
    private final ReactiveRedisTemplate<String, String> redisTemplate;
    private final ObjectMapper objectMapper;

    @Value("${app.notification.channel-prefix:cscm:notif:}")
    private String channelPrefix;

    @Value("${app.notification.sse-heartbeat-seconds:30}")
    private int heartbeatSeconds;

    private final ConcurrentHashMap<UUID, Sinks.Many<ServerSentEvent<String>>> localSinks =
            new ConcurrentHashMap<>();

    // ─── SSE Stream ──────────────────────────────────────────────────────────

    public Flux<ServerSentEvent<String>> streamPourUtilisateur(UUID userId) {
        Sinks.Many<ServerSentEvent<String>> sink = localSinks.computeIfAbsent(
                userId,
                id -> Sinks.many().multicast().onBackpressureBuffer(64, false)
        );

        Flux<ServerSentEvent<String>> heartbeat = Flux.interval(Duration.ofSeconds(heartbeatSeconds))
                .map(tick -> ServerSentEvent.<String>builder()
                        .event("heartbeat")
                        .data("")
                        .build());

        Flux<ServerSentEvent<String>> redisSub = redisTemplate
                .listenToChannel(channelPrefix + userId)
                .map(msg -> ServerSentEvent.<String>builder()
                        .event("notification")
                        .data(msg.getMessage())
                        .build())
                .doOnError(e -> log.warn("Redis sub erreur pour {}: {}", userId, e.getMessage()))
                .onErrorResume(e -> Flux.empty());

        return Flux.merge(sink.asFlux(), heartbeat, redisSub)
                .doFinally(signal -> {
                    localSinks.remove(userId);
                    log.debug("SSE stream fermé pour userId={}", userId);
                });
    }

    // ─── Créer et pousser ────────────────────────────────────────────────────

    public Mono<Notification> creerEtEnvoyer(UUID destinataireId, UUID emetteurId,
                                               TypeNotification type, String titre, String message,
                                               Map<String, Object> donnees) {
        String donneesJson = serializeJson(donnees);

        Notification notif = Notification.builder()
                .id(UUID.randomUUID())
                .destinataireId(destinataireId)
                .emetteurId(emetteurId)
                .typeNotification(type)
                .titre(titre)
                .message(message)
                .donneesJson(donneesJson)
                .lue(false)
                .build();

        return notificationRepository.save(notif)
                .flatMap(saved -> {
                    String payload = serializeJson(Map.of(
                            "id", saved.getId().toString(),
                            "type", type.name(),
                            "titre", titre,
                            "message", message,
                            "donnees", donnees != null ? donnees : Map.of()
                    ));
                    pushLocal(destinataireId, payload);
                    return redisTemplate.convertAndSend(channelPrefix + destinataireId, payload)
                            .thenReturn(saved);
                })
                .doOnError(e -> log.error("Erreur envoi notification: {}", e.getMessage()));
    }

    // ─── Lecture ─────────────────────────────────────────────────────────────

    public Flux<Notification> getNotificationsUtilisateur(UUID userId) {
        return notificationRepository.findByDestinataireIdOrderByCreatedAtDesc(userId);
    }

    public Flux<Notification> getNotificationsNonLues(UUID userId) {
        return notificationRepository.findByDestinataireIdAndLueFalseOrderByCreatedAtDesc(userId);
    }

    public Mono<Long> compterNonLues(UUID userId) {
        return notificationRepository.countByDestinataireIdAndLueFalse(userId);
    }

    public Mono<Integer> marquerToutesCommeLues(UUID userId) {
        return notificationRepository.marquerToutesCommeLues(userId);
    }

    public Mono<Integer> marquerCommeLue(UUID notifId) {
        return notificationRepository.marquerCommeLue(notifId);
    }

    // ─── Helpers ─────────────────────────────────────────────────────────────

    private void pushLocal(UUID userId, String payload) {
        Sinks.Many<ServerSentEvent<String>> sink = localSinks.get(userId);
        if (sink != null) {
            sink.tryEmitNext(ServerSentEvent.<String>builder()
                    .event("notification")
                    .data(payload)
                    .build());
        }
    }

    private String serializeJson(Object obj) {
        if (obj == null) return "{}";
        try {
            return objectMapper.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            log.warn("Erreur sérialisation JSON: {}", e.getMessage());
            return "{}";
        }
    }
}

package com.cscm.backend.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.socket.WebSocketHandler;
import org.springframework.web.reactive.socket.WebSocketMessage;
import org.springframework.web.reactive.socket.WebSocketSession;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.core.publisher.Sinks;

import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * WebSocket pour les sessions de consultation en temps réel.
 * URL: /ws/consultation
 * Protocole: messages JSON { "type": "...", "payload": {...} }
 */
@Component
@RequiredArgsConstructor
@Slf4j
public class ConsultationWsHandler implements WebSocketHandler {

    private final ObjectMapper objectMapper;

    // sessionId → sink de messages à envoyer au client
    private final ConcurrentHashMap<String, Sinks.Many<String>> sessionSinks = new ConcurrentHashMap<>();
    // consultationId → set de sessionIds participants
    private final ConcurrentHashMap<UUID, ConcurrentHashMap<String, String>> consultationParticipants = new ConcurrentHashMap<>();

    @Override
    public Mono<Void> handle(WebSocketSession session) {
        String sessionId = session.getId();
        Sinks.Many<String> outboundSink = Sinks.many().unicast().onBackpressureBuffer();
        sessionSinks.put(sessionId, outboundSink);

        Flux<WebSocketMessage> outbound = outboundSink.asFlux()
                .map(session::textMessage)
                .doFinally(sig -> cleanup(sessionId));

        Mono<Void> inbound = session.receive()
                .map(WebSocketMessage::getPayloadAsText)
                .flatMap(payload -> handleMessage(sessionId, session, payload))
                .doOnError(e -> log.warn("Erreur WS consultation {}: {}", sessionId, e.getMessage()))
                .then();

        return session.send(outbound).and(inbound);
    }

    private Mono<Void> handleMessage(String sessionId, WebSocketSession session, String rawPayload) {
        return Mono.fromCallable(() -> objectMapper.readTree(rawPayload))
                .flatMap(node -> {
                    String type = node.path("type").asText();
                    return switch (type) {
                        case "JOIN_CONSULTATION" -> {
                            UUID consultationId = UUID.fromString(node.path("consultationId").asText());
                            String role = node.path("role").asText("PARTICIPANT");
                            consultationParticipants
                                    .computeIfAbsent(consultationId, k -> new ConcurrentHashMap<>())
                                    .put(sessionId, role);
                            log.info("Session {} rejoint consultation {}", sessionId, consultationId);
                            yield broadcast(consultationId, Map.of(
                                    "type", "PARTICIPANT_JOINED",
                                    "sessionId", sessionId,
                                    "role", role
                            ));
                        }
                        case "LEAVE_CONSULTATION" -> {
                            UUID consultationId = UUID.fromString(node.path("consultationId").asText());
                            removeFromConsultation(sessionId, consultationId);
                            yield broadcast(consultationId, Map.of(
                                    "type", "PARTICIPANT_LEFT",
                                    "sessionId", sessionId
                            ));
                        }
                        case "MESSAGE" -> {
                            UUID consultationId = UUID.fromString(node.path("consultationId").asText());
                            String contenu = node.path("contenu").asText();
                            yield broadcast(consultationId, Map.of(
                                    "type", "MESSAGE",
                                    "from", sessionId,
                                    "contenu", contenu
                            ));
                        }
                        case "VITALS_UPDATE" -> {
                            UUID consultationId = UUID.fromString(node.path("consultationId").asText());
                            yield broadcast(consultationId, Map.of(
                                    "type", "VITALS_UPDATE",
                                    "data", node.path("data")
                            ));
                        }
                        case "PING" -> {
                            Sinks.Many<String> sink = sessionSinks.get(sessionId);
                            if (sink != null) sink.tryEmitNext("{\"type\":\"PONG\"}");
                            yield Mono.<Void>empty();
                        }
                        default -> {
                            log.debug("Type WS inconnu: {}", type);
                            yield Mono.<Void>empty();
                        }
                    };
                })
                .onErrorResume(e -> {
                    log.warn("Erreur traitement message WS: {}", e.getMessage());
                    return Mono.empty();
                });
    }

    private Mono<Void> broadcast(UUID consultationId, Map<String, Object> message) {
        return Mono.fromCallable(() -> objectMapper.writeValueAsString(message))
                .doOnNext(json -> {
                    ConcurrentHashMap<String, String> participants = consultationParticipants.get(consultationId);
                    if (participants != null) {
                        participants.keySet().forEach(sid -> {
                            Sinks.Many<String> sink = sessionSinks.get(sid);
                            if (sink != null) sink.tryEmitNext(json);
                        });
                    }
                })
                .then();
    }

    private void removeFromConsultation(String sessionId, UUID consultationId) {
        ConcurrentHashMap<String, String> participants = consultationParticipants.get(consultationId);
        if (participants != null) {
            participants.remove(sessionId);
            if (participants.isEmpty()) {
                consultationParticipants.remove(consultationId);
            }
        }
    }

    private void cleanup(String sessionId) {
        sessionSinks.remove(sessionId);
        consultationParticipants.values().forEach(p -> p.remove(sessionId));
        log.debug("Session WS {} nettoyée", sessionId);
    }
}

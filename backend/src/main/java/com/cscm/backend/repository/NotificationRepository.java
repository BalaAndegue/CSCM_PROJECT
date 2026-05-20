package com.cscm.backend.repository;

import com.cscm.backend.entity.Notification;
import com.cscm.backend.enums.TypeNotification;
import org.springframework.data.r2dbc.repository.Modifying;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface NotificationRepository extends R2dbcRepository<Notification, UUID> {

    Flux<Notification> findByDestinataireIdOrderByCreatedAtDesc(UUID destinataireId);
    Flux<Notification> findByDestinataireIdAndLueFalseOrderByCreatedAtDesc(UUID destinataireId);
    Mono<Long> countByDestinataireIdAndLueFalse(UUID destinataireId);

    @Query("SELECT * FROM notifications WHERE destinataire_id = :id ORDER BY created_at DESC LIMIT :size OFFSET :offset")
    Flux<Notification> findByDestinataireidPaged(UUID id, int size, long offset);

    @Modifying
    @Query("UPDATE notifications SET lue = TRUE, date_lecture = NOW() WHERE destinataire_id = :userId AND lue = FALSE")
    Mono<Integer> marquerToutesCommeLues(UUID userId);

    @Modifying
    @Query("UPDATE notifications SET lue = TRUE, date_lecture = NOW() WHERE id = :id")
    Mono<Integer> marquerCommeLue(UUID id);

    @Query("SELECT * FROM notifications WHERE destinataire_id = :id AND type_notification = :type ORDER BY created_at DESC LIMIT 20")
    Flux<Notification> findByDestinataireidAndType(UUID id, TypeNotification type);
}

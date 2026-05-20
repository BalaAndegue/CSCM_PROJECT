package com.cscm.backend.entity;

import com.cscm.backend.enums.TypeNotification;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Notification en temps réel diffusée via SSE (Server-Sent Events) ou FCM.
 *
 * Chaque notification est persistée en base pour :
 * - Retrouver l'historique même si le client était hors ligne
 * - Marquer comme lue côté API
 */
@Table("notifications")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Notification {

    @Id
    private UUID id;

    /** FK → users.id (destinataire) */
    @Column("destinataire_id")
    private UUID destinataireId;

    /** FK → users.id (émetteur — null si système) */
    @Column("emetteur_id")
    private UUID emetteurId;

    @Column("type_notification")
    private TypeNotification typeNotification;

    @Column("titre")
    private String titre;

    @Column("message")
    private String message;

    /**
     * Données supplémentaires en JSON.
     * Ex: {"carnetId":"...", "medecinNom":"Dr Dupont", "tokenId":"..."}
     */
    @Column("donnees_json")
    private String donneesJson;

    @Builder.Default
    @Column("lue")
    private Boolean lue = false;

    @Column("date_lecture")
    private LocalDateTime dateLecture;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

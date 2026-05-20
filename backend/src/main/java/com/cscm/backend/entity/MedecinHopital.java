package com.cscm.backend.entity;

import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Association médecin ↔ hôpital.
 * Un médecin peut exercer dans plusieurs structures.
 * Les interventions se font sous couverture d'une structure hospitalière légale.
 */
@Table("medecin_hopital")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class MedecinHopital {

    @Id
    private UUID id;

    /** FK → medecins.id */
    @Column("medecin_id")
    private UUID medecinId;

    /** FK → hopitaux.id */
    @Column("hopital_id")
    private UUID hopitalId;

    @Builder.Default
    @Column("actif")
    private Boolean actif = true;

    @Column("service")
    private String service;

    @Column("poste")
    private String poste;

    @Column("date_debut")
    private LocalDateTime dateDebut;

    @Column("date_fin")
    private LocalDateTime dateFin;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

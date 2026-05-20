package com.cscm.backend.entity;

import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Table("carnets_medicaux")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class CarnetMedical {

    @Id
    private UUID id;

    /** FK → patients.id */
    @Column("patient_id")
    private UUID patientId;

    @Column("version")
    @Builder.Default
    private Integer version = 1;

    @Column("statut")
    @Builder.Default
    private String statut = "actif";

    @Column("abonnement_actif")
    @Builder.Default
    private Boolean abonnementActif = true;

    @Column("date_expiration_abonnement")
    private LocalDate dateExpirationAbonnement;

    @Column("notes_generales")
    private String notesGenerales;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column("updated_at")
    private LocalDateTime updatedAt;
}

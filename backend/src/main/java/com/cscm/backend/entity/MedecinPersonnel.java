package com.cscm.backend.entity;

import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Relation médecin traitant personnel ↔ patient.
 *
 * Le médecin traitant bénéficie d'un accès permanent au carnet du patient,
 * sans limite de durée, jusqu'à révocation explicite.
 * C'est le cas le plus courant en médecine de ville au Cameroun.
 */
@Table("medecins_personnels")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class MedecinPersonnel {

    @Id
    private UUID id;

    /** FK → carnets_medicaux.id */
    @Column("carnet_id")
    private UUID carnetId;

    /** FK → patients.id */
    @Column("patient_id")
    private UUID patientId;

    /** FK → medecins.id */
    @Column("medecin_id")
    private UUID medecinId;

    @Builder.Default
    @Column("actif")
    private Boolean actif = true;

    @Column("date_debut")
    private LocalDateTime dateDebut;

    /** Null tant que la relation est active */
    @Column("date_fin")
    private LocalDateTime dateFin;

    @Column("motif_fin")
    private String motifFin;

    @Column("notes_relation")
    private String notesRelation;

    // =========================================
    // DROITS D'ACCÈS PERMANENTS
    // =========================================

    @Builder.Default
    @Column("acces_historique")
    private Boolean accesHistorique = true;

    @Builder.Default
    @Column("acces_ordonnances")
    private Boolean accesOrdonnances = true;

    @Builder.Default
    @Column("acces_examens")
    private Boolean accesExamens = true;

    @Builder.Default
    @Column("peut_editer")
    private Boolean peutEditer = true;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column("updated_at")
    private LocalDateTime updatedAt;
}

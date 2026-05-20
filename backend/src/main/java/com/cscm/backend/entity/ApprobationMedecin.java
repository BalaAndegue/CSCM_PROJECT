package com.cscm.backend.entity;

import com.cscm.backend.enums.TypeAccesCarnet;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Enregistrement d'une autorisation d'accès d'un médecin au carnet médical d'un patient.
 * Supporte plusieurs modes d'accès : QR code, code court, ou permanent (médecin traitant).
 */
@Table("approbations_medecins")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ApprobationMedecin {

    @Id
    private UUID id;

    /** FK → carnets_medicaux.id */
    @Column("carnet_id")
    private UUID carnetId;

    /** FK → medecins.id */
    @Column("medecin_id")
    private UUID medecinId;

    // =========================================
    // APPROBATION PATIENT
    // =========================================

    @Builder.Default
    @Column("approuve_par_patient")
    private Boolean approuveParPatient = false;

    @Column("date_signature_patient")
    private LocalDateTime dateSignaturePatient;

    @Column("signature_patient")
    private String signaturePatient;

    // =========================================
    // APPROBATION AVARISTE
    // =========================================

    @Builder.Default
    @Column("approuve_par_garant")
    private Boolean approuveParGarant = false;

    @Column("date_signature_garant")
    private LocalDateTime dateSignatureGarant;

    @Column("signature_garant")
    private String signatureGarant;

    // =========================================
    // ÉTAT DE L'ACCÈS
    // =========================================

    @Builder.Default
    @Column("actif")
    private Boolean actif = true;

    @Column("date_revocation")
    private LocalDateTime dateRevocation;

    @Column("date_expiration")
    private LocalDateTime dateExpiration;

    @Column("motif_revocation")
    private String motifRevocation;

    // =========================================
    // TYPE ET SOURCE DE L'ACCÈS
    // =========================================

    /** Comment l'accès a-t-il été accordé */
    @Column("type_acces")
    private TypeAccesCarnet typeAcces;

    /** FK → tokens_acces_medecin.id (si accès par QR/code) */
    @Column("token_acces_id")
    private UUID tokenAccesId;

    /** Accès permanent au médecin traitant personnel */
    @Builder.Default
    @Column("est_medecin_personnel")
    private Boolean estMedecinPersonnel = false;

    // =========================================
    // DROITS D'ACCÈS GRANULAIRES
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
    @Column("acces_allergies")
    private Boolean accesAllergies = true;

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

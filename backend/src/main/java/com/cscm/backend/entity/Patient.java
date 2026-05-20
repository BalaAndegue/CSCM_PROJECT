package com.cscm.backend.entity;

import com.cscm.backend.enums.*;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Profil patient avec identité complète (CNI) et avariste obligatoire.
 * L'avariste est la personne habilitée à donner accès au carnet
 * si le patient est dans l'impossibilité de le faire.
 */
@Table("patients")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Patient {

    @Id
    private UUID id;

    /** FK → users.id */
    @Column("user_id")
    private UUID userId;

    /** Matricule unique: CSCM-PAT-YYYY-XXXXXX */
    @Column("matricule")
    private String matricule;

    /** Numéro du carnet de santé numérique */
    @Column("numero_carnet")
    private String numeroCarnet;

    // =========================================
    // IDENTITÉ COMPLÈTE (Carte Nationale d'Identité)
    // =========================================

    @Column("date_naissance")
    private LocalDate dateNaissance;

    @Column("lieu_naissance")
    private String lieuNaissance;

    @Column("pays_naissance")
    private String paysNaissance;

    @Column("region_naissance")
    private RegionCameroun regionNaissance;

    @Column("nationalite")
    @Builder.Default
    private String nationalite = "Camerounaise";

    @Column("genre")
    private Genre genre;

    @Column("situation_familiale")
    private SituationFamiliale situationFamiliale;

    @Column("filiation_pere")
    private String filiationPere;

    @Column("filiation_mere")
    private String filiationMere;

    /** Numéro CNI (OBLIGATOIRE pour inscription) */
    @Column("numero_cni")
    private String numeroCNI;

    @Column("date_delivrance_cni")
    private LocalDate dateDelivranceCNI;

    @Column("lieu_delivrance_cni")
    private String lieuDelivranceCNI;

    @Column("date_expiration_cni")
    private LocalDate dateExpirationCNI;

    // =========================================
    // COORDONNÉES
    // =========================================

    @Column("telephone")
    private String telephone;

    @Column("adresse")
    private String adresse;

    @Column("ville")
    private String ville;

    @Column("region_residence")
    private RegionCameroun regionResidence;

    @Column("profession")
    private String profession;

    @Column("lieu_travail")
    private String lieuTravail;

    // =========================================
    // INFORMATIONS MÉDICALES DE BASE
    // =========================================

    @Column("groupe_sanguin")
    private GroupeSanguin groupeSanguin;

    @Column("date_verification_abo_rh")
    private LocalDate dateVerificationAboRh;

    @Column("antecedents_medicaux")
    private String antecedentsMedicaux;

    @Column("antecedents_chirurgicaux")
    private String antecedentsChirurgicaux;

    @Column("antecedents_familiaux")
    private String antecedentsFamiliaux;

    /** FK → medecins.id (médecin traitant personnel) */
    @Column("medecin_traitant_id")
    private UUID medecinTraitantId;

    @Column("photo_profil")
    private String photoProfil;

    // =========================================
    // CONTACT D'URGENCE
    // =========================================

    @Column("contact_urgence_nom")
    private String contactUrgenceNom;

    @Column("contact_urgence_telephone")
    private String contactUrgenceTelephone;

    @Column("contact_urgence_lien")
    private LienParente contactUrgenceLien;

    // =========================================
    // AVARISTE (GARANT D'ACCÈS) — OBLIGATOIRE
    //
    // L'avariste est la personne de confiance qui peut
    // accorder l'accès au carnet médical si le patient
    // est dans l'impossibilité de le faire lui-même
    // (inconscience, décès, incapacité).
    // =========================================

    /** Nom complet de l'avariste (OBLIGATOIRE) */
    @Column("garant_nom_complet")
    private String garantNomComplet;

    /** Téléphone de l'avariste (OBLIGATOIRE) */
    @Column("garant_telephone")
    private String garantTelephone;

    /** Email de l'avariste */
    @Column("garant_email")
    private String garantEmail;

    /** Lien de parenté avec le patient (OBLIGATOIRE) */
    @Column("garant_lien_parente")
    private LienParente garantLienParente;

    /** Numéro CNI de l'avariste */
    @Column("garant_numero_cni")
    private String garantNumeroCNI;

    /** Adresse complète de l'avariste */
    @Column("garant_adresse")
    private String garantAdresse;

    /** Si l'avariste est aussi un utilisateur de la plateforme — FK → users.id */
    @Column("garant_user_id")
    private UUID garantUserId;

    /** L'avariste a-t-il actuellement accès au carnet ? */
    @Column("garant_acces_actif")
    @Builder.Default
    private Boolean garantAccesActif = false;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column("updated_at")
    private LocalDateTime updatedAt;
}

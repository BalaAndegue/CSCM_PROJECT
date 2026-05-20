package com.cscm.backend.entity;

import com.cscm.backend.enums.MedecinStatus;
import com.cscm.backend.enums.RegionCameroun;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Profil médecin avec documents et champs conformes au contexte camerounais.
 * Validation stricte par admin avant autorisation d'exercer sur la plateforme.
 */
@Table("medecins")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Medecin {

    @Id
    private UUID id;

    /** FK → users.id */
    @Column("user_id")
    private UUID userId;

    /** Matricule unique CSCM: CSCM-MED-XXXXX */
    @Column("matricule")
    private String matricule;

    // =========================================
    // IDENTITÉ PROFESSIONNELLE
    // =========================================

    /** Numéro d'inscription au Conseil National de l'Ordre des Médecins du Cameroun (CNOM) */
    @Column("numero_cnom")
    private String numeroCNOM;

    /** Numéro du registre de l'ordre (peut différer du CNOM) */
    @Column("numero_ordre")
    private String numeroOrdre;

    /** Numéro de la carte professionnelle délivrée par le CNOM */
    @Column("numero_carte_professionnelle")
    private String numeroCarteProfessionnelle;

    // =========================================
    // CNI DU MÉDECIN
    // =========================================

    @Column("numero_cni")
    private String numeroCNI;

    @Column("date_delivrance_cni")
    private LocalDate dateDelivranceCNI;

    @Column("lieu_delivrance_cni")
    private String lieuDelivranceCNI;

    @Column("date_expiration_cni")
    private LocalDate dateExpirationCNI;

    // =========================================
    // SPÉCIALITÉ & COMPÉTENCES
    // =========================================

    @Column("specialite")
    private String specialite;

    @Column("sous_specialite")
    private String sousSpecialite;

    /** Diplômes stockés en JSON: ["Doctorat Médecine UYI 2015", "DESC Cardiologie 2019"] */
    @Column("diplomes_json")
    private String diplomesJson;

    @Column("annees_experience")
    @Builder.Default
    private Integer anneesExperience = 0;

    @Column("biographie")
    private String biographie;

    /** Langues pratiquées (important: Cameroun bilingue) JSON: ["Français","Anglais"] */
    @Column("langues_json")
    private String languesJson;

    // =========================================
    // LOCALISATION PRINCIPALE
    // =========================================

    @Column("region_principale")
    private RegionCameroun regionPrincipale;

    @Column("ville_principale")
    private String villePrincipale;

    // =========================================
    // CASIER JUDICIAIRE
    // =========================================

    @Column("reference_casier_judiciaire")
    private String referenceCasierJudiciaire;

    @Column("date_expiration_casier")
    private LocalDate dateExpirationCasier;

    // =========================================
    // PHOTOS & DOCUMENTS
    // =========================================

    @Column("photo_identite")
    private String photoIdentite;

    // =========================================
    // ÉTAT COMPTE & VALIDATION ADMIN
    // =========================================

    @Builder.Default
    @Column("status")
    private MedecinStatus status = MedecinStatus.EN_ATTENTE;

    @Column("raison_rejet")
    private String raisonRejet;

    /** FK → users.id (admin ayant validé) */
    @Column("valide_par")
    private UUID validePar;

    @Column("date_validation")
    private LocalDateTime dateValidation;

    /** Tous les documents obligatoires ont été uploadés */
    @Column("documents_complets")
    @Builder.Default
    private Boolean documentsComplets = false;

    /** Tous les documents validés par un admin */
    @Column("documents_valides")
    @Builder.Default
    private Boolean documentsValides = false;

    // =========================================
    // EXERCICE
    // =========================================

    @Column("disponible")
    @Builder.Default
    private Boolean disponible = true;

    @Column("consultation_fee")
    private Double consultationFee;

    // =========================================
    // STATISTIQUES (calculées périodiquement)
    // =========================================

    @Column("nombre_patients_suivis")
    @Builder.Default
    private Integer nombrePatientsSuivis = 0;

    @Column("nombre_consultations_total")
    @Builder.Default
    private Integer nombreConsultationsTotal = 0;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column("updated_at")
    private LocalDateTime updatedAt;
}

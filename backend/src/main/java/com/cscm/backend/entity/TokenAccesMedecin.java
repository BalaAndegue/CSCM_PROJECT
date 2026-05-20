package com.cscm.backend.entity;

import com.cscm.backend.enums.StatutTokenAcces;
import com.cscm.backend.enums.TypeAccesCarnet;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Token d'accès temporaire au carnet médical.
 *
 * Deux modes :
 * - QR_CODE  : le patient affiche un QR sur son téléphone, le médecin scanne.
 * - CODE_COURT: le patient génère un code à 6 chiffres qu'il communique au médecin.
 *
 * Le code/QR expire automatiquement (défaut : 30 min).
 * L'accès n'est effectif qu'après validation côté backend (anti-usurpation).
 */
@Table("tokens_acces_medecin")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class TokenAccesMedecin {

    @Id
    private UUID id;

    /** FK → carnets_medicaux.id */
    @Column("carnet_id")
    private UUID carnetId;

    /** FK → patients.id (qui a généré ce token) */
    @Column("patient_id")
    private UUID patientId;

    /** FK → medecins.id — renseigné une fois le token utilisé */
    @Column("medecin_id")
    private UUID medecinId;

    @Column("type_acces")
    private TypeAccesCarnet typeAcces;

    /**
     * Code à 6 chiffres pour TypeAccesCarnet.CODE_COURT.
     * Null pour QR_CODE.
     */
    @Column("code_court")
    private String codeCourt;

    /**
     * Payload chiffré intégré dans le QR code.
     * Format : JWT signé contenant {carnetId, patientId, exp, iat}.
     */
    @Column("qr_payload")
    private String qrPayload;

    @Builder.Default
    @Column("statut")
    private StatutTokenAcces statut = StatutTokenAcces.ACTIF;

    @Column("expires_at")
    private LocalDateTime expiresAt;

    @Column("utilise_at")
    private LocalDateTime utiliséAt;

    // =========================================
    // DROITS ACCORDÉS VIA CE TOKEN
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
}

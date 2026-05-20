package com.cscm.backend.enums;

public enum TypeAccesCarnet {
    /** Scan d'un QR code généré par le patient */
    QR_CODE,
    /** Code numérique court (6 chiffres) envoyé/affiché au médecin */
    CODE_COURT,
    /** Accès permanent accordé au médecin traitant personnel */
    PERMANENT_PERSONNEL,
    /** Invitation directe (lien sécurisé envoyé par email/SMS) */
    INVITE_DIRECT
}

package com.cscm.backend.enums;

public enum StatutTokenAcces {
    /** Token généré, en attente d'utilisation */
    ACTIF,
    /** Token utilisé par un médecin */
    UTILISE,
    /** Token expiré (délai dépassé) */
    EXPIRE,
    /** Token révoqué manuellement par le patient */
    REVOQUE
}

package com.cscm.backend.enums;

/**
 * Types de documents exigés pour la validation des acteurs de santé
 * au Cameroun (MINSANTE / CNOM).
 */
public enum TypeDocumentValidation {
    // ---- PATIENT ----
    /** Recto de la Carte Nationale d'Identité */
    CNI_RECTO,
    /** Verso de la Carte Nationale d'Identité */
    CNI_VERSO,
    /** Photo portrait biométrique */
    PHOTO_PORTRAIT,

    // ---- MÉDECIN ----
    /** Diplôme d'État de Docteur en Médecine (ou équivalent reconnu) */
    DIPLOME_MEDECINE,
    /** Attestation d'inscription au Conseil National de l'Ordre des Médecins du Cameroun */
    ATTESTATION_CNOM,
    /** Carte professionnelle délivrée par l'Ordre des Médecins du Cameroun */
    CARTE_ORDRE_MEDECINS,
    /** Extrait de casier judiciaire Bulletin N°3 (moins de 3 mois) */
    CASIER_JUDICIAIRE_B3,
    /** Photo d'identité professionnelle */
    PHOTO_IDENTITE_PROFESSIONNELLE,
    /** Certificat de spécialité (pour spécialistes) */
    CERTIFICAT_SPECIALITE,
    /** Recto CNI du médecin */
    CNI_MEDECIN_RECTO,
    /** Verso CNI du médecin */
    CNI_MEDECIN_VERSO,
    /** Attestation de travail de l'hôpital */
    ATTESTATION_TRAVAIL_HOPITAL,

    // ---- HÔPITAL / STRUCTURE ----
    /** Agrément du Ministère de la Santé Publique (MINSANTE) */
    AGREMENT_MINSANTE,
    /** Autorisation d'exploitation */
    AUTORISATION_EXPLOITATION,
    /** Patente professionnelle */
    PATENTE_PROFESSIONNELLE,
    /** Plan de l'établissement */
    PLAN_ETABLISSEMENT,
    /** Document enregistrement CFCE/Centre des impôts */
    REGISTRE_COMMERCE,

    AUTRE
}

package com.cscm.backend.enums;

/**
 * Types de médias constituant un dossier médical numérique.
 * Couvre toutes les catégories pratiquées au Cameroun.
 */
public enum TypeMedia {
    // Imagerie radiologique
    RADIOGRAPHIE,
    SCANNER_CT,
    IRM,
    ECHOGRAPHIE,
    MAMMOGRAPHIE,
    OSTEODENSITOMENTRIE,
    // Imagerie fonctionnelle
    SCINTIGRAPHIE,
    PET_SCAN,
    // Cardiologie
    ECG,
    HOLTER_ECG,
    ECHOGRAPHIE_CARDIAQUE,
    EPREUVE_EFFORT,
    // Biologie clinique / laboratoire
    BILAN_BIOLOGIQUE,
    FROTTIS_SANGUIN,
    BACTERIOLOGIE,
    SEROLOGIE,
    ANATOMOPATHOLOGIE,
    CYTOLOGIE,
    // Endoscopie
    ENDOSCOPIE,
    COLONOSCOPIE,
    FIBROSCOPIE,
    // Ophtalmologie / ORL
    FOND_OEIL,
    CHAMP_VISUEL,
    OCT_RETINE,
    AUDIOGRAMME,
    // Documents médicaux
    ORDONNANCE_NUMERISEE,
    CERTIFICAT_MEDICAL,
    COMPTE_RENDU_OPERATOIRE,
    COMPTE_RENDU_CONSULTATION,
    COMPTE_RENDU_HOSPITALISATION,
    FICHE_ANESTHESIE,
    CARNET_VACCINATION,
    BILAN_PRENATAL,
    // Vidéo/Audio
    VIDEO_EXAMEN,
    ENREGISTREMENT_AUDIO,
    // Identité et administrative
    CNI_RECTO,
    CNI_VERSO,
    PHOTO_PORTRAIT,
    // Autre
    AUTRE
}

-- =============================================
-- V8 – Gestion médias médicaux (remplace documents)
-- =============================================

CREATE TABLE IF NOT EXISTS medias_fichiers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    carnet_id UUID REFERENCES carnets_medicaux(id) ON DELETE CASCADE,
    uploaded_by UUID NOT NULL REFERENCES users(id),

    type_media VARCHAR(50) NOT NULL CHECK (type_media IN (
        'RADIOGRAPHIE','SCANNER_CT','IRM','ECHOGRAPHIE','MAMMOGRAPHIE',
        'OSTEODENSITOMENTRIE','SCINTIGRAPHIE','PET_SCAN',
        'ECG','HOLTER_ECG','ECHOGRAPHIE_CARDIAQUE','EPREUVE_EFFORT',
        'BILAN_BIOLOGIQUE','FROTTIS_SANGUIN','BACTERIOLOGIE','SEROLOGIE',
        'ANATOMOPATHOLOGIE','CYTOLOGIE',
        'ENDOSCOPIE','COLONOSCOPIE','FIBROSCOPIE',
        'FOND_OEIL','CHAMP_VISUEL','OCT_RETINE','AUDIOGRAMME',
        'ORDONNANCE_NUMERISEE','CERTIFICAT_MEDICAL',
        'COMPTE_RENDU_OPERATOIRE','COMPTE_RENDU_CONSULTATION',
        'COMPTE_RENDU_HOSPITALISATION','FICHE_ANESTHESIE',
        'CARNET_VACCINATION','BILAN_PRENATAL',
        'VIDEO_EXAMEN','ENREGISTREMENT_AUDIO',
        'CNI_RECTO','CNI_VERSO','PHOTO_PORTRAIT','AUTRE'
    )),

    nom_original VARCHAR(500) NOT NULL,
    nom_stockage VARCHAR(500) NOT NULL UNIQUE,
    chemin_stockage VARCHAR(1000) NOT NULL,
    url_acces VARCHAR(1000),
    type_mime VARCHAR(100),
    taille_fichier BIGINT,
    checksum VARCHAR(64),    -- SHA-256

    -- Entités liées (optionnel)
    consultation_id UUID REFERENCES consultations(id) ON DELETE SET NULL,
    examen_id UUID REFERENCES examens(id) ON DELETE SET NULL,
    ordonnance_id UUID REFERENCES ordonnances(id) ON DELETE SET NULL,

    description TEXT,
    confidentiel BOOLEAN DEFAULT FALSE,
    actif BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMP DEFAULT NOW()
);

-- Mise à jour de resultats_examens pour pointer vers medias_fichiers
ALTER TABLE resultats_examens
    ADD COLUMN IF NOT EXISTS fichier_resultat_id UUID REFERENCES medias_fichiers(id),
    ADD COLUMN IF NOT EXISTS valeurs_cles TEXT,    -- JSON texte (remplace JSONB pour R2DBC)
    DROP COLUMN IF EXISTS fichier_resultat;        -- ancienne FK vers documents

-- Index
CREATE INDEX IF NOT EXISTS idx_medias_carnet ON medias_fichiers(carnet_id);
CREATE INDEX IF NOT EXISTS idx_medias_type ON medias_fichiers(type_media);
CREATE INDEX IF NOT EXISTS idx_medias_examen ON medias_fichiers(examen_id);
CREATE INDEX IF NOT EXISTS idx_medias_consultation ON medias_fichiers(consultation_id);

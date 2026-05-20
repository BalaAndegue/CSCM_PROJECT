-- =============================================
-- V9 – Documents de validation médecins / hôpitaux
-- Processus MINSANTE / CNOM Cameroun
-- =============================================

CREATE TABLE IF NOT EXISTS documents_validation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Propriétaire : médecin ou hôpital
    proprietaire_id UUID NOT NULL,
    proprietaire_type VARCHAR(10) NOT NULL CHECK (proprietaire_type IN ('MEDECIN', 'HOPITAL')),

    type_document VARCHAR(60) NOT NULL CHECK (type_document IN (
        -- Patient
        'CNI_RECTO','CNI_VERSO','PHOTO_PORTRAIT',
        -- Médecin
        'DIPLOME_MEDECINE','ATTESTATION_CNOM','CARTE_ORDRE_MEDECINS',
        'CASIER_JUDICIAIRE_B3','PHOTO_IDENTITE_PROFESSIONNELLE',
        'CERTIFICAT_SPECIALITE','CNI_MEDECIN_RECTO','CNI_MEDECIN_VERSO',
        'ATTESTATION_TRAVAIL_HOPITAL',
        -- Hôpital
        'AGREMENT_MINSANTE','AUTORISATION_EXPLOITATION',
        'PATENTE_PROFESSIONNELLE','PLAN_ETABLISSEMENT','REGISTRE_COMMERCE',
        'AUTRE'
    )),

    statut VARCHAR(25) NOT NULL DEFAULT 'EN_ATTENTE_UPLOAD'
        CHECK (statut IN ('EN_ATTENTE_UPLOAD','UPLOADE','EN_VERIFICATION',
                          'VALIDE','REJETE','EXPIRE')),

    -- Fichier
    nom_original VARCHAR(500),
    nom_stockage VARCHAR(500),
    chemin_stockage VARCHAR(1000),
    type_mime VARCHAR(100),
    taille_fichier BIGINT,
    checksum VARCHAR(64),

    -- Validation admin
    valide_par UUID REFERENCES users(id),
    date_validation TIMESTAMP,
    motif_rejet TEXT,
    commentaire_admin TEXT,

    -- Expiration du document lui-même (ex: casier judiciaire 3 mois)
    date_expiration_document DATE,

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Index pour suivi admin
CREATE INDEX IF NOT EXISTS idx_docs_validation_proprietaire ON documents_validation(proprietaire_id, proprietaire_type);
CREATE INDEX IF NOT EXISTS idx_docs_validation_statut ON documents_validation(statut);
CREATE INDEX IF NOT EXISTS idx_docs_validation_type ON documents_validation(type_document);
CREATE INDEX IF NOT EXISTS idx_docs_validation_expire ON documents_validation(date_expiration_document)
    WHERE statut = 'VALIDE';

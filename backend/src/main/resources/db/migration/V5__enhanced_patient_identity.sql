-- =============================================
-- V5 – Identité complète patient + matricule
-- Ajout des champs CNI, avariste enrichi, matricule
-- =============================================

-- Matricule unique pour tous les utilisateurs
ALTER TABLE users
    ADD COLUMN IF NOT EXISTS matricule VARCHAR(30) UNIQUE,
    ADD COLUMN IF NOT EXISTS fcm_token VARCHAR(500);

-- Champs identité complète patient (CNI obligatoire)
ALTER TABLE patients
    ADD COLUMN IF NOT EXISTS matricule VARCHAR(30) UNIQUE,
    -- Lieu et pays de naissance
    ADD COLUMN IF NOT EXISTS lieu_naissance VARCHAR(255),
    ADD COLUMN IF NOT EXISTS pays_naissance VARCHAR(100) DEFAULT 'Cameroun',
    ADD COLUMN IF NOT EXISTS region_naissance VARCHAR(30)
        CHECK (region_naissance IN ('ADAMAOUA','CENTRE','EST','EXTREME_NORD','LITTORAL',
                                    'NORD','NORD_OUEST','OUEST','SUD','SUD_OUEST')),
    ADD COLUMN IF NOT EXISTS nationalite VARCHAR(100) DEFAULT 'Camerounaise',
    -- Filiation
    ADD COLUMN IF NOT EXISTS filiation_pere VARCHAR(255),
    ADD COLUMN IF NOT EXISTS filiation_mere VARCHAR(255),
    -- CNI patient (OBLIGATOIRE à terme, NOT NULL une fois toutes les lignes migrées)
    ADD COLUMN IF NOT EXISTS numero_cni VARCHAR(50) UNIQUE,
    ADD COLUMN IF NOT EXISTS date_delivrance_cni DATE,
    ADD COLUMN IF NOT EXISTS lieu_delivrance_cni VARCHAR(255),
    ADD COLUMN IF NOT EXISTS date_expiration_cni DATE,
    -- Coordonnées enrichies
    ADD COLUMN IF NOT EXISTS ville VARCHAR(150),
    ADD COLUMN IF NOT EXISTS region_residence VARCHAR(30)
        CHECK (region_residence IN ('ADAMAOUA','CENTRE','EST','EXTREME_NORD','LITTORAL',
                                    'NORD','NORD_OUEST','OUEST','SUD','SUD_OUEST')),
    ADD COLUMN IF NOT EXISTS lieu_travail VARCHAR(255),
    -- Constantes vitales / urgence
    ADD COLUMN IF NOT EXISTS contact_urgence_lien VARCHAR(30)
        CHECK (contact_urgence_lien IN ('CONJOINT','PARENT','ENFANT','FRERE_SOEUR',
                                        'ONCLE_TANTE','COUSIN_COUSINE','GRAND_PARENT',
                                        'AMI_PROCHE','TUTEUR_LEGAL','AUTRE'));

-- Avariste (garant) enrichi — OBLIGATOIRE lors de l'inscription
ALTER TABLE patients
    ADD COLUMN IF NOT EXISTS garant_numero_cni VARCHAR(50),
    ADD COLUMN IF NOT EXISTS garant_adresse TEXT,
    ADD COLUMN IF NOT EXISTS garant_lien_parente VARCHAR(30)
        CHECK (garant_lien_parente IN ('CONJOINT','PARENT','ENFANT','FRERE_SOEUR',
                                       'ONCLE_TANTE','COUSIN_COUSINE','GRAND_PARENT',
                                       'AMI_PROCHE','TUTEUR_LEGAL','AUTRE')),
    ADD COLUMN IF NOT EXISTS garant_acces_actif BOOLEAN DEFAULT FALSE;

-- Index
CREATE INDEX IF NOT EXISTS idx_patients_numero_cni ON patients(numero_cni);
CREATE INDEX IF NOT EXISTS idx_patients_matricule ON patients(matricule);
CREATE INDEX IF NOT EXISTS idx_users_matricule ON users(matricule);

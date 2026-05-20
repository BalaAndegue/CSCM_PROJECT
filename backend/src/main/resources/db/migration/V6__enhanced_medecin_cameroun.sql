-- =============================================
-- V6 – Médecin : champs camerounais + CNOM + CNI
-- Conformité MINSANTE et Ordre des Médecins du Cameroun
-- =============================================

ALTER TABLE medecins
    ADD COLUMN IF NOT EXISTS matricule VARCHAR(30) UNIQUE,
    -- CNOM (Conseil National de l'Ordre des Médecins du Cameroun)
    ADD COLUMN IF NOT EXISTS numero_cnom VARCHAR(50) UNIQUE,
    -- CNI du médecin
    ADD COLUMN IF NOT EXISTS numero_cni VARCHAR(50),
    ADD COLUMN IF NOT EXISTS date_delivrance_cni DATE,
    ADD COLUMN IF NOT EXISTS lieu_delivrance_cni VARCHAR(255),
    ADD COLUMN IF NOT EXISTS date_expiration_cni DATE,
    -- Diplômes (JSON list)
    ADD COLUMN IF NOT EXISTS diplomes_json TEXT,
    -- Langues pratiquées (JSON: ["Français","Anglais"])
    ADD COLUMN IF NOT EXISTS langues_json TEXT DEFAULT '["Français"]',
    -- Localisation principale
    ADD COLUMN IF NOT EXISTS region_principale VARCHAR(30)
        CHECK (region_principale IN ('ADAMAOUA','CENTRE','EST','EXTREME_NORD','LITTORAL',
                                     'NORD','NORD_OUEST','OUEST','SUD','SUD_OUEST')),
    ADD COLUMN IF NOT EXISTS ville_principale VARCHAR(150),
    -- Casier judiciaire (Bulletin N°3 — obligatoire, expire après 3 mois)
    ADD COLUMN IF NOT EXISTS reference_casier_judiciaire VARCHAR(100),
    ADD COLUMN IF NOT EXISTS date_expiration_casier DATE,
    -- Statut documents
    ADD COLUMN IF NOT EXISTS documents_complets BOOLEAN DEFAULT FALSE,
    ADD COLUMN IF NOT EXISTS documents_valides BOOLEAN DEFAULT FALSE,
    -- Statistiques (mises à jour périodiquement)
    ADD COLUMN IF NOT EXISTS nombre_patients_suivis INTEGER DEFAULT 0,
    ADD COLUMN IF NOT EXISTS nombre_consultations_total INTEGER DEFAULT 0,
    -- Timestamps manquants
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT NOW();

-- Hôpitaux : région + matricule + champs camerounais
ALTER TABLE hopitaux
    ADD COLUMN IF NOT EXISTS matricule VARCHAR(30) UNIQUE,
    ADD COLUMN IF NOT EXISTS region VARCHAR(30)
        CHECK (region IN ('ADAMAOUA','CENTRE','EST','EXTREME_NORD','LITTORAL',
                          'NORD','NORD_OUEST','OUEST','SUD','SUD_OUEST')),
    ADD COLUMN IF NOT EXISTS ville VARCHAR(150),
    ADD COLUMN IF NOT EXISTS arrondissement VARCHAR(150),
    ADD COLUMN IF NOT EXISTS type_etablissement VARCHAR(50),
    ADD COLUMN IF NOT EXISTS urgences_24h BOOLEAN DEFAULT FALSE,
    ADD COLUMN IF NOT EXISTS maternite BOOLEAN DEFAULT FALSE,
    ADD COLUMN IF NOT EXISTS documents_valides BOOLEAN DEFAULT FALSE,
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT NOW();

-- Approbations : nouveaux champs (accès granulaires, type, sessions)
ALTER TABLE approbations_medecins
    ADD COLUMN IF NOT EXISTS type_acces VARCHAR(30)
        CHECK (type_acces IN ('QR_CODE','CODE_COURT','PERMANENT_PERSONNEL','INVITE_DIRECT')),
    ADD COLUMN IF NOT EXISTS token_acces_id UUID,
    ADD COLUMN IF NOT EXISTS est_medecin_personnel BOOLEAN DEFAULT FALSE,
    ADD COLUMN IF NOT EXISTS acces_allergies BOOLEAN DEFAULT TRUE,
    ADD COLUMN IF NOT EXISTS peut_editer BOOLEAN DEFAULT TRUE,
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT NOW();

-- Consultations : champs manquants
ALTER TABLE consultations
    ADD COLUMN IF NOT EXISTS saturation_oxygene INTEGER;

-- Examens : catégorie standardisée Cameroun
ALTER TABLE examens
    ADD COLUMN IF NOT EXISTS type_examen_cameroun VARCHAR(80);

-- Ordonnances : champ JSON (TEXT pour R2DBC)
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_name='ordonnances' AND column_name='medicaments'
        AND data_type='jsonb'
    ) THEN
        ALTER TABLE ordonnances RENAME COLUMN medicaments TO medicaments_json;
    END IF;
END$$;

-- Index supplémentaires
CREATE INDEX IF NOT EXISTS idx_medecins_matricule ON medecins(matricule);
CREATE INDEX IF NOT EXISTS idx_medecins_numero_cnom ON medecins(numero_cnom);
CREATE INDEX IF NOT EXISTS idx_hopitaux_matricule ON hopitaux(matricule);
CREATE INDEX IF NOT EXISTS idx_hopitaux_region ON hopitaux(region);

-- =============================================
-- V7 – Système de tokens d'accès (QR Code / Code Court)
-- =============================================

CREATE TABLE IF NOT EXISTS tokens_acces_medecin (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    carnet_id UUID NOT NULL REFERENCES carnets_medicaux(id) ON DELETE CASCADE,
    patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,

    -- Renseigné une fois le token utilisé par un médecin
    medecin_id UUID REFERENCES medecins(id),

    type_acces VARCHAR(30) NOT NULL CHECK (type_acces IN (
        'QR_CODE', 'CODE_COURT', 'PERMANENT_PERSONNEL', 'INVITE_DIRECT'
    )),

    -- Code à 6 chiffres (pour CODE_COURT uniquement)
    code_court VARCHAR(10) UNIQUE,

    -- Payload JWT signé intégré dans le QR code
    qr_payload TEXT,

    statut VARCHAR(20) NOT NULL DEFAULT 'ACTIF'
        CHECK (statut IN ('ACTIF','UTILISE','EXPIRE','REVOQUE')),

    expires_at TIMESTAMP NOT NULL,
    utilise_at TIMESTAMP,

    -- Droits accordés via ce token
    acces_historique BOOLEAN DEFAULT TRUE,
    acces_ordonnances BOOLEAN DEFAULT TRUE,
    acces_examens BOOLEAN DEFAULT TRUE,
    peut_editer BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMP DEFAULT NOW()
);

-- FK depuis approbations vers le token source
ALTER TABLE approbations_medecins
    ADD CONSTRAINT fk_approbation_token
    FOREIGN KEY (token_acces_id) REFERENCES tokens_acces_medecin(id)
    ON DELETE SET NULL;

-- Index critiques pour les lookups rapides
CREATE INDEX IF NOT EXISTS idx_tokens_code_court ON tokens_acces_medecin(code_court)
    WHERE statut = 'ACTIF';
CREATE INDEX IF NOT EXISTS idx_tokens_carnet_statut ON tokens_acces_medecin(carnet_id, statut);
CREATE INDEX IF NOT EXISTS idx_tokens_expires_at ON tokens_acces_medecin(expires_at)
    WHERE statut = 'ACTIF';

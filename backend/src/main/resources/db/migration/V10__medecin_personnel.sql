-- =============================================
-- V10 – Médecin traitant personnel (accès permanent)
-- =============================================

CREATE TABLE IF NOT EXISTS medecins_personnels (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    carnet_id UUID NOT NULL REFERENCES carnets_medicaux(id) ON DELETE CASCADE,
    patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    medecin_id UUID NOT NULL REFERENCES medecins(id) ON DELETE CASCADE,

    actif BOOLEAN DEFAULT TRUE,
    date_debut TIMESTAMP NOT NULL DEFAULT NOW(),
    date_fin TIMESTAMP,            -- NULL = relation toujours active
    motif_fin TEXT,
    notes_relation TEXT,

    -- Droits permanents accordés
    acces_historique BOOLEAN DEFAULT TRUE,
    acces_ordonnances BOOLEAN DEFAULT TRUE,
    acces_examens BOOLEAN DEFAULT TRUE,
    peut_editer BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),

    -- Un patient ne peut avoir qu'un seul médecin personnel actif à la fois
    UNIQUE (patient_id, medecin_id)
);

CREATE INDEX IF NOT EXISTS idx_medecin_personnel_patient ON medecins_personnels(patient_id) WHERE actif = TRUE;
CREATE INDEX IF NOT EXISTS idx_medecin_personnel_medecin ON medecins_personnels(medecin_id) WHERE actif = TRUE;

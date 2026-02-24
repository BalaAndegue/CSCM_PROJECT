-- CSCM V2 Schema Migrations

-- 1. Updates to patients table
ALTER TABLE patients
ADD COLUMN garant_nom_complet VARCHAR(255),
ADD COLUMN garant_telephone VARCHAR(20),
ADD COLUMN garant_email VARCHAR(255),
ADD COLUMN garant_lien_parente VARCHAR(100),
ADD COLUMN garant_user_id UUID REFERENCES users(id);

-- 2. Updates to approbations_medecins table
ALTER TABLE approbations_medecins
ADD COLUMN date_expiration TIMESTAMP,
ADD COLUMN approuve_par_garant BOOLEAN NOT NULL DEFAULT FALSE,
ADD COLUMN date_signature_garant TIMESTAMP,
ADD COLUMN signature_garant TEXT;

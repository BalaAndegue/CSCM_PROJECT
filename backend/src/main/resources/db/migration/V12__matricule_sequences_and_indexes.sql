-- =============================================
-- V12 – Séquences matricules + index de performance
-- =============================================

-- Séquences pour génération des matricules par rôle
CREATE SEQUENCE IF NOT EXISTS seq_matricule_patient START 1 INCREMENT 1;
CREATE SEQUENCE IF NOT EXISTS seq_matricule_medecin START 1 INCREMENT 1;
CREATE SEQUENCE IF NOT EXISTS seq_matricule_hopital START 1 INCREMENT 1;
CREATE SEQUENCE IF NOT EXISTS seq_matricule_admin START 1 INCREMENT 1;

-- Audit logs : ajout colonnes JSON texte (R2DBC)
ALTER TABLE audit_logs
    ADD COLUMN IF NOT EXISTS ancien_valeur_json TEXT,
    ADD COLUMN IF NOT EXISTS nouvelle_valeur_json TEXT;

-- Résultats examens : colonnes JSON texte (R2DBC)
ALTER TABLE resultats_examens
    ADD COLUMN IF NOT EXISTS valeurs_cles_json TEXT;

-- Medecin_hopital : dates de début/fin
ALTER TABLE medecin_hopital
    ADD COLUMN IF NOT EXISTS date_debut TIMESTAMP,
    ADD COLUMN IF NOT EXISTS date_fin TIMESTAMP;

-- Index de performance globaux
CREATE INDEX IF NOT EXISTS idx_tokens_medecin_id ON tokens_acces_medecin(medecin_id);
CREATE INDEX IF NOT EXISTS idx_medias_uploaded_by ON medias_fichiers(uploaded_by);
CREATE INDEX IF NOT EXISTS idx_notif_type ON notifications(type_notification);
CREATE INDEX IF NOT EXISTS idx_approbations_medecin ON approbations_medecins(medecin_id) WHERE actif = TRUE;
CREATE INDEX IF NOT EXISTS idx_approbations_carnet ON approbations_medecins(carnet_id) WHERE actif = TRUE;
CREATE INDEX IF NOT EXISTS idx_sessions_user_actives ON sessions(user_id, expire_at) WHERE invalide = FALSE;

-- Vue utile pour le tableau de bord admin
CREATE OR REPLACE VIEW v_stats_plateforme AS
SELECT
    (SELECT COUNT(*) FROM users WHERE role = 'PATIENT' AND compte_actif = TRUE) AS patients_actifs,
    (SELECT COUNT(*) FROM users WHERE role = 'MEDECIN' AND compte_actif = TRUE) AS medecins_actifs,
    (SELECT COUNT(*) FROM medecins WHERE status = 'EN_ATTENTE') AS medecins_en_attente,
    (SELECT COUNT(*) FROM medecins WHERE status = 'VALIDE') AS medecins_valides,
    (SELECT COUNT(*) FROM hopitaux WHERE status = 'ACTIF') AS hopitaux_actifs,
    (SELECT COUNT(*) FROM consultations WHERE date_consultation >= NOW() - INTERVAL '30 days') AS consultations_30j,
    (SELECT COUNT(*) FROM tokens_acces_medecin WHERE statut = 'ACTIF' AND expires_at > NOW()) AS tokens_actifs,
    (SELECT COUNT(*) FROM notifications WHERE lue = FALSE) AS notifications_non_lues;

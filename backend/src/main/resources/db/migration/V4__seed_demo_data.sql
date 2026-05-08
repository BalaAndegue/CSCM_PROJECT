-- ============================================================
-- V4 – Données de démonstration (médecins, patients, carnets)
-- Mot de passe pour tous les comptes : DemoPass123!
-- Hash BCrypt (rounds=10) généré et vérifié localement
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- 1. USERS – Médecins
-- ────────────────────────────────────────────────────────────
INSERT INTO users (id, email, mot_de_passe_hash, role, nom_complet, telephone,
                   email_verifie, telephone_verifie, deux_facteurs, compte_actif,
                   created_at, updated_at)
VALUES
  ('b1000000-0000-0000-0000-000000000001',
   'dr.dupuis@hopital.cm',
   '$2a$10$aoWMhy0z/powAnnKSasOH.WRKdxCmnaIRA3hOwGvyJswpRJzhE70m',
   'MEDECIN', 'Dr. Martin Dupuis', '+237655000001',
   true, false, false, true, NOW(), NOW()),

  ('b1000000-0000-0000-0000-000000000002',
   'dr.nguemo@hopital.cm',
   '$2a$10$aoWMhy0z/powAnnKSasOH.WRKdxCmnaIRA3hOwGvyJswpRJzhE70m',
   'MEDECIN', 'Dr. Aline Nguemo', '+237655000002',
   true, false, false, true, NOW(), NOW());

-- ────────────────────────────────────────────────────────────
-- 2. MEDECINS – colonnes per V1: id, user_id, numero_ordre,
--    specialite, sous_specialite, annees_experience, biographie,
--    status (VALIDE|EN_ATTENTE|SUSPENDU|REJETE), disponible
-- ────────────────────────────────────────────────────────────
INSERT INTO medecins (id, user_id, numero_ordre, specialite, annees_experience,
                      biographie, status, disponible, created_at)
VALUES
  ('b2000000-0000-0000-0000-000000000001',
   'b1000000-0000-0000-0000-000000000001',
   'CM-CARD-00145', 'Cardiologie', 12,
   'Cardiologue senior specialise dans les maladies coronariennes.',
   'VALIDE', true, NOW()),

  ('b2000000-0000-0000-0000-000000000002',
   'b1000000-0000-0000-0000-000000000002',
   'CM-PED-00289', 'Pediatrie', 8,
   'Pediatre experimentee, specialisee dans la nutrition infantile.',
   'VALIDE', true, NOW());

-- Affectation hôpitaux (table medecin_hopital)
INSERT INTO medecin_hopital (id, medecin_id, hopital_id, actif, service, created_at)
VALUES
  (gen_random_uuid(), 'b2000000-0000-0000-0000-000000000001',
   'a0000000-0000-0000-0000-000000000001', true, 'Cardiologie', NOW()),
  (gen_random_uuid(), 'b2000000-0000-0000-0000-000000000002',
   'a0000000-0000-0000-0000-000000000002', true, 'Pediatrie', NOW());

-- ────────────────────────────────────────────────────────────
-- 3. USERS – Patients
-- ────────────────────────────────────────────────────────────
INSERT INTO users (id, email, mot_de_passe_hash, role, nom_complet, telephone,
                   email_verifie, telephone_verifie, deux_facteurs, compte_actif,
                   created_at, updated_at)
VALUES
  ('c1000000-0000-0000-0000-000000000001',
   'jean.kamga@patient.cm',
   '$2a$10$aoWMhy0z/powAnnKSasOH.WRKdxCmnaIRA3hOwGvyJswpRJzhE70m',
   'PATIENT', 'Jean Kamga', '+237677000001',
   true, false, false, true, NOW(), NOW()),

  ('c1000000-0000-0000-0000-000000000002',
   'marie.ngo@patient.cm',
   '$2a$10$aoWMhy0z/powAnnKSasOH.WRKdxCmnaIRA3hOwGvyJswpRJzhE70m',
   'PATIENT', 'Marie Ngo', '+237677000002',
   true, false, false, true, NOW(), NOW());

-- ────────────────────────────────────────────────────────────
-- 4. PATIENTS – colonnes per V1: id, user_id, numero_carnet (NOT NULL),
--    date_naissance (NOT NULL), genre (M|F|AUTRE),
--    groupe_sanguin (A_PLUS|O_PLUS|...), adresse,
--    contact_urgence_nom, contact_urgence_telephone
-- ────────────────────────────────────────────────────────────
INSERT INTO patients (id, user_id, numero_carnet, date_naissance, genre,
                      groupe_sanguin, adresse,
                      contact_urgence_nom, contact_urgence_telephone,
                      created_at, updated_at)
VALUES
  ('c2000000-0000-0000-0000-000000000001',
   'c1000000-0000-0000-0000-000000000001',
   'CSCM-DEMO-0001', '1985-04-12', 'M',
   'O_PLUS', '45 rue de la Paix, Yaounde',
   'Jeanne Kamga', '+237677000099',
   NOW(), NOW()),

  ('c2000000-0000-0000-0000-000000000002',
   'c1000000-0000-0000-0000-000000000002',
   'CSCM-DEMO-0002', '1992-09-23', 'F',
   'A_PLUS', '12 avenue Kennedy, Douala',
   'Paul Ngo', '+237677000098',
   NOW(), NOW());

-- ────────────────────────────────────────────────────────────
-- 5. CARNETS MÉDICAUX
-- ────────────────────────────────────────────────────────────
INSERT INTO carnets_medicaux (id, patient_id, version, statut, abonnement_actif,
                              notes_generales, created_at, updated_at)
VALUES
  ('d1000000-0000-0000-0000-000000000001',
   'c2000000-0000-0000-0000-000000000001',
   1, 'actif', true,
   'Patient hypertendu sous traitement continu. Surveiller la pression arterielle mensuellement.',
   NOW(), NOW()),

  ('d1000000-0000-0000-0000-000000000002',
   'c2000000-0000-0000-0000-000000000002',
   1, 'actif', true,
   'Patiente sans antecedents majeurs. Suivie pour migraines chroniques.',
   NOW(), NOW());

-- ────────────────────────────────────────────────────────────
-- 6. APPROBATIONS – colonnes per V1:
--    id, carnet_id, medecin_id, approuve_par_patient, actif,
--    acces_historique, acces_ordonnances, acces_examens
-- ────────────────────────────────────────────────────────────
INSERT INTO approbations_medecins (id, carnet_id, medecin_id,
                                   approuve_par_patient, actif,
                                   acces_historique, acces_ordonnances, acces_examens,
                                   created_at)
VALUES
  ('e1000000-0000-0000-0000-000000000001',
   'd1000000-0000-0000-0000-000000000001',
   'b2000000-0000-0000-0000-000000000001',
   true, true,
   true, true, true, NOW()),

  ('e1000000-0000-0000-0000-000000000002',
   'd1000000-0000-0000-0000-000000000002',
   'b2000000-0000-0000-0000-000000000002',
   true, true,
   true, true, true, NOW());

-- ────────────────────────────────────────────────────────────
-- 7. CONSULTATIONS – colonnes per V1:
--    id, carnet_id, medecin_id, hopital_id, date_consultation,
--    motif, symptomes, diagnostic, traitement_recommande,
--    pression_arterielle, frequence_cardiaque, temperature, poids,
--    notes_complementaires
-- ────────────────────────────────────────────────────────────
INSERT INTO consultations (id, carnet_id, medecin_id, hopital_id,
                           date_consultation, motif, symptomes, diagnostic,
                           traitement_recommande, pression_arterielle,
                           frequence_cardiaque, temperature, poids,
                           notes_complementaires, created_at)
VALUES
  ('f1000000-0000-0000-0000-000000000001',
   'd1000000-0000-0000-0000-000000000001',
   'b2000000-0000-0000-0000-000000000001',
   'a0000000-0000-0000-0000-000000000001',
   '2025-11-10 09:00:00',
   'Controle tension arterielle',
   'Maux de tete frequents, vision legerement floue',
   'Hypertension arterielle stade 1 confirmee',
   'Amlodipine 5mg/j + regime hyposode',
   '145/92', 78, 37.1, 82.5,
   'Revoir dans 1 mois. ECG normal.',
   NOW()),

  ('f1000000-0000-0000-0000-000000000002',
   'd1000000-0000-0000-0000-000000000001',
   'b2000000-0000-0000-0000-000000000001',
   'a0000000-0000-0000-0000-000000000001',
   '2025-12-15 10:30:00',
   'Suivi HTA + douleurs thoraciques',
   'Douleurs thoraciques a l''effort, essouflement modere',
   'Angor stable possible - bilan complementaire prescrit',
   'Amlodipine 10mg/j + Betabloquant',
   '138/88', 72, 36.9, 81.0,
   'Echo cardiaque demandee. Surveillance renforcee.',
   NOW()),

  ('f1000000-0000-0000-0000-000000000003',
   'd1000000-0000-0000-0000-000000000001',
   'b2000000-0000-0000-0000-000000000001',
   'a0000000-0000-0000-0000-000000000001',
   '2026-01-20 11:00:00',
   'Resultats echo cardiaque',
   'Resultats rassurants, legere hypertrophie VG',
   'Cardiopathie hypertensive debutante',
   'Traitement maintenu + activite physique 30min/j',
   '132/85', 70, 36.8, 80.5,
   'Prochain controle dans 3 mois.',
   NOW()),

  ('f1000000-0000-0000-0000-000000000004',
   'd1000000-0000-0000-0000-000000000002',
   'b2000000-0000-0000-0000-000000000002',
   'a0000000-0000-0000-0000-000000000002',
   '2026-01-05 08:30:00',
   'Migraines recurrentes',
   'Cephalees intenses 2-3x/semaine, photophobie, nausees',
   'Migraine sans aura - syndrome migraneux chronique',
   'Sumatriptan 50mg a la crise + Topiramate 25mg/j',
   '118/75', 65, 37.0, 61.0,
   'Journal de migraines recommande.',
   NOW());

-- ────────────────────────────────────────────────────────────
-- 8. ALLERGIES – colonnes per V1:
--    id, carnet_id, nom_allergene, type_allergene,
--    type_reaction (ERUPTION|ANAPHYLAXIE|NAUSEE|AUTRE),
--    gravite (LEGERE|MODEREE|SEVERE|MORTELLE),
--    traitement_urgence, medecin_notificateur, active
-- ────────────────────────────────────────────────────────────
INSERT INTO allergies (id, carnet_id, nom_allergene, type_allergene,
                       type_reaction, gravite, traitement_urgence,
                       medecin_notificateur, active, created_at)
VALUES
  ('a0100000-0000-0000-0000-000000000001',
   'd1000000-0000-0000-0000-000000000001',
   'Penicilline', 'MEDICAMENT',
   'ANAPHYLAXIE', 'SEVERE',
   'Adrenaline 0.3mg IM + antihistaminiques IV + appel SAMU',
   'b2000000-0000-0000-0000-000000000001', true, NOW()),

  ('a0100000-0000-0000-0000-000000000002',
   'd1000000-0000-0000-0000-000000000001',
   'Aspirine (AAS)', 'MEDICAMENT',
   'AUTRE', 'MODEREE',
   'Bronchodilatateur + antihistaminiques',
   'b2000000-0000-0000-0000-000000000001', true, NOW()),

  ('a0100000-0000-0000-0000-000000000003',
   'd1000000-0000-0000-0000-000000000002',
   'Arachides', 'ALIMENTAIRE',
   'ANAPHYLAXIE', 'SEVERE',
   'Auto-injecteur d''adrenaline (EpiPen) + SAMU',
   'b2000000-0000-0000-0000-000000000002', true, NOW());

-- ────────────────────────────────────────────────────────────
-- 9. ORDONNANCES – colonnes per V1:
--    id, carnet_id, medecin_id, hopital_id (NOT NULL),
--    date_prescription (NOT NULL), date_expiration,
--    numero_ordonnance, medicaments (JSONB), instructions, status
-- ────────────────────────────────────────────────────────────
INSERT INTO ordonnances (id, carnet_id, medecin_id, hopital_id,
                         date_prescription, date_expiration,
                         numero_ordonnance, medicaments, instructions, status,
                         created_at)
VALUES
  ('a0200000-0000-0000-0000-000000000001',
   'd1000000-0000-0000-0000-000000000001',
   'b2000000-0000-0000-0000-000000000001',
   'a0000000-0000-0000-0000-000000000001',
   '2025-11-10', '2026-02-10',
   'ORD-DEMO-001',
   '[{"nom":"Amlodipine","dosage":"5mg","frequence":"1x/jour","instructions":"Le soir au coucher"},{"nom":"Regime hyposode","dosage":"","frequence":"Permanent","instructions":"Sel inferieur 5g/jour"}]',
   'Surveiller la tension chaque semaine.',
   'ACTIVE', NOW()),

  ('a0200000-0000-0000-0000-000000000002',
   'd1000000-0000-0000-0000-000000000001',
   'b2000000-0000-0000-0000-000000000001',
   'a0000000-0000-0000-0000-000000000001',
   '2025-12-15', '2026-03-15',
   'ORD-DEMO-002',
   '[{"nom":"Amlodipine","dosage":"10mg","frequence":"1x/jour","instructions":"Le matin"},{"nom":"Bisoprolol","dosage":"2.5mg","frequence":"1x/jour","instructions":"Ne pas arreter brusquement"}]',
   'Urgence si douleur thoracique persistante. Appeler le 15.',
   'ACTIVE', NOW()),

  ('a0200000-0000-0000-0000-000000000003',
   'd1000000-0000-0000-0000-000000000002',
   'b2000000-0000-0000-0000-000000000002',
   'a0000000-0000-0000-0000-000000000002',
   '2026-01-05', '2026-04-05',
   'ORD-DEMO-003',
   '[{"nom":"Sumatriptan","dosage":"50mg","frequence":"A la crise max 2x/j","instructions":"Prendre des les premiers symptomes"},{"nom":"Topiramate","dosage":"25mg","frequence":"1x/jour le soir","instructions":"Augmentation progressive"}]',
   'Tenir un journal des crises.',
   'ACTIVE', NOW());

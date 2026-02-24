-- =============================================
-- CSCM – Carnet de Santé Numérique
-- V1 – Schéma initial complet
-- =============================================

-- Extension UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =============================================
-- USERS
-- =============================================
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    mot_de_passe_hash VARCHAR(255) NOT NULL,
    role VARCHAR(30) NOT NULL CHECK (role IN ('PATIENT', 'MEDECIN', 'ADMIN', 'MANAGER_HOPITAL')),
    nom_complet VARCHAR(255) NOT NULL,
    telephone VARCHAR(20),
    email_verifie BOOLEAN DEFAULT FALSE,
    telephone_verifie BOOLEAN DEFAULT FALSE,
    deux_facteurs BOOLEAN DEFAULT FALSE,
    deux_facteurs_secret VARCHAR(255),
    compte_actif BOOLEAN DEFAULT TRUE,
    derniere_connexion TIMESTAMP,
    token_reinitialisation VARCHAR(255),
    token_reinit_expire_at TIMESTAMP,
    token_verification_email VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- HOPITAUX
-- =============================================
CREATE TABLE IF NOT EXISTS hopitaux (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nom VARCHAR(255) NOT NULL,
    adresse TEXT NOT NULL,
    telephone VARCHAR(20),
    email VARCHAR(255),
    site_web VARCHAR(255),
    numero_agrement VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    nombre_lits INTEGER,
    status VARCHAR(20) DEFAULT 'ACTIF' CHECK (status IN ('ACTIF', 'SUSPENDU')),
    manager_id UUID REFERENCES users(id),
    logo VARCHAR(500),
    localisation_gps VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- MEDECINS
-- =============================================
CREATE TABLE IF NOT EXISTS medecins (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    numero_ordre VARCHAR(50) UNIQUE NOT NULL,
    specialite VARCHAR(255) NOT NULL,
    sous_specialite VARCHAR(255),
    numero_carte_professionnelle VARCHAR(100) UNIQUE,
    annees_experience INTEGER DEFAULT 0,
    biographie TEXT,
    photo_identite VARCHAR(500),
    status VARCHAR(20) DEFAULT 'EN_ATTENTE' CHECK (status IN ('EN_ATTENTE', 'VALIDE', 'SUSPENDU', 'REJETE')),
    raison_rejet TEXT,
    valide_par UUID REFERENCES users(id),
    date_validation TIMESTAMP,
    consultation_fee DOUBLE PRECISION,
    disponible BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS medecin_diplomes (
    medecin_id UUID REFERENCES medecins(id) ON DELETE CASCADE,
    diplome VARCHAR(500) NOT NULL
);

-- =============================================
-- MEDECIN ↔ HOPITAL
-- =============================================
CREATE TABLE IF NOT EXISTS medecin_hopital (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    medecin_id UUID NOT NULL REFERENCES medecins(id) ON DELETE CASCADE,
    hopital_id UUID NOT NULL REFERENCES hopitaux(id) ON DELETE CASCADE,
    actif BOOLEAN DEFAULT TRUE,
    service VARCHAR(100),
    poste VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(medecin_id, hopital_id)
);

-- =============================================
-- PATIENTS
-- =============================================
CREATE TABLE IF NOT EXISTS patients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    numero_carnet VARCHAR(50) UNIQUE NOT NULL,
    date_naissance DATE NOT NULL,
    genre VARCHAR(10) NOT NULL CHECK (genre IN ('M', 'F', 'AUTRE')),
    adresse TEXT,
    telephone VARCHAR(20),
    situation_familiale VARCHAR(20) CHECK (situation_familiale IN ('CELIBATAIRE', 'MARIE', 'DIVORCE', 'VEUF')),
    profession VARCHAR(255),
    antecedents_chirurgicaux TEXT,
    antecedents_familiaux TEXT,
    antecedents_medicaux TEXT,
    groupe_sanguin VARCHAR(10) CHECK (groupe_sanguin IN ('A_PLUS', 'A_MINUS', 'B_PLUS', 'B_MINUS', 'AB_PLUS', 'AB_MINUS', 'O_PLUS', 'O_MINUS')),
    date_verification_abo_rh DATE,
    medecin_traitant_id UUID REFERENCES medecins(id),
    contact_urgence_nom VARCHAR(255),
    contact_urgence_telephone VARCHAR(20),
    photo_profil VARCHAR(500),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- CARNETS MÉDICAUX
-- =============================================
CREATE TABLE IF NOT EXISTS carnets_medicaux (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    version INTEGER DEFAULT 1,
    statut VARCHAR(20) DEFAULT 'actif',
    abonnement_actif BOOLEAN DEFAULT TRUE,
    date_expiration_abonnement DATE,
    notes_generales TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- APPROBATIONS MÉDECINS
-- =============================================
CREATE TABLE IF NOT EXISTS approbations_medecins (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    carnet_id UUID NOT NULL REFERENCES carnets_medicaux(id) ON DELETE CASCADE,
    medecin_id UUID NOT NULL REFERENCES medecins(id) ON DELETE CASCADE,
    approuve_par_patient BOOLEAN NOT NULL DEFAULT FALSE,
    date_signature_patient TIMESTAMP,
    signature_patient TEXT,
    actif BOOLEAN DEFAULT TRUE,
    date_revocation TIMESTAMP,
    motif_revocation TEXT,
    acces_historique BOOLEAN DEFAULT FALSE,
    acces_ordonnances BOOLEAN DEFAULT TRUE,
    acces_examens BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(carnet_id, medecin_id)
);

-- =============================================
-- DOCUMENTS
-- =============================================
CREATE TABLE IF NOT EXISTS documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    carnet_id UUID REFERENCES carnets_medicaux(id) ON DELETE SET NULL,
    uploaded_by UUID NOT NULL,
    nom_fichier VARCHAR(255) NOT NULL,
    nom_original VARCHAR(255),
    type_mime VARCHAR(100),
    taille BIGINT,
    chemin_stockage VARCHAR(500),
    type_document VARCHAR(100),
    chiffre BOOLEAN DEFAULT FALSE,
    description TEXT,
    entite_type VARCHAR(50),
    entite_id UUID,
    actif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- CONSULTATIONS
-- =============================================
CREATE TABLE IF NOT EXISTS consultations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    carnet_id UUID NOT NULL REFERENCES carnets_medicaux(id) ON DELETE CASCADE,
    medecin_id UUID NOT NULL REFERENCES medecins(id),
    hopital_id UUID REFERENCES hopitaux(id),
    date_consultation TIMESTAMP NOT NULL,
    motif TEXT,
    symptomes TEXT,
    diagnostic TEXT,
    traitement_recommande TEXT,
    suivi_recommande TEXT,
    duree_consultation_minutes INTEGER,
    gravite VARCHAR(20) CHECK (gravite IN ('FAIBLE', 'MOYENNE', 'HAUTE', 'URGENTE')),
    prochaine_consultation TIMESTAMP,
    pression_arterielle VARCHAR(20),
    poids DOUBLE PRECISION,
    taille DOUBLE PRECISION,
    temperature DOUBLE PRECISION,
    frequence_cardiaque INTEGER,
    notes_complementaires TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- ALLERGIES
-- =============================================
CREATE TABLE IF NOT EXISTS allergies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    carnet_id UUID NOT NULL REFERENCES carnets_medicaux(id) ON DELETE CASCADE,
    nom_allergene VARCHAR(255) NOT NULL,
    type_allergene VARCHAR(100),
    type_reaction VARCHAR(30) NOT NULL CHECK (type_reaction IN ('ERUPTION', 'ANAPHYLAXIE', 'NAUSEE', 'AUTRE')),
    gravite VARCHAR(20) CHECK (gravite IN ('LEGERE', 'MODEREE', 'SEVERE', 'MORTELLE')),
    date_premiere_reaction DATE,
    description TEXT,
    traitement_urgence TEXT,
    medecin_notificateur UUID REFERENCES medecins(id),
    visible_tous_medecins BOOLEAN DEFAULT TRUE,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- EXAMENS
-- =============================================
CREATE TABLE IF NOT EXISTS examens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    carnet_id UUID NOT NULL REFERENCES carnets_medicaux(id) ON DELETE CASCADE,
    medecin_prescripteur UUID REFERENCES medecins(id),
    consultation_id UUID REFERENCES consultations(id),
    type_examen VARCHAR(255) NOT NULL,
    categorie_examen VARCHAR(100),
    instructions TEXT,
    date_prescription TIMESTAMP,
    date_realisation TIMESTAMP,
    etablissement_realisation VARCHAR(255),
    resultat_pris_en_compte BOOLEAN DEFAULT FALSE,
    urgent BOOLEAN DEFAULT FALSE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- RÉSULTATS EXAMENS
-- =============================================
CREATE TABLE IF NOT EXISTS resultats_examens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    examen_id UUID NOT NULL REFERENCES examens(id) ON DELETE CASCADE,
    fichier_resultat UUID REFERENCES documents(id),
    valeurs_cles JSONB,
    interpretation TEXT,
    conclusion TEXT,
    medecin_lecteur UUID REFERENCES medecins(id),
    date_lecture TIMESTAMP,
    normale BOOLEAN,
    valeurs_reference TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- ORDONNANCES
-- =============================================
CREATE TABLE IF NOT EXISTS ordonnances (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    consultation_id UUID REFERENCES consultations(id),
    carnet_id UUID NOT NULL REFERENCES carnets_medicaux(id) ON DELETE CASCADE,
    medecin_id UUID NOT NULL REFERENCES medecins(id),
    hopital_id UUID NOT NULL REFERENCES hopitaux(id),
    date_prescription TIMESTAMP NOT NULL,
    date_expiration TIMESTAMP,
    renouvelable BOOLEAN DEFAULT FALSE,
    nombre_renouvellements INTEGER DEFAULT 0,
    numero_ordonnance VARCHAR(50) UNIQUE,
    medicaments JSONB NOT NULL,
    instructions TEXT,
    posologie_detaillee TEXT,
    note_pharmacien TEXT,
    status VARCHAR(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'EXPIREE', 'ANNULEE')),
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- CONSENTS DIAGNOSTIC HÔPITAL
-- =============================================
CREATE TABLE IF NOT EXISTS consents_diagnostic_hopital (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    consultation_id UUID NOT NULL REFERENCES consultations(id),
    medecin_id UUID NOT NULL REFERENCES medecins(id),
    hopital_id UUID NOT NULL REFERENCES hopitaux(id),
    motif_demande TEXT,
    demande_par_medecin TIMESTAMP NOT NULL,
    approuve_par_manager BOOLEAN DEFAULT FALSE,
    manager_id UUID REFERENCES users(id),
    date_approuvation TIMESTAMP,
    motif_refus TEXT,
    date_expiration TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- ABONNEMENTS
-- =============================================
CREATE TABLE IF NOT EXISTS abonnements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    plan VARCHAR(20) NOT NULL CHECK (plan IN ('BASIQUE', 'PREMIUM', 'ENTREPRISE')),
    montant DECIMAL(10, 2),
    periode VARCHAR(10) CHECK (periode IN ('MENSUEL', 'ANNUEL')),
    date_debut TIMESTAMP NOT NULL,
    date_fin TIMESTAMP NOT NULL,
    statut VARCHAR(10) DEFAULT 'ACTIF' CHECK (statut IN ('ACTIF', 'EXPIRE', 'ANNULE')),
    moyen_paiement VARCHAR(100),
    reference_paiement VARCHAR(100),
    renouvellement_automatique BOOLEAN DEFAULT TRUE,
    note TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- AUDIT LOGS
-- =============================================
CREATE TABLE IF NOT EXISTS audit_logs (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    user_email VARCHAR(255),
    user_role VARCHAR(30),
    action VARCHAR(100) NOT NULL,
    entite_type VARCHAR(50),
    entite_id UUID,
    ancien_valeur JSONB,
    nouvelle_valeur JSONB,
    ip_address VARCHAR(50),
    user_agent TEXT,
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- SESSIONS
-- =============================================
CREATE TABLE IF NOT EXISTS sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token_hash VARCHAR(255) NOT NULL,
    refresh_token_hash VARCHAR(255),
    expire_at TIMESTAMP NOT NULL,
    refresh_expire_at TIMESTAMP,
    derniere_activite TIMESTAMP DEFAULT NOW(),
    appareil VARCHAR(255),
    ip_address VARCHAR(50),
    invalide BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- =============================================
-- INDEX POUR PERFORMANCES
-- =============================================
CREATE INDEX idx_patients_user_id ON patients(user_id);
CREATE INDEX idx_patients_numero_carnet ON patients(numero_carnet);
CREATE INDEX idx_medecins_user_id ON medecins(user_id);
CREATE INDEX idx_medecins_status ON medecins(status);
CREATE INDEX idx_carnets_patient_id ON carnets_medicaux(patient_id);
CREATE INDEX idx_consultations_carnet_id ON consultations(carnet_id);
CREATE INDEX idx_consultations_medecin_id ON consultations(medecin_id);
CREATE INDEX idx_consultations_date ON consultations(date_consultation DESC);
CREATE INDEX idx_allergies_carnet_id ON allergies(carnet_id);
CREATE INDEX idx_examens_carnet_id ON examens(carnet_id);
CREATE INDEX idx_ordonnances_carnet_id ON ordonnances(carnet_id);
CREATE INDEX idx_ordonnances_numero ON ordonnances(numero_ordonnance);
CREATE INDEX idx_approbations_carnet_medecin ON approbations_medecins(carnet_id, medecin_id);
CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at DESC);
CREATE INDEX idx_sessions_token_hash ON sessions(token_hash);
CREATE INDEX idx_sessions_user_id ON sessions(user_id);

-- =============================================
-- SEED – Compte Admin par défaut
-- =============================================
INSERT INTO users (id, email, mot_de_passe_hash, role, nom_complet, email_verifie, compte_actif)
VALUES (
    gen_random_uuid(),
    'admin@cscm.app',
    '$2a$12$LQv3c1yqBWVHxkd0LHAkCOyz7Tg4T7g4.Uu3nCZWnF3/1mE5v1Ea2',  -- password: Admin@123
    'ADMIN',
    'Administrateur CSCM',
    TRUE,
    TRUE
) ON CONFLICT (email) DO NOTHING;

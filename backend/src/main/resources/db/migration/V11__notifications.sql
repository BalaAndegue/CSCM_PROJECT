-- =============================================
-- V11 – Système de notifications temps réel
-- SSE (Server-Sent Events) + FCM push Android
-- =============================================

CREATE TABLE IF NOT EXISTS notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    destinataire_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    emetteur_id UUID REFERENCES users(id) ON DELETE SET NULL,

    type_notification VARCHAR(50) NOT NULL CHECK (type_notification IN (
        'DEMANDE_ACCES_QR','DEMANDE_ACCES_CODE',
        'ACCES_ACCORDE','ACCES_REVOQUE','ACCES_EXPIRE',
        'MEDECIN_PERSONNEL_ASSIGNE','MEDECIN_PERSONNEL_RETIRE',
        'NOUVELLE_ORDONNANCE','NOUVEL_EXAMEN',
        'RESULTAT_EXAMEN_DISPONIBLE','NOUVELLE_CONSULTATION',
        'INSCRIPTION_MEDECIN_VALIDEE','INSCRIPTION_MEDECIN_REJETEE',
        'DOCUMENT_VALIDE','DOCUMENT_REJETE','DOCUMENT_EXPIRE_BIENTOT',
        'COMPTE_CREE','RAPPEL_RDV','ALERTE_SECURITE','MESSAGE_ADMIN'
    )),

    titre VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,

    -- Données contextuelles additionnelles en JSON
    donnees_json TEXT,

    lue BOOLEAN DEFAULT FALSE,
    date_lecture TIMESTAMP,

    created_at TIMESTAMP DEFAULT NOW()
);

-- Index essentiels pour SSE (on charge les notifications non lues d'un utilisateur)
CREATE INDEX IF NOT EXISTS idx_notif_destinataire_nonlue
    ON notifications(destinataire_id, lue, created_at DESC)
    WHERE lue = FALSE;
CREATE INDEX IF NOT EXISTS idx_notif_destinataire
    ON notifications(destinataire_id, created_at DESC);

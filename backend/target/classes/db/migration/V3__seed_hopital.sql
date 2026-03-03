-- =============================================
-- CSCM V3 – Seed hôpital de test
-- =============================================

-- Hôpital Central de Test (utilisé pour les consultations et ordonnances)
INSERT INTO hopitaux (id, nom, adresse, telephone, email, numero_agrement, description, status)
VALUES (
    'a0000000-0000-0000-0000-000000000001',
    'Hôpital Central de Yaoundé',
    '1 Avenue de l''Hôpital, Yaoundé, Cameroun',
    '+237 222 23 40 00',
    'info@hcy.cm',
    'AGREE-CM-2024-001',
    'Hôpital de référence du Centre',
    'ACTIF'
) ON CONFLICT (numero_agrement) DO NOTHING;

-- Second hôpital
INSERT INTO hopitaux (id, nom, adresse, telephone, email, numero_agrement, description, status)
VALUES (
    'a0000000-0000-0000-0000-000000000002',
    'Clinique La Santé',
    '45 Rue de la Santé, Douala, Cameroun',
    '+237 233 42 10 00',
    'contact@clinique-sante.cm',
    'AGREE-CM-2024-002',
    'Clinique privée de Douala',
    'ACTIF'
) ON CONFLICT (numero_agrement) DO NOTHING;

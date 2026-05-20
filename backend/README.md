# CSCM Backend – Carnet de Santé Connecté et Mobile

API réactive pour la gestion des carnets de santé numériques au Cameroun, construite avec **Spring Boot 3.2 + WebFlux + R2DBC**.

---

## Stack Technologique

| Composant | Technologie |
|---|---|
| Langage | Java 17 |
| Framework | Spring Boot 3.2.3 – **WebFlux** (non-bloquant) |
| Persistance | Spring Data **R2DBC** + PostgreSQL 15+ |
| Migrations | Flyway (V1 → V12) |
| Sécurité | Spring Security WebFlux – JWT (JJWT 0.12.3) |
| QR Code | ZXing 3.5.3 |
| Temps réel | SSE (Server-Sent Events) + WebSocket réactif |
| Messaging | Redis pub/sub (ReactiveRedisTemplate) |
| Documentation | SpringDoc OpenAPI 2.3 (Swagger UI WebFlux) |
| Génération code | Lombok + MapStruct |

---

## Architecture

```
com.cscm.backend
├── config/          # SecurityConfig (WebFlux), R2dbcConfig (converters enum), WebSocketConfig, OpenApiConfig
├── security/        # JwtAuthWebFilter, ReactiveUserDetailsService, JwtUtils
├── entity/          # Entités R2DBC (@Table, FK en UUID, pas d'objet imbriqué)
├── enums/           # 22 enums domaine (UserRole, MedecinStatus, TypeMedia, LienParente…)
├── repository/      # R2dbcRepository<T, UUID> – retournent Mono<T> / Flux<T>
├── service/         # Logique métier entièrement réactive (flatMap, Mono.zip)
├── controller/      # Endpoints WebFlux – Mono<ResponseEntity<ApiResponse<?>>>
├── websocket/       # ConsultationWsHandler – sessions temps réel
├── exception/       # GlobalErrorWebExceptionHandler (@Order(-2))
├── aspect/          # AuditAspect (WebFilter réactif – fire-and-forget)
├── job/             # AutoRevocationJob (@Scheduled – subscribe sur Mono)
├── dto/             # Request / Response DTOs
└── mapper/          # MapStruct (sans référence objet imbriqué)
```

### Choix architectural clé : R2DBC

Les entités n'ont **pas** de relations objet (`@ManyToOne`, `@OneToMany`).
Les clés étrangères sont stockées comme champs `UUID` simples :

```java
// Correct R2DBC
private UUID carnetId;
private UUID medecinId;

// Incorrect (JPA uniquement)
// private CarnetMedical carnet;
```

Les listes JSON (médicaments, diplômes) sont stockées en `String` sérialisée.

---

## Rôles et Droits

| Rôle | Droits |
|---|---|
| `PATIENT` | Consulte son carnet, génère QR/code d'accès, gère garant et allergies |
| `MEDECIN` | Accède aux carnets après validation QR ou code court, crée consultations/ordonnances/examens |
| `MANAGER_HOPITAL` | Gère l'hôpital, valide les consentements diagnostics, rattache/détache des médecins |
| `ADMIN` | Valide les inscriptions CNOM/MINSANTE, suspend médecins, accès complet plateforme |

### Système d'accès au carnet (QR + code)

L'accès d'un médecin au carnet d'un patient suit ce flux :

```
Patient génère → QR code (15 min) ou code 6 chiffres (30 min)
                         ↓
Médecin scanne/saisit → TokenAccesMedecin validé → ApprobationMedecin créée
                         ↓
Médecin accède au carnet selon les permissions accordées
(historique, ordonnances, examens, édition)
```

Le **médecin traitant** bénéficie d'un accès permanent sans token.

### Règles d'inscription obligatoires (Cameroun)

- **Patient** : CNI obligatoire + garant (nom complet, téléphone, lien de parenté)
- **Médecin** : Numéro CNOM (Conseil National de l'Ordre des Médecins) + CNI obligatoires — statut `EN_ATTENTE` jusqu'à validation ADMIN

---

## Modèle de Données

### Entités principales

| Entité | Description |
|---|---|
| `User` | Compte utilisateur (email, rôle, matricule) |
| `Patient` | Profil patient + CNI + garant obligatoires |
| `Medecin` | Profil médecin + CNOM + spécialité + région Cameroun |
| `CarnetMedical` | Dossier de santé central du patient |
| `Consultation` | Séance médicale (diagnostic, notes, vitaux) |
| `Allergie` | Allergie avec gravité et statut actif |
| `Examen` | Prescription d'examen + résultats |
| `Ordonnance` | Prescription médicale (médicaments JSON) |
| `ApprobationMedecin` | Autorisation d'accès médecin ↔ carnet |
| `TokenAccesMedecin` | Token QR/code court d'accès temporaire |
| `MediaFichier` | Fichier médical (image, PDF, vidéo) avec checksum SHA-256 |
| `DocumentValidation` | Document CNOM/MINSANTE pour validation médecin |
| `MedecinPersonnel` | Relation permanente médecin traitant ↔ patient |
| `Notification` | Notification push SSE |
| `ConsentDiagnosticHopital` | Autorisation de diagnostic hospitalier |
| `Hopital` | Établissement de santé avec matricule unique |
| `AuditLog` | Journal des actions mutable (POST/PUT/DELETE) |

### Migrations Flyway

| Migration | Contenu |
|---|---|
| V1 | Schéma initial |
| V2 | Garant + expiration |
| V3-V4 | Données de seed |
| V5 | Identité patient renforcée (CNI, garant) |
| V6 | Champs médecin Cameroun (CNOM, régions) |
| V7 | Table `token_acces_medecin` |
| V8 | Table `media_fichier` |
| V9 | Table `document_validation` |
| V10 | Table `medecin_personnel` |
| V11 | Table `notifications` |
| V12 | Séquences matricules + index |

---

## Sécurité

### JWT

Le token JWT encode trois claims personnalisés :

```json
{
  "sub": "user@email.com",
  "userId": "uuid-du-user",
  "role": "PATIENT",
  "matricule": "CM-26-000001"
}
```

Le filtre `JwtAuthWebFilter` extrait `userId` comme principal Spring Security.
Les controllers injectent donc `@AuthenticationPrincipal String userIdStr`.

### Converters R2DBC

R2DBC ne mappe pas les enums automatiquement. `R2dbcConfig` déclare 44 converters explicites (`@ReadingConverter` / `@WritingConverter`) pour les 22 enums du domaine.

---

## Endpoints principaux

| Méthode | Endpoint | Rôle | Description |
|---|---|---|---|
| POST | `/api/auth/register/patient` | Public | Inscription patient (CNI + garant obligatoires) |
| POST | `/api/auth/register/medecin` | Public | Inscription médecin (CNOM + CNI obligatoires) |
| POST | `/api/auth/login` | Public | Connexion → JWT |
| GET | `/api/carnets/me` | PATIENT | Mon carnet médical |
| GET | `/api/carnets/{id}/summary` | Auth | Résumé carnet (consultations + allergies) |
| GET | `/api/acces/qr/{carnetId}` | PATIENT | Génère QR code PNG (15 min) |
| GET | `/api/acces/code/{carnetId}` | PATIENT | Génère code 6 chiffres (30 min) |
| POST | `/api/acces/valider/qr` | MEDECIN | Valide QR et obtient accès |
| POST | `/api/acces/valider/code` | MEDECIN | Valide code court et obtient accès |
| GET | `/api/notifications/stream` | Auth | Flux SSE temps réel |
| WS | `/ws/consultation` | Auth | Session WebSocket consultation |
| GET | `/api/medias/carnet/{id}` | Auth | Médias d'un carnet |
| POST | `/api/medias/carnet/{id}` | MEDECIN | Upload fichier médical |
| GET | `/api/dashboard/patient` | PATIENT | Tableau de bord patient |
| GET | `/api/dashboard/admin` | ADMIN | Statistiques plateforme |

Documentation complète : **`http://localhost:8080/api/swagger-ui.html`**

---

## Démarrage

### Prérequis

- Java 17+
- Maven 3.8+
- PostgreSQL 15+ (JDBC pour Flyway + R2DBC pour l'API)
- Redis (notifications SSE cross-instance)

### Variables d'environnement

```bash
# Base de données
DB_HOST=localhost
DB_PORT=5432
DB_NAME=cscm_db
DB_USERNAME=postgres
DB_PASSWORD=secret

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379

# JWT
JWT_SECRET=votre-clé-secrète-256-bits-minimum
JWT_EXPIRATION=86400000

# Stockage fichiers
APP_STORAGE_ROOT_PATH=./uploads
```

### Lancer en développement

```bash
cd backend
mvn spring-boot:run
```

Flyway exécute automatiquement les migrations V1→V12 au démarrage.

### Compiler (sans tests)

```bash
mvn clean package -DskipTests
```

### Swagger UI

```
http://localhost:8080/api/swagger-ui.html
```

Cliquez **Authorize**, entrez `Bearer <votre_token_jwt>` pour tester les endpoints protégés.

---

## Temps réel

### SSE (Server-Sent Events)

```
GET /api/notifications/stream
Authorization: Bearer <token>
Accept: text/event-stream
```

Chaque instance de l'application publie sur Redis (`cscm:notif:{userId}`) et diffuse aux clients connectés localement via `Sinks.Many<ServerSentEvent<String>>`.

### WebSocket

```
WS /ws/consultation
```

Messages JSON supportés : `JOIN_CONSULTATION`, `LEAVE_CONSULTATION`, `MESSAGE`, `VITALS_UPDATE`, `PING`.

# CSCM Backend – Carnet de Santé Connecté et Mobile

Ce projet contient l'API RESTful du système CSCM, un carnet de santé numérique sécurisé, développé avec **Spring Boot**.

## 🏗 Architecture Technique

Le backend est structuré selon une architecture en couches classique de Spring Boot :

- **Controllers** (`com.cscm.backend.controller`) : Points d'entrée de l'API REST. Ils gèrent la validation des requêtes HTTP et délègent la logique métier aux différents *Services*.
- **Services** (`com.cscm.backend.service`) : Contiennent toute la logique métier complexe, la vérification des droits inter-composants et la manipulation des données avant de les persister.
- **Repositories** (`com.cscm.backend.repository`) : Interfaces Spring Data JPA pour l'accès à la base de données PostgreSQL.
- **Entities** (`com.cscm.backend.entity`) : Modèles de données représentant les tables de la base (ex: `Patient`, `Medecin`, `CarnetMedical`, `Consultation`, etc.).
- **Security** (`com.cscm.backend.security`) : Contient la configuration de sécurité (JWT), le filtre d'authentification et l'extraction des identités.
- **DTOs & Mappers** (`com.cscm.backend.dto`, `com.cscm.backend.mapper`) : Objets de transfert de données et leurs convertisseurs pour ne pas exposer directement les entités de la base de données via l'API, ce qui assure la sécurité et l'abstraction.
- **Exception Handling** (`com.cscm.backend.exception`) : Gestion globale et centralisée des erreurs de l'application via un `@RestControllerAdvice`.
- **Jobs & Aspect** (`com.cscm.backend.job`, `com.cscm.backend.aspect`) : CRON jobs pour les tâches régulières (comme la révocation des accès) et AOP pour la journalisation automatique et transparente des actions (AuditLog).

## 🔐 Logique de Sécurité et Rôles

Le système utilise une authentification stateless basée sur **JSON Web Tokens (JWT)**.
Il existe quatre rôles d'utilisateurs distincts :

1. `PATIENT` : Peut consulter son propre carnet médical, ses ordonnances, et approuver/révoquer l'accès aux médecins.
2. `MEDECIN` : Peut consulter les carnets des patients qui lui ont donné l'accès (ou validés par un garant), ajouter des consultations, prescrire des examens et ordonnances.
3. `MANAGER_HOPITAL` : Gère un établissement de santé, gère les médecins rattachés à son hôpital et valide les consentements de diagnostics globaux.
4. `ADMIN` : Dispose d'un accès global (statistiques, validation de profils médecins, désactivation de comptes).

### 🩺 Accès au Carnet Médical (Consentement)
L'accès aux données médicales d'un patient est hautement protégé :
Un médecin ne peut lire ou modifier un carnet médical que s'il a été **approuvé** (entité `ApprobationMedecin`) soit directement par le patient concerné, soit par son **Garant** légal. Une validation par un garant expire et est automatiquement révoquée après 24h par le système.

## ⚙️ Pile Technologique (Stack)

- **Java 17**
- **Spring Boot 3.2.x** (Web, Data JPA, Security, Mail, Validation, Actuator, AOP)
- **PostgreSQL 15+** (Base de données relationnelle)
- **Flyway** (Gestion des migrations du schéma de base de données)
- **MapStruct & Lombok** (Génération de code boilerplate)
- **Swagger / OpenAPI 3** (Documentation interactive de l'API)
- **JJWT** (Génération et validation des tokens JWT)

## 🗃️ Modèle de Données Principal (Entities)

L'application gravite autour des concepts suivants :
- **Utilisateur & Rôles** (`User`, `Patient`, `Medecin`, `Manager`)
- **Établissements** (`Hopital`, `MedecinHopital`)
- **Dossier Patient** : Le `CarnetMedical` centralise l'historique de santé complet du patient.
- **Soins & Visites** : `Consultation`, `Allergie`, `Examen`, `ResultatExamen`, `Ordonnance`.
- **Droits & Accès** : `ApprobationMedecin`, `ConsentDiagnosticHopital`.
- **Plateforme** : `Abonnement`, `AuditLog`.

## 🚀 Démarrage Rapide

### Prérequis
- Java 17+
- Maven 3.8+
- Base de données PostgreSQL

### Commandes utiles

1. **Configurer la base de données :**
Assurez-vous d'avoir une instance PostgreSQL démarrée  et créez la base de données via PostgreSQL ou le `docker-compose.yml` présent à la racine du projet. 
Les identifiants sont configurables via variables d'environnement dans `src/main/resources/application.yml`.

2. **Lancer l'application en développement :**
```bash
cd backend
mvn spring-boot:run
```
*Note: Flyway créera ou mettra à jour automatiquement le schéma SQL au démarrage de l'application en exécutant les fichiers à l'intérieur de `src/main/resources/db/migration/`.*

3. **Compiler le package (sans exécuter les tests) :**
```bash
mvn clean package -DskipTests
```

### 📖 Documentation de l'API (Swagger)
Une fois l'application démarrée, parcourez les endpoints, testez l'API directement via l'interface web et consultez les requêtes attendues :
👉 **[http://localhost:8080/api/swagger-ui/index.html](http://localhost:8080/api/swagger-ui/index.html)**

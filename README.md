
<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com/?lines=Carnet+Sante+CM;Digital+Health+Cameroun;80%+vies+sauvees;Pilote+Hopital;INES+%2B+USSD;500FCFA/mois&font=Fira%20Code&center=true&pause=1000&size=28"/>
</div>

<p align="center">
  <img alt="License" src="https://img.shields.io/github/license/balaandeguefrancoislionnel/carnet-sante-cm?color=blueviolet&style=flat-square">
  <img alt="Next.js" src="https://img.shields.io/badge/Next.js-15.0-00D4AA?style=flat-square&logo=next.js&logoColor=white"/>
  <img alt="Spring Boot" src="https://img.shields.io/badge/Spring%20Boot-3.3-6DB33F?style=flat-square&logo=spring&logoColor=white"/>
  <img alt="PostgreSQL" src="https://img.shields.io/badge/PostgreSQL-17-4169E1?style=flat-square&logo=postgresql&logoColor=white"/>
  <img alt="Status" src="https://img.shields.io/badge/Status-Prototype%20Avance-blue?style=flat-square&logo=gitbook"/>
</p>

# 🩺 Carnet Santé CM - Carnet Médical Numérique Camerounais

**Carnet de santé digital unifié via INES biométrique + USSD *123# pour sauver des vies en urgence**

> **Problème critique** : 80% des décès évitables à l'Hôpital Jamot = **carnet papier perdu**. **Solution** : QR Code scanné → **Allergies + Diabète + Groupe sanguin visibles en 30s**.

## 🛠️ Tech Stack Professionnel

### 🎨 Frontend
| Technologie | Version | Raison |
|-------------|---------|---------|
| **Next.js** | `15.0.0` | SSR + PWA offline-first + App Router |
| **TypeScript** | `5.6.2` | Typosafety + IDE intelligence |
| **Tailwind CSS** | `3.4.10` | Design système cohérent |
| **shadcn/ui** | `latest` | Composants accessibles |
| **Zustand** | `5.0.0-rc.2` | State management léger |
| **React Query** | `5.52.0` | Cache + Sync offline |

### ⚙️ Backend
| Technologie | Version | Raison |
|-------------|---------|---------|
| **Spring Boot** | `3.3.4` | Entreprise-grade + HL7/FHIR natif |
| **Spring Security** | `6.3.3` | OAuth2 + JWT + INES |
| **Spring Data JPA** | `3.3.4` | PostgreSQL + TimescaleDB |
| **Spring AI** | `1.0.0-M6` | Prédictions palu/diabète |
| **HAPI FHIR** | `6.10.4` | Interop Hôpital Jamot |

### 🗄️ Infrastructure
| Service | Fournisseur | Configuration |
|---------|-------------|---------------|
| **Base de données** | PostgreSQL 17 + TimescaleDB | OVH Yaoundé HDS |
| **Stockage** | MinIO S3 | Fichiers analyses chiffrés |
| **Auth** | Keycloak 26.0 | OAuth2 + Biométrie |
| **Cache** | Redis 8.0 | Sessions + USSD |
| **Monitoring** | Prometheus + Grafana | 99.9% uptime |

### 📱 Intégrations Tiers
| Service | API | Usage |
|---------|-----|-------|
| **INES** | DGSN/MINMAP | Identité biométrique |
| **USSD** | FurtherMarket | MTN/Orange/Camtel |
| **Paiement** | Orange Money API | 500FCFA/mois |
| **HL7/FHIR** | Hôpital Jamot | Interop standards |

## 🏗️ Architecture Système

```mermaid
graph TB
    subgraph "📱 Frontend (Next.js 15)"
        P[Patient App<br/>PWA Offline]
        D[Docteur Dashboard<br/>HL7/FHIR]
    end
    
    subgraph "🔒 API Gateway (Spring Boot 3.3)"
        API[REST + GraphQL<br/>Rate Limiting]
        AUTH[Keycloak + INES<br/>Biométrie]
    end
    
    subgraph "🗄️ Data Layer"
        DB[(PostgreSQL 17<br/>TimescaleDB)]
        S3[(MinIO HDS<br/>Chiffré E2E)]
        R[Redis 8.0<br/>Cache Sessions]
    end
    
    subgraph "🌐 Tiers"
        U[USSD *123#<br/>MTN/Orange]
        I[INES API<br/>DGSN]
        H[HL7/FHIR<br/>Hôpital Jamot]
    end
    
    P --> API
    D --> API
    U --> API
    I --> AUTH
    H <--> API
    API --> DB
    API --> S3
    API --> R
    AUTH --> API
    
    classDef frontend fill:#00D4AA
    classDef backend fill:#6DB33F
    classDef data fill:#4169E1
    classDef tiers fill:#FF6B6B
    class P,D frontend
    class API,AUTH backend
    class DB,S3,R data
    class U,I,H tiers
```

## 🚀 Quick Start Local

```bash
# 0. Clone & Structure
git clone https://github.com/balaandeguefrancoislionnel/carnet-sante-cm.git
cd carnet-sante-cm

# 1. Backend (Spring Boot)
cd backend
./mvnw spring-boot:run

# 2. Frontend (Next.js)
cd ../frontend
cp .env.example .env.local
npm install
npm run dev

# 3. USSD Simulator
docker compose up -d ussd redis postgres minio

# 4. Accès
# Frontend: http://localhost:3000
# Backend: http://localhost:8080/swagger-ui.html
# Admin: http://localhost:8081 (Keycloak)
```

## 📋 Structure Dossiers

```
carnet-sante-cm/
├── backend/                 # Spring Boot 3.3
│   ├── src/main/java/cm/sante/
│   ├── src/main/resources/
│   │   └── schema.sql      # DB Schema complet
│   └── pom.xml
├── frontend/                # Next.js 15
│   ├── app/                # App Router
│   ├── components/ui/      # shadcn/ui
│   ├── lib/utils.ts
│   └── next.config.js
├── docs/                   # Architecture + Specs
│   ├── api.drawio.png
│   ├── ussd-flow.png
│   └── hl7-fhir-profile.json
├── docker-compose.yml      # Full stack local
└── README.md
```

## 🎯 Roadmap Production

| Phase | Durée | Livrable | Statut |
|-------|-------|----------|--------|
| Sprint 1 | 2 sem | DB + Spring Boot APIs | ✅ Done |
| Sprint 2 | 3 sem | Next.js PWA + Keycloak | 🔄 Progress |
| Sprint 3 | 2 sem | USSD MTN + INES Mock | ⏳ Next |
| Sprint 4 | 2 sem | HL7/FHIR Hôpital Jamot | ⏳ Next |
| Sprint 5 | 4 sem | Pilote 100 patients | 🎯 Mars 2026 |

## 💼 Modèle Économique

```
Gratuit : Base (MINMAP subvention)
Premium : 500FCFA/mois (IA prédictive)
Hôpitaux : 50kFCFA/mois (interop HL7)
Marché : 5M utilisateurs CM + CEMAC
```

## 🤝 Contributeurs

<table>
<tr>
  <td align="center">
    <a href="https://github.com/balaandeguefrancoislionnel">
      <img src="https://avatars.githubusercontent.com/balaandeguefrancoislionnel" alt="François" width="100"/>
      <br>François Bala
      <br>Fullstack Lead
    </a>
  </td>
</tr>
</table>

## 📄 License
MIT © [François Bala Andegue](https://github.com/balaandeguefrancoislionnel) - **Africa Digital ID Hackathon 2026**

---

<div align="center">
  <strong>500FCFA/mois = 1 vie sauvée 🚑🇨🇲</strong>
</div>
```


package com.cscm.backend.entity;

import com.cscm.backend.enums.HopitalStatus;
import com.cscm.backend.enums.RegionCameroun;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

@Table("hopitaux")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Hopital {

    @Id
    private UUID id;

    @Column("nom")
    private String nom;

    @Column("adresse")
    private String adresse;

    @Column("telephone")
    private String telephone;

    @Column("email")
    private String email;

    @Column("site_web")
    private String siteWeb;

    /** Numéro d'agrément MINSANTE (Ministère Santé Publique Cameroun) */
    @Column("numero_agrement")
    private String numeroAgrement;

    /** Matricule unique CSCM: CSCM-HOP-XXXXX */
    @Column("matricule")
    private String matricule;

    @Column("description")
    private String description;

    @Column("nombre_lits")
    private Integer nombreLits;

    @Builder.Default
    @Column("status")
    private HopitalStatus status = HopitalStatus.ACTIF;

    /** FK → users.id (manager de l'établissement) */
    @Column("manager_id")
    private UUID managerId;

    @Column("logo")
    private String logo;

    @Column("localisation_gps")
    private String localisationGps;

    /** Région du Cameroun */
    @Column("region")
    private RegionCameroun region;

    @Column("ville")
    private String ville;

    @Column("arrondissement")
    private String arrondissement;

    /** CHU, CHR, HD, HGE, Clinique, Centre de Santé, etc. */
    @Column("type_etablissement")
    private String typeEtablissement;

    @Column("urgences_24h")
    @Builder.Default
    private Boolean urgences24h = false;

    @Column("maternite")
    @Builder.Default
    private Boolean maternite = false;

    /** Documents de validation uploadés et approuvés */
    @Column("documents_valides")
    @Builder.Default
    private Boolean documentsValides = false;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column("updated_at")
    private LocalDateTime updatedAt;
}

package com.cscm.backend.entity;

import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * @deprecated Remplacé par {@link MediaFichier} pour les médias médicaux
 * et {@link DocumentValidation} pour les documents de validation.
 * Conservé pour rétrocompatibilité des migrations existantes.
 */
@Deprecated
@Table("documents")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Document {

    @Id
    private UUID id;

    @Column("carnet_id")
    private UUID carnetId;

    @Column("uploaded_by")
    private UUID uploadedBy;

    @Column("nom_fichier")
    private String nomFichier;

    @Column("nom_original")
    private String nomOriginal;

    @Column("type_mime")
    private String typeMime;

    @Column("taille")
    private Long taille;

    @Column("chemin_stockage")
    private String cheminStockage;

    @Column("type_document")
    private String typeDocument;

    @Builder.Default
    @Column("chiffre")
    private Boolean chiffre = false;

    @Column("description")
    private String description;

    @Column("entite_type")
    private String entiteType;

    @Column("entite_id")
    private UUID entiteId;

    @Builder.Default
    @Column("actif")
    private Boolean actif = true;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

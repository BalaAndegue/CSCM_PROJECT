package com.cscm.backend.entity;

import com.cscm.backend.enums.TypeMedia;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Fichier multimédia constituant le dossier médical numérique.
 * Couvre tous les types de médias médicaux (images, PDF, vidéos, audio).
 *
 * Remplace l'entité Document originale avec une gestion typée et sécurisée.
 */
@Table("medias_fichiers")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class MediaFichier {

    @Id
    private UUID id;

    /** FK → carnets_medicaux.id */
    @Column("carnet_id")
    private UUID carnetId;

    /** FK → users.id (qui a uploadé) */
    @Column("uploaded_by")
    private UUID uploadedBy;

    @Column("type_media")
    private TypeMedia typeMedia;

    @Column("nom_original")
    private String nomOriginal;

    /** Nom UUID sur le disque, ex: 550e8400-e29b-41d4-a716-446655440000.pdf */
    @Column("nom_stockage")
    private String nomStockage;

    @Column("chemin_stockage")
    private String cheminStockage;

    /** URL publique ou signée pour accéder au fichier */
    @Column("url_acces")
    private String urlAcces;

    @Column("type_mime")
    private String typeMime;

    @Column("taille_fichier")
    private Long tailleFichier;

    /** SHA-256 du fichier pour vérification d'intégrité */
    @Column("checksum")
    private String checksum;

    // =========================================
    // ENTITÉS LIÉES (optionnel)
    // =========================================

    /** FK → consultations.id */
    @Column("consultation_id")
    private UUID consultationId;

    /** FK → examens.id */
    @Column("examen_id")
    private UUID examenId;

    /** FK → ordonnances.id */
    @Column("ordonnance_id")
    private UUID ordonnanceId;

    // =========================================
    // MÉTADONNÉES
    // =========================================

    @Column("description")
    private String description;

    /** Fichier visible uniquement au patient + son médecin traitant */
    @Builder.Default
    @Column("confidentiel")
    private Boolean confidentiel = false;

    @Builder.Default
    @Column("actif")
    private Boolean actif = true;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

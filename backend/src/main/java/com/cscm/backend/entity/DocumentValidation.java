package com.cscm.backend.entity;

import com.cscm.backend.enums.StatutDocument;
import com.cscm.backend.enums.TypeDocumentValidation;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Document de validation pour les médecins et les hôpitaux.
 *
 * Processus :
 * 1. Médecin/hôpital uploade son document
 * 2. Statut → UPLOADE
 * 3. Un admin vérifie et valide/rejette
 * 4. Statut → VALIDE ou REJETE
 *
 * Un médecin ne peut exercer sur la plateforme que si tous
 * ses documents obligatoires sont au statut VALIDE.
 */
@Table("documents_validation")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class DocumentValidation {

    @Id
    private UUID id;

    /**
     * ID du propriétaire du document.
     * FK → medecins.id OU hopitaux.id selon proprietaireType.
     */
    @Column("proprietaire_id")
    private UUID proprietaireId;

    /** "MEDECIN" | "HOPITAL" */
    @Column("proprietaire_type")
    private String proprietaireType;

    @Column("type_document")
    private TypeDocumentValidation typeDocument;

    @Builder.Default
    @Column("statut")
    private StatutDocument statut = StatutDocument.EN_ATTENTE_UPLOAD;

    // =========================================
    // FICHIER
    // =========================================

    @Column("nom_original")
    private String nomOriginal;

    @Column("nom_stockage")
    private String nomStockage;

    @Column("chemin_stockage")
    private String cheminStockage;

    @Column("type_mime")
    private String typeMime;

    @Column("taille_fichier")
    private Long tailleFichier;

    @Column("checksum")
    private String checksum;

    // =========================================
    // VALIDATION ADMIN
    // =========================================

    /** FK → users.id (admin qui a validé/rejeté) */
    @Column("valide_par")
    private UUID validePar;

    @Column("date_validation")
    private LocalDateTime dateValidation;

    @Column("motif_rejet")
    private String motifRejet;

    @Column("commentaire_admin")
    private String commentaireAdmin;

    /** Date d'expiration du document (casier judiciaire 3 mois, etc.) */
    @Column("date_expiration_document")
    private LocalDate dateExpirationDocument;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column("updated_at")
    private LocalDateTime updatedAt;
}

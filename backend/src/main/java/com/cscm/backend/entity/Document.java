package com.cscm.backend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "documents")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Document {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "carnet_id")
    private CarnetMedical carnet;

    @Column(name = "uploaded_by", nullable = false)
    private UUID uploadedBy;

    @Column(name = "nom_fichier", nullable = false, length = 255)
    private String nomFichier;

    @Column(name = "nom_original", length = 255)
    private String nomOriginal;

    @Column(name = "type_mime", length = 100)
    private String typeMime;

    @Column(name = "taille")
    private Long taille;

    @Column(name = "chemin_stockage", length = 500)
    private String cheminStockage;

    @Column(name = "type_document", length = 100)
    private String typeDocument; // resultat_examen, ordonnance, rapport...

    @Builder.Default
    @Column(name = "chiffre")
    private Boolean chiffre = false;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "entite_type", length = 50)
    private String entiteType; // examen, consultation, ordonnance...

    @Column(name = "entite_id")
    private UUID entiteId;

    @Builder.Default
    @Column(name = "actif")
    private Boolean actif = true;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

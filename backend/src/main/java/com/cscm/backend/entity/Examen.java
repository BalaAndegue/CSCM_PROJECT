package com.cscm.backend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "examens")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Examen {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "carnet_id", nullable = false)
    private CarnetMedical carnet;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_prescripteur")
    private Medecin medecinPrescripteur;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;

    @Column(name = "type_examen", nullable = false, length = 255)
    private String typeExamen;

    @Column(name = "categorie_examen", length = 100)
    private String categorieExamen; // biologie, imagerie, fonctionnel...

    @Column(columnDefinition = "TEXT")
    private String instructions;

    @Column(name = "date_prescription")
    private LocalDateTime datePrescription;

    @Column(name = "date_realisation")
    private LocalDateTime dateRealisation;

    @Column(name = "etablissement_realisation", length = 255)
    private String etablissementRealisation;

    @Builder.Default
    @Column(name = "resultat_pris_en_compte")
    private Boolean resultatPrisEnCompte = false;

    @Builder.Default
    @Column(name = "urgent")
    private Boolean urgent = false;

    @Column(columnDefinition = "TEXT")
    private String notes;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

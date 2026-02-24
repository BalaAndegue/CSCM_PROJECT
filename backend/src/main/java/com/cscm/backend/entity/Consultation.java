package com.cscm.backend.entity;

import com.cscm.backend.enums.GraviteConsultation;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "consultations")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Consultation {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "carnet_id", nullable = false)
    private CarnetMedical carnet;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_id", nullable = false)
    private Medecin medecin;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hopital_id")
    private Hopital hopital;

    @Column(name = "date_consultation", nullable = false)
    private LocalDateTime dateConsultation;

    @Column(columnDefinition = "TEXT")
    private String motif;

    @Column(columnDefinition = "TEXT")
    private String symptomes;

    @Column(columnDefinition = "TEXT")
    private String diagnostic;

    @Column(name = "traitement_recommande", columnDefinition = "TEXT")
    private String traitementRecommande;

    @Column(name = "suivi_recommande", columnDefinition = "TEXT")
    private String suiviRecommande;

    @Column(name = "duree_consultation_minutes")
    private Integer dureeConsultationMinutes;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private GraviteConsultation gravite;

    @Column(name = "prochaine_consultation")
    private LocalDateTime prochaineConsultation;

    @Column(name = "pression_arterielle", length = 20)
    private String pressionArterielle;

    @Column(name = "poids")
    private Double poids;

    @Column(name = "taille")
    private Double taille;

    @Column(name = "temperature")
    private Double temperature;

    @Column(name = "frequence_cardiaque")
    private Integer frequenceCardiaque;

    @Column(name = "notes_complementaires", columnDefinition = "TEXT")
    private String notesComplementaires;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

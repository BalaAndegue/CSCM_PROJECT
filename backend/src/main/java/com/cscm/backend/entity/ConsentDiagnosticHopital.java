package com.cscm.backend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "consents_diagnostic_hopital")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ConsentDiagnosticHopital {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id", nullable = false)
    private Consultation consultation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_id", nullable = false)
    private Medecin medecin;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hopital_id", nullable = false)
    private Hopital hopital;

    @Column(name = "motif_demande", columnDefinition = "TEXT")
    private String motifDemande;

    @Column(name = "demande_par_medecin", nullable = false)
    private LocalDateTime demandeParMedecin;

    @Builder.Default
    @Column(name = "approuve_par_manager")
    private Boolean approuveParManager = false;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "manager_id")
    private User manager;

    @Column(name = "date_approuvation")
    private LocalDateTime dateApprouvation;

    @Column(name = "motif_refus", columnDefinition = "TEXT")
    private String motifRefus;

    @Column(name = "date_expiration")
    private LocalDateTime dateExpiration;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

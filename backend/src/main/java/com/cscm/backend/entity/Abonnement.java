package com.cscm.backend.entity;

import com.cscm.backend.enums.AbonnementPeriode;
import com.cscm.backend.enums.AbonnementPlan;
import com.cscm.backend.enums.AbonnementStatut;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "abonnements")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Abonnement {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private AbonnementPlan plan;

    @Column(precision = 10, scale = 2)
    private BigDecimal montant;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private AbonnementPeriode periode;

    @Column(name = "date_debut", nullable = false)
    private LocalDateTime dateDebut;

    @Column(name = "date_fin", nullable = false)
    private LocalDateTime dateFin;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private AbonnementStatut statut = AbonnementStatut.ACTIF;

    @Column(name = "moyen_paiement", length = 100)
    private String moyenPaiement;

    @Column(name = "reference_paiement", length = 100)
    private String referencePaiement;

    @Builder.Default
    @Column(name = "renouvellement_automatique")
    private Boolean renouvellementAutomatique = true;

    @Column(name = "note", columnDefinition = "TEXT")
    private String note;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

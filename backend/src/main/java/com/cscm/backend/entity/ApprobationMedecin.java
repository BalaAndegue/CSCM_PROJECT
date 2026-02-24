package com.cscm.backend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "approbations_medecins",
        uniqueConstraints = @UniqueConstraint(columnNames = {"carnet_id", "medecin_id"}))
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ApprobationMedecin {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "carnet_id", nullable = false)
    private CarnetMedical carnet;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_id", nullable = false)
    private Medecin medecin;

    @Builder.Default
    @Column(name = "approuve_par_patient", nullable = false)
    private Boolean approuveParPatient = false;

    @Column(name = "date_signature_patient")
    private LocalDateTime dateSignaturePatient;

    @Column(name = "signature_patient", columnDefinition = "TEXT")
    private String signaturePatient;

    @Builder.Default
    @Column(name = "actif")
    private Boolean actif = true;

    @Column(name = "date_revocation")
    private LocalDateTime dateRevocation;

    @Column(name = "date_expiration")
    private LocalDateTime dateExpiration;

    @Builder.Default
    @Column(name = "approuve_par_garant", nullable = false)
    private Boolean approuveParGarant = false;

    @Column(name = "date_signature_garant")
    private LocalDateTime dateSignatureGarant;

    @Column(name = "signature_garant", columnDefinition = "TEXT")
    private String signatureGarant;

    @Column(name = "motif_revocation", columnDefinition = "TEXT")
    private String motifRevocation;

    @Column(name = "acces_historique")
    @Builder.Default
    private Boolean accesHistorique = false;

    @Column(name = "acces_ordonnances")
    @Builder.Default
    private Boolean accesOrdonnances = true;

    @Column(name = "acces_examens")
    @Builder.Default
    private Boolean acesExamens = true;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

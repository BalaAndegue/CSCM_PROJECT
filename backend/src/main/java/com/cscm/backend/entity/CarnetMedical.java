package com.cscm.backend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "carnets_medicaux")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class CarnetMedical {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @Builder.Default
    @Column(nullable = false)
    private Integer version = 1;

    @Builder.Default
    @Column(nullable = false, length = 20)
    private String statut = "actif";

    @Builder.Default
    @Column(name = "abonnement_actif")
    private Boolean abonnementActif = true;

    @Column(name = "date_expiration_abonnement")
    private LocalDate dateExpirationAbonnement;

    @Column(name = "notes_generales", columnDefinition = "TEXT")
    private String notesGenerales;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}

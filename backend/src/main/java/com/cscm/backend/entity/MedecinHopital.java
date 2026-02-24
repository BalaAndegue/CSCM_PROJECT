package com.cscm.backend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "medecin_hopital",
        uniqueConstraints = @UniqueConstraint(columnNames = {"medecin_id", "hopital_id"}))
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class MedecinHopital {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_id", nullable = false)
    private Medecin medecin;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hopital_id", nullable = false)
    private Hopital hopital;

    @Builder.Default
    @Column(name = "actif")
    private Boolean actif = true;

    @Column(name = "service", length = 100)
    private String service;

    @Column(name = "poste", length = 100)
    private String poste;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

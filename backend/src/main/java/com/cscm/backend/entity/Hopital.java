package com.cscm.backend.entity;

import com.cscm.backend.enums.HopitalStatus;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "hopitaux")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Hopital {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false, length = 255)
    private String nom;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String adresse;

    @Column(length = 20)
    private String telephone;

    @Column(length = 255)
    private String email;

    @Column(name = "site_web", length = 255)
    private String siteWeb;

    @Column(name = "numero_agrement", unique = true, nullable = false, length = 100)
    private String numeroAgrement;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "nombre_lits")
    private Integer nombreLits;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private HopitalStatus status = HopitalStatus.ACTIF;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "manager_id")
    private User manager;

    @Column(name = "logo")
    private String logo;

    @Column(name = "localisation_gps", length = 100)
    private String localisationGps;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

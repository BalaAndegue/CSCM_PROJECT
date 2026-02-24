package com.cscm.backend.entity;

import com.cscm.backend.enums.MedecinStatus;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "medecins")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Medecin {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", unique = true)
    private User user;

    @Column(name = "numero_ordre", unique = true, nullable = false, length = 50)
    private String numeroOrdre;

    @Column(nullable = false, length = 255)
    private String specialite;

    @Column(name = "sous_specialite", length = 255)
    private String sousSpecialite;

    @Column(name = "numero_carte_professionnelle", unique = true, length = 100)
    private String numeroCarteProfessionnelle;

    @Column(name = "annees_experience")
    @Builder.Default
    private Integer anneesExperience = 0;

    @ElementCollection
    @CollectionTable(name = "medecin_diplomes", joinColumns = @JoinColumn(name = "medecin_id"))
    @Column(name = "diplome")
    private List<String> diplomes;

    @Column(name = "biographie", columnDefinition = "TEXT")
    private String biographie;

    @Column(name = "photo_identite")
    private String photoIdentite;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private MedecinStatus status = MedecinStatus.EN_ATTENTE;

    @Column(name = "raison_rejet", columnDefinition = "TEXT")
    private String raisonRejet;

    @Column(name = "valide_par")
    private UUID validePar;

    @Column(name = "date_validation")
    private LocalDateTime dateValidation;

    @Column(name = "consultation_fee")
    private Double consultationFee;

    @Column(name = "disponible")
    @Builder.Default
    private Boolean disponible = true;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

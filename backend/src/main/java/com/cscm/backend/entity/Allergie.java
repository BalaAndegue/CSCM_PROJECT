package com.cscm.backend.entity;

import com.cscm.backend.enums.GraviteAllergie;
import com.cscm.backend.enums.TypeReactionAllergie;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "allergies")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Allergie {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "carnet_id", nullable = false)
    private CarnetMedical carnet;

    @Column(name = "nom_allergene", nullable = false, length = 255)
    private String nomAllergene;

    @Column(name = "type_allergene", length = 100)
    private String typeAllergene; // médicament, aliment, environnement...

    @Enumerated(EnumType.STRING)
    @Column(name = "type_reaction", nullable = false, length = 30)
    private TypeReactionAllergie typeReaction;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private GraviteAllergie gravite;

    @Column(name = "date_premiere_reaction")
    private LocalDate datePremierReaction;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "traitement_urgence", columnDefinition = "TEXT")
    private String traitementUrgence;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_notificateur")
    private Medecin medecinNotificateur;

    @Builder.Default
    @Column(name = "visible_tous_medecins")
    private Boolean visibleTousMedecins = true;

    @Builder.Default
    @Column(name = "active")
    private Boolean active = true;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

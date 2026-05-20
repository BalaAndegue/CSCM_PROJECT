package com.cscm.backend.entity;

import com.cscm.backend.enums.GraviteAllergie;
import com.cscm.backend.enums.TypeReactionAllergie;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Table("allergies")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Allergie {

    @Id
    private UUID id;

    /** FK → carnets_medicaux.id */
    @Column("carnet_id")
    private UUID carnetId;

    @Column("nom_allergene")
    private String nomAllergene;

    @Column("type_allergene")
    private String typeAllergene;

    @Column("type_reaction")
    private TypeReactionAllergie typeReaction;

    @Column("gravite")
    private GraviteAllergie gravite;

    @Column("date_premiere_reaction")
    private LocalDate datePremierReaction;

    @Column("description")
    private String description;

    @Column("traitement_urgence")
    private String traitementUrgence;

    /** FK → medecins.id */
    @Column("medecin_notificateur")
    private UUID medecinNotificateurId;

    @Builder.Default
    @Column("visible_tous_medecins")
    private Boolean visibleTousMedecins = true;

    @Builder.Default
    @Column("active")
    private Boolean active = true;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

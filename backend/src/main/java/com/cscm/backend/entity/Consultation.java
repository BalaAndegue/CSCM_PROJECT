package com.cscm.backend.entity;

import com.cscm.backend.enums.GraviteConsultation;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

@Table("consultations")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Consultation {

    @Id
    private UUID id;

    /** FK → carnets_medicaux.id */
    @Column("carnet_id")
    private UUID carnetId;

    /** FK → medecins.id */
    @Column("medecin_id")
    private UUID medecinId;

    /** FK → hopitaux.id */
    @Column("hopital_id")
    private UUID hopitalId;

    @Column("date_consultation")
    private LocalDateTime dateConsultation;

    @Column("motif")
    private String motif;

    @Column("symptomes")
    private String symptomes;

    @Column("diagnostic")
    private String diagnostic;

    @Column("traitement_recommande")
    private String traitementRecommande;

    @Column("suivi_recommande")
    private String suiviRecommande;

    @Column("duree_consultation_minutes")
    private Integer dureeConsultationMinutes;

    @Column("gravite")
    private GraviteConsultation gravite;

    @Column("prochaine_consultation")
    private LocalDateTime prochaineConsultation;

    @Column("pression_arterielle")
    private String pressionArterielle;

    @Column("poids")
    private Double poids;

    @Column("taille")
    private Double taille;

    @Column("temperature")
    private Double temperature;

    @Column("frequence_cardiaque")
    private Integer frequenceCardiaque;

    @Column("saturation_oxygene")
    private Integer saturationOxygene;

    @Column("notes_complementaires")
    private String notesComplementaires;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

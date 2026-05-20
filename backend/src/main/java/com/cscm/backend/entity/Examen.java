package com.cscm.backend.entity;

import com.cscm.backend.enums.TypeExamenCameroun;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

@Table("examens")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Examen {

    @Id
    private UUID id;

    /** FK → carnets_medicaux.id */
    @Column("carnet_id")
    private UUID carnetId;

    /** FK → medecins.id */
    @Column("medecin_prescripteur")
    private UUID medecinPrescripteurId;

    /** FK → consultations.id */
    @Column("consultation_id")
    private UUID consultationId;

    /** Libellé libre de l'examen */
    @Column("type_examen")
    private String typeExamen;

    /** Catégorie standardisée Cameroun */
    @Column("type_examen_cameroun")
    private TypeExamenCameroun typeExamenCameroun;

    /** biologie, imagerie, fonctionnel, anatomopathologie… */
    @Column("categorie_examen")
    private String categorieExamen;

    @Column("instructions")
    private String instructions;

    @Column("date_prescription")
    private LocalDateTime datePrescription;

    @Column("date_realisation")
    private LocalDateTime dateRealisation;

    @Column("etablissement_realisation")
    private String etablissementRealisation;

    @Builder.Default
    @Column("resultat_pris_en_compte")
    private Boolean resultatPrisEnCompte = false;

    @Builder.Default
    @Column("urgent")
    private Boolean urgent = false;

    @Column("notes")
    private String notes;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

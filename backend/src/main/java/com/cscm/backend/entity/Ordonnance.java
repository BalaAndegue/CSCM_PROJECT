package com.cscm.backend.entity;

import com.cscm.backend.enums.OrdonnanceStatus;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

@Table("ordonnances")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Ordonnance {

    @Id
    private UUID id;

    /** FK → consultations.id */
    @Column("consultation_id")
    private UUID consultationId;

    /** FK → carnets_medicaux.id */
    @Column("carnet_id")
    private UUID carnetId;

    /** FK → medecins.id */
    @Column("medecin_id")
    private UUID medecinId;

    /** FK → hopitaux.id */
    @Column("hopital_id")
    private UUID hopitalId;

    @Column("date_prescription")
    private LocalDateTime datePrescription;

    @Column("date_expiration")
    private LocalDateTime dateExpiration;

    @Builder.Default
    @Column("renouvelable")
    private Boolean renouvelable = false;

    @Builder.Default
    @Column("nombre_renouvellements")
    private Integer nombreRenouvellements = 0;

    @Column("numero_ordonnance")
    private String numeroOrdonnance;

    /**
     * Médicaments en JSON: [{"nom":"Paracétamol","dosage":"500mg","frequence":"3x/j","duree":"5j","voie":"orale"}]
     * Stocké comme TEXT pour compatibilité R2DBC — sérialisé/désérialisé dans le service.
     */
    @Column("medicaments")
    private String medicamentsJson;

    @Column("instructions")
    private String instructions;

    @Column("posologie_detaillee")
    private String posologieDetaillee;

    @Column("note_pharmacien")
    private String notePharmacien;

    @Builder.Default
    @Column("status")
    private OrdonnanceStatus status = OrdonnanceStatus.ACTIVE;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

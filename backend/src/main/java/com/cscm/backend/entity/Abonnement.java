package com.cscm.backend.entity;

import com.cscm.backend.enums.AbonnementPeriode;
import com.cscm.backend.enums.AbonnementPlan;
import com.cscm.backend.enums.AbonnementStatut;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Table("abonnements")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Abonnement {

    @Id
    private UUID id;

    /** FK → patients.id */
    @Column("patient_id")
    private UUID patientId;

    @Column("plan")
    private AbonnementPlan plan;

    @Column("montant")
    private BigDecimal montant;

    @Column("periode")
    private AbonnementPeriode periode;

    @Column("date_debut")
    private LocalDateTime dateDebut;

    @Column("date_fin")
    private LocalDateTime dateFin;

    @Builder.Default
    @Column("statut")
    private AbonnementStatut statut = AbonnementStatut.ACTIF;

    @Column("moyen_paiement")
    private String moyenPaiement;

    @Column("reference_paiement")
    private String referencePaiement;

    @Builder.Default
    @Column("renouvellement_automatique")
    private Boolean renouvellementAutomatique = true;

    @Column("note")
    private String note;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

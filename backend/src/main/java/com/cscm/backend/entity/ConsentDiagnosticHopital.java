package com.cscm.backend.entity;

import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

@Table("consents_diagnostic_hopital")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ConsentDiagnosticHopital {

    @Id
    private UUID id;

    /** FK → consultations.id */
    @Column("consultation_id")
    private UUID consultationId;

    /** FK → medecins.id */
    @Column("medecin_id")
    private UUID medecinId;

    /** FK → hopitaux.id */
    @Column("hopital_id")
    private UUID hopitalId;

    @Column("motif_demande")
    private String motifDemande;

    @Column("demande_par_medecin")
    private LocalDateTime demandeParMedecin;

    @Builder.Default
    @Column("approuve_par_manager")
    private Boolean approuveParManager = false;

    /** FK → users.id (manager) */
    @Column("manager_id")
    private UUID managerId;

    @Column("date_approuvation")
    private LocalDateTime dateApprouvation;

    @Column("motif_refus")
    private String motifRefus;

    @Column("date_expiration")
    private LocalDateTime dateExpiration;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

package com.cscm.backend.entity;

import com.cscm.backend.enums.OrdonnanceStatus;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Entity
@Table(name = "ordonnances")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Ordonnance {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "carnet_id", nullable = false)
    private CarnetMedical carnet;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_id", nullable = false)
    private Medecin medecin;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hopital_id", nullable = false)
    private Hopital hopital;

    @Column(name = "date_prescription", nullable = false)
    private LocalDateTime datePrescription;

    @Column(name = "date_expiration")
    private LocalDateTime dateExpiration;

    @Builder.Default
    @Column(name = "renouvelable")
    private Boolean renouvelable = false;

    @Column(name = "nombre_renouvellements")
    @Builder.Default
    private Integer nombreRenouvellements = 0;

    @Column(name = "numero_ordonnance", unique = true, length = 50)
    private String numeroOrdonnance;

    // List of: {"nom": "Paracétamol", "dosage": "500mg", "frequence": "3x/jour", "duree": "5j", "voie": "orale"}
    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "medicaments", columnDefinition = "jsonb", nullable = false)
    private List<Map<String, Object>> medicaments;

    @Column(columnDefinition = "TEXT")
    private String instructions;

    @Column(name = "posologie_detaillee", columnDefinition = "TEXT")
    private String posologieDetaillee;

    @Column(name = "note_pharmacien", columnDefinition = "TEXT")
    private String notePharmacien;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private OrdonnanceStatus status = OrdonnanceStatus.ACTIVE;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

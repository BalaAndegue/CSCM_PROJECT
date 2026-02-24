package com.cscm.backend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

@Entity
@Table(name = "resultats_examens")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ResultatExamen {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "examen_id", nullable = false)
    private Examen examen;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fichier_resultat")
    private Document fichierResultat;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "valeurs_cles", columnDefinition = "jsonb")
    private Map<String, Object> valeursCles;

    @Column(columnDefinition = "TEXT")
    private String interpretation;

    @Column(name = "conclusion", columnDefinition = "TEXT")
    private String conclusion;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_lecteur")
    private Medecin medecinLecteur;

    @Column(name = "date_lecture")
    private LocalDateTime dateLecture;

    @Column(name = "normale")
    private Boolean normale;

    @Column(name = "valeurs_reference", columnDefinition = "TEXT")
    private String valeursReference;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}

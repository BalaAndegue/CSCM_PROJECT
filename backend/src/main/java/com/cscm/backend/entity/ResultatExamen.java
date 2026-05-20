package com.cscm.backend.entity;

import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

@Table("resultats_examens")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ResultatExamen {

    @Id
    private UUID id;

    /** FK → examens.id */
    @Column("examen_id")
    private UUID examenId;

    /** FK → medias_fichiers.id (fichier de résultat principal) */
    @Column("fichier_resultat_id")
    private UUID fichierResultatId;

    /** Valeurs clés en JSON: {"hemoglobine":"12g/dL","leucocytes":"5000/mm3"} */
    @Column("valeurs_cles")
    private String valeursClesJson;

    @Column("interpretation")
    private String interpretation;

    @Column("conclusion")
    private String conclusion;

    /** FK → medecins.id */
    @Column("medecin_lecteur")
    private UUID medecinLecteurId;

    @Column("date_lecture")
    private LocalDateTime dateLecture;

    @Column("normale")
    private Boolean normale;

    @Column("valeurs_reference")
    private String valeursReference;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

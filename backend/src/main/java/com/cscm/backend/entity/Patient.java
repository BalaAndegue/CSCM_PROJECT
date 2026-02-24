package com.cscm.backend.entity;

import com.cscm.backend.enums.Genre;
import com.cscm.backend.enums.GroupeSanguin;
import com.cscm.backend.enums.SituationFamiliale;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "patients")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Patient {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", unique = true)
    private User user;

    @Column(name = "numero_carnet", unique = true, nullable = false, length = 50)
    private String numeroCarnet;

    @Column(name = "date_naissance", nullable = false)
    private LocalDate dateNaissance;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private Genre genre;

    @Column(columnDefinition = "TEXT")
    private String adresse;

    @Column(length = 20)
    private String telephone;

    @Enumerated(EnumType.STRING)
    @Column(name = "situation_familiale", length = 20)
    private SituationFamiliale situationFamiliale;

    @Column(length = 255)
    private String profession;

    @Column(name = "antecedents_chirurgicaux", columnDefinition = "TEXT")
    private String antecedentsChirurgicaux;

    @Column(name = "antecedents_familiaux", columnDefinition = "TEXT")
    private String antecedentsFamiliaux;

    @Column(name = "antecedents_medicaux", columnDefinition = "TEXT")
    private String antecedentsMedicaux;

    @Enumerated(EnumType.STRING)
    @Column(name = "groupe_sanguin", length = 10)
    private GroupeSanguin groupeSanguin;

    @Column(name = "date_verification_abo_rh")
    private LocalDate dateVerificationAboRh;

    @Column(name = "medecin_traitant_id")
    private UUID medecinTraitantId;

    @Column(name = "contact_urgence_nom", length = 255)
    private String contactUrgenceNom;

    @Column(name = "contact_urgence_telephone", length = 20)
    private String contactUrgenceTelephone;

    // Guarantor fields
    @Column(name = "garant_nom_complet", length = 255)
    private String garantNomComplet;

    @Column(name = "garant_telephone", length = 20)
    private String garantTelephone;

    @Column(name = "garant_email", length = 255)
    private String garantEmail;

    @Column(name = "garant_lien_parente", length = 100)
    private String garantLienParente;

    @Column(name = "garant_user_id")
    private UUID garantUserId;

    @Column(name = "photo_profil")
    private String photoProfil;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}

package com.cscm.backend.dto.request;

import com.cscm.backend.enums.Genre;
import com.cscm.backend.enums.LienParente;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.time.LocalDate;

@Data
public class RegisterPatientRequest {

    // ─── Compte ──────────────────────────────────────────────────────────────
    @Email @NotBlank
    private String email;
    @NotBlank @Size(min = 8)
    private String motDePasse;
    @NotBlank
    private String nomComplet;
    private String telephone;

    // ─── Identité ────────────────────────────────────────────────────────────
    @NotNull
    private LocalDate dateNaissance;
    @NotNull
    private Genre genre;
    private String lieuNaissance;
    private String nationalite;

    // ─── CNI obligatoire ─────────────────────────────────────────────────────
    @NotBlank(message = "Le numéro de CNI est obligatoire")
    private String numeroCNI;
    private LocalDate dateDelivranceCNI;
    private String lieuDelivranceCNI;

    // ─── Avariste/Garant obligatoire ─────────────────────────────────────────
    @NotBlank(message = "Le nom complet du garant est obligatoire")
    private String garantNomComplet;
    @NotBlank(message = "Le téléphone du garant est obligatoire")
    private String garantTelephone;
    @NotNull(message = "Le lien de parenté avec le garant est obligatoire")
    private LienParente garantLienParente;
    private String garantNumeroCNI;
    private String garantEmail;
}

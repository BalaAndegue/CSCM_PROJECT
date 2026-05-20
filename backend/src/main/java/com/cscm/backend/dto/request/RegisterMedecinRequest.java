package com.cscm.backend.dto.request;

import com.cscm.backend.enums.RegionCameroun;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.time.LocalDate;

@Data
public class RegisterMedecinRequest {

    // ─── Compte ──────────────────────────────────────────────────────────────
    @Email @NotBlank
    private String email;
    @NotBlank @Size(min = 8)
    private String motDePasse;
    @NotBlank
    private String nomComplet;
    private String telephone;

    // ─── Identité professionnelle obligatoire ─────────────────────────────────
    @NotBlank(message = "La spécialité est obligatoire")
    private String specialite;
    @NotBlank(message = "Le numéro CNOM est obligatoire")
    private String numeroCNOM;

    // ─── CNI obligatoire ─────────────────────────────────────────────────────
    @NotBlank(message = "Le numéro de CNI est obligatoire")
    private String numeroCNI;
    private LocalDate dateDelivranceCNI;
    private String lieuDelivranceCNI;

    // ─── Localisation ────────────────────────────────────────────────────────
    private String villePrincipale;
    private RegionCameroun regionPrincipale;
}

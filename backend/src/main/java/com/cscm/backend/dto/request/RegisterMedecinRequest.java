package com.cscm.backend.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class RegisterMedecinRequest {
    @Email @NotBlank
    private String email;
    @NotBlank @Size(min = 8)
    private String motDePasse;
    @NotBlank
    private String nomComplet;
    private String telephone;
    @NotBlank
    private String specialite;
    @NotBlank
    private String numeroOrdre;
    private String numeroCarteProfessionnelle;
}

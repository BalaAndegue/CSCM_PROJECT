package com.cscm.backend.dto.request;

import com.cscm.backend.enums.Genre;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.time.LocalDate;

@Data
public class RegisterPatientRequest {
    @Email @NotBlank
    private String email;
    @NotBlank @Size(min = 8)
    private String motDePasse;
    @NotBlank
    private String nomComplet;
    private String telephone;
    @NotNull
    private LocalDate dateNaissance;
    @NotNull
    private Genre genre;
}

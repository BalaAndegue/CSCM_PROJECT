package com.cscm.backend.dto.response;

import com.cscm.backend.enums.Genre;
import com.cscm.backend.enums.GroupeSanguin;
import com.cscm.backend.enums.SituationFamiliale;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PatientDto {
    private UUID id;
    private String numeroCarnet;
    private LocalDate dateNaissance;
    private Genre genre;
    private String adresse;
    private String telephone;
    private SituationFamiliale situationFamiliale;
    private String profession;
    private GroupeSanguin groupeSanguin;
    private LocalDate dateVerificationAboRh;
    
    // User info embarquée
    private String nomComplet;
    private String email;
    
    // Audit
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}

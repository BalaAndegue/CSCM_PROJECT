package com.cscm.backend.dto.response;

import com.cscm.backend.enums.MedecinStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MedecinDto {
    private UUID id;
    private String numeroOrdre;
    private String specialite;
    private String sousSpecialite;
    private String numeroCarteProfessionnelle;
    private Integer anneesExperience;
    private String biographie;
    private MedecinStatus status;
    private Double consultationFee;
    private Boolean disponible;
    private List<String> diplomes;
    
    // User info
    private String nomComplet;
    private String email;
}

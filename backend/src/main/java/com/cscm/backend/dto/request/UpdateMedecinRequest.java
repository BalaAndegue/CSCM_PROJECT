package com.cscm.backend.dto.request;

import lombok.Data;
import java.util.List;

@Data
public class UpdateMedecinRequest {
    private String specialite;
    private String sousSpecialite;
    private String biographie;
    private Integer anneesExperience;
    private Double consultationFee;
    private List<String> diplomes;
}

package com.cscm.backend.dto.request;

import lombok.Data;
import java.util.UUID;

@Data
public class DemandeConsentRequest {
    private UUID consultationId;
    private UUID hopitalId;
    private String motif;
}

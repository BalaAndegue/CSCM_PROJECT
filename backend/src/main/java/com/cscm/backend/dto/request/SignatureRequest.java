package com.cscm.backend.dto.request;

import lombok.Data;

@Data
public class SignatureRequest {
    private String signature;
    private Boolean isGarant;
    private String signatureGarant;
}

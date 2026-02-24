package com.cscm.backend.controller;

import com.cscm.backend.entity.*;
import com.cscm.backend.service.ApprobationService;
import com.cscm.backend.service.PatientService;
import com.cscm.backend.util.ApiResponse;
import com.cscm.backend.dto.request.SignatureRequest;
import com.cscm.backend.dto.request.MotifRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/approbations")
@RequiredArgsConstructor
@Tag(name = "Approbations Médecins", description = "Gestion des droits d'accès médecins au carnet patient")
public class ApprobationController {

    private final ApprobationService approbationService;
    private final com.cscm.backend.service.CarnetService carnetService;
    private final com.cscm.backend.service.PatientService patientService;
    private final com.cscm.backend.service.MedecinService medecinService;
    private final com.cscm.backend.repository.UserRepository userRepository;

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Médecins approuvés pour un carnet")
    public ResponseEntity<ApiResponse<List<ApprobationMedecin>>> getMedecinsApprouves(@PathVariable UUID carnetId) {
        return ResponseEntity.ok(ApiResponse.success(approbationService.getMedecinsApprouves(carnetId)));
    }

    @PostMapping("/carnet/{carnetId}/medecin/{medecinId}")
    @Operation(summary = "Approuver l'accès d'un médecin au carnet (patient signe)")
    @PreAuthorize("hasRole('PATIENT')")
    public ResponseEntity<ApiResponse<ApprobationMedecin>> approuver(
            @PathVariable UUID carnetId,
            @PathVariable UUID medecinId,
            @RequestBody(required = false) SignatureRequest req) {
        String signature = req != null ? req.getSignature() : null;
        Boolean isGarant = req != null ? req.getIsGarant() : null;
        String signatureGarant = req != null ? req.getSignatureGarant() : null;
        
        ApprobationMedecin approbation = approbationService.approuverMedecin(carnetId, medecinId, signature, isGarant, signatureGarant);
        return ResponseEntity.ok(ApiResponse.success(approbation, "Médecin approuvé avec succès"));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Révoquer l'accès d'un médecin")
    @PreAuthorize("hasAnyRole('PATIENT', 'ADMIN')")
    public ResponseEntity<ApiResponse<ApprobationMedecin>> revoquer(
            @PathVariable UUID id,
            @RequestBody(required = false) MotifRequest req) {
        String motif = req != null ? req.getMotif() : "Révocation par le patient";
        return ResponseEntity.ok(ApiResponse.success(approbationService.revoquerApprobation(id, motif), "Approbation révoquée"));
    }

    @GetMapping("/medecin/mes-acces")
    @Operation(summary = "Mes accès patients (médecin connecté)")
    @PreAuthorize("hasRole('MEDECIN')")
    public ResponseEntity<ApiResponse<List<ApprobationMedecin>>> getMesAcces(
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Medecin medecin = medecinService.getMedecinByUserId(user.getId());
        return ResponseEntity.ok(ApiResponse.success(approbationService.getApprobationsParMedecin(medecin.getId())));
    }
}


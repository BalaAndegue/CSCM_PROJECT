package com.cscm.backend.controller;

import com.cscm.backend.enums.TypeAccesCarnet;
import com.cscm.backend.service.ApprobationService;
import com.cscm.backend.service.MedecinService;
import com.cscm.backend.service.TokenAccesService;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.UUID;

@RestController
@RequestMapping("/approbations")
@RequiredArgsConstructor
@Tag(name = "Approbations", description = "Droits d'accès médecins au carnet – QR, code, médecin traitant")
public class ApprobationController {

    private final ApprobationService approbationService;
    private final MedecinService medecinService;
    private final TokenAccesService tokenAccesService;

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Médecins approuvés pour un carnet")
    Mono<ResponseEntity<ApiResponse<?>>> getMedecinsApprouves(@PathVariable UUID carnetId) {
        return approbationService.getMedecinsApprouves(carnetId)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/medecin/mes-acces")
    @PreAuthorize("hasRole('MEDECIN')")
    @Operation(summary = "Mes accès patients (médecin connecté)")
    Mono<ResponseEntity<ApiResponse<?>>> getMesAcces(@AuthenticationPrincipal String userIdStr) {
        return medecinService.getMedecinByUserId(UUID.fromString(userIdStr))
                .flatMapMany(medecin -> approbationService.getApprobationsParMedecin(medecin.getId()))
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('PATIENT', 'ADMIN')")
    @Operation(summary = "Révoquer l'accès d'un médecin (patient)")
    Mono<ResponseEntity<ApiResponse<Void>>> revoquer(
            @PathVariable UUID id,
            @AuthenticationPrincipal String patientIdStr,
            @RequestBody(required = false) MotifBody req) {
        String motif = req != null && req.getMotif() != null ? req.getMotif() : "Révocation par le patient";
        return approbationService.revoquerApprobation(id, UUID.fromString(patientIdStr), motif)
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Approbation révoquée")));
    }

    @DeleteMapping("/carnet/{carnetId}/tous")
    @PreAuthorize("hasRole('PATIENT')")
    @Operation(summary = "Révoquer tous les accès d'un carnet")
    Mono<ResponseEntity<ApiResponse<Void>>> revoquerTous(@PathVariable UUID carnetId) {
        return approbationService.revoquerTousLesMedecins(carnetId)
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Tous les accès révoqués")));
    }

    // ─── Médecin traitant ─────────────────────────────────────────────────────

    @PostMapping("/carnet/{carnetId}/traitant/{medecinId}")
    @PreAuthorize("hasRole('PATIENT')")
    @Operation(summary = "Désigner un médecin traitant (accès permanent)")
    Mono<ResponseEntity<ApiResponse<?>>> definirTraitant(
            @PathVariable UUID carnetId,
            @PathVariable UUID medecinId,
            @AuthenticationPrincipal String patientIdStr) {
        return approbationService.definirMedecinPersonnel(carnetId, UUID.fromString(patientIdStr), medecinId)
                .map(mp -> ResponseEntity.ok(ApiResponse.success(mp, "Médecin traitant désigné")));
    }

    @DeleteMapping("/traitant/{medecinId}")
    @PreAuthorize("hasRole('PATIENT')")
    @Operation(summary = "Retirer un médecin traitant")
    Mono<ResponseEntity<ApiResponse<Void>>> retirerTraitant(
            @PathVariable UUID medecinId,
            @AuthenticationPrincipal String patientIdStr) {
        return approbationService.retirerMedecinPersonnel(UUID.fromString(patientIdStr), medecinId)
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Médecin traitant retiré")));
    }

    @GetMapping("/traitants")
    @PreAuthorize("hasRole('PATIENT')")
    @Operation(summary = "Mes médecins traitants")
    Mono<ResponseEntity<ApiResponse<?>>> getMesTraitants(@AuthenticationPrincipal String patientIdStr) {
        return approbationService.getMedecinsPersonnels(UUID.fromString(patientIdStr))
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @Data
    static class MotifBody {
        private String motif;
    }
}

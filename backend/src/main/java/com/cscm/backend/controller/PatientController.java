package com.cscm.backend.controller;

import com.cscm.backend.entity.Patient;
import com.cscm.backend.enums.LienParente;
import com.cscm.backend.service.PatientService;
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
@RequestMapping("/patients")
@RequiredArgsConstructor
@Tag(name = "Patients", description = "Profil patient, garant/avariste et CNI")
public class PatientController {

    private final PatientService patientService;

    @GetMapping("/me")
    @Operation(summary = "Mon profil patient")
    Mono<ResponseEntity<ApiResponse<?>>> getMyProfile(@AuthenticationPrincipal String userIdStr) {
        return patientService.getPatientByUserId(UUID.fromString(userIdStr))
                .map(p -> ResponseEntity.ok(ApiResponse.success(p)));
    }

    @PutMapping("/me")
    @Operation(summary = "Modifier mon profil patient")
    Mono<ResponseEntity<ApiResponse<?>>> updateMyProfile(
            @AuthenticationPrincipal String userIdStr,
            @RequestBody Patient updates) {
        UUID userId = UUID.fromString(userIdStr);
        return patientService.getPatientByUserId(userId)
                .flatMap(p -> patientService.updatePatient(p.getId(), userId, updates))
                .map(p -> ResponseEntity.ok(ApiResponse.success(p, "Profil mis à jour")));
    }

    @PutMapping("/me/garant")
    @Operation(summary = "Mettre à jour les informations du garant/avariste")
    Mono<ResponseEntity<ApiResponse<?>>> updateGarant(
            @AuthenticationPrincipal String userIdStr,
            @RequestBody GarantRequest req) {
        UUID userId = UUID.fromString(userIdStr);
        return patientService.getPatientByUserId(userId)
                .flatMap(p -> patientService.updateGarant(
                        p.getId(), userId,
                        req.getGarantNomComplet(), req.getGarantTelephone(),
                        req.getGarantLienParente(), req.getGarantNumeroCNI(), req.getGarantEmail()))
                .map(p -> ResponseEntity.ok(ApiResponse.success(p, "Garant mis à jour")));
    }

    @PutMapping("/me/garant/acces")
    @Operation(summary = "Activer/désactiver l'accès garant")
    Mono<ResponseEntity<ApiResponse<?>>> toggleGarantAcces(
            @AuthenticationPrincipal String userIdStr,
            @RequestParam boolean activer) {
        return patientService.getPatientByUserId(UUID.fromString(userIdStr))
                .flatMap(p -> patientService.activerAccesGarant(p.getId(), activer))
                .map(p -> ResponseEntity.ok(ApiResponse.success(p,
                        activer ? "Accès garant activé" : "Accès garant désactivé")));
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'MEDECIN')")
    @Operation(summary = "Voir un patient par ID – médecin/admin")
    Mono<ResponseEntity<ApiResponse<?>>> getById(@PathVariable UUID id) {
        return patientService.getPatientById(id)
                .map(p -> ResponseEntity.ok(ApiResponse.success(p)));
    }

    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Rechercher des patients (admin)")
    Mono<ResponseEntity<ApiResponse<?>>> search(
            @RequestParam(required = false) String query,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "0") long offset) {
        var flux = (query != null && !query.isBlank())
                ? patientService.searchPatients(query, size, offset)
                : patientService.searchPatients("", size, offset);
        return flux.collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/cni/{numeroCNI}")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    @Operation(summary = "Trouver un patient par numéro CNI")
    Mono<ResponseEntity<ApiResponse<?>>> getByCNI(@PathVariable String numeroCNI) {
        return patientService.getPatientByNumeroCNI(numeroCNI)
                .map(p -> ResponseEntity.ok(ApiResponse.success(p)));
    }

    @Data
    static class GarantRequest {
        private String garantNomComplet;
        private String garantTelephone;
        private LienParente garantLienParente;
        private String garantNumeroCNI;
        private String garantEmail;
    }
}

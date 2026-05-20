package com.cscm.backend.controller;

import com.cscm.backend.entity.ConsentDiagnosticHopital;
import com.cscm.backend.service.ConsentService;
import com.cscm.backend.service.MedecinService;
import com.cscm.backend.util.ApiResponse;
import com.cscm.backend.dto.request.DemandeConsentRequest;
import com.cscm.backend.dto.request.MotifRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.UUID;

@RestController
@RequestMapping("/consents")
@RequiredArgsConstructor
@Tag(name = "Consentements Diagnostic", description = "Gestion des autorisations diagnostic hôpital")
public class ConsentController {

    private final ConsentService consentService;
    private final MedecinService medecinService;

    @GetMapping("/hopital/{hopitalId}")
    @PreAuthorize("hasAnyRole('MANAGER_HOPITAL', 'ADMIN')")
    @Operation(summary = "Consentements d'un hôpital")
    Mono<ResponseEntity<ApiResponse<?>>> getByHopital(@PathVariable UUID hopitalId) {
        return consentService.getByHopital(hopitalId)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/hopital/{hopitalId}/pending")
    @PreAuthorize("hasAnyRole('MANAGER_HOPITAL', 'ADMIN')")
    @Operation(summary = "Consentements en attente (manager)")
    Mono<ResponseEntity<ApiResponse<?>>> getPending(
            @PathVariable UUID hopitalId,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "0") long offset) {
        return consentService.getPendingByHopital(hopitalId, size, offset)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @PostMapping
    @PreAuthorize("hasRole('MEDECIN')")
    @Operation(summary = "Demander un consentement (médecin)")
    Mono<ResponseEntity<ApiResponse<?>>> demander(
            @RequestBody DemandeConsentRequest req,
            @AuthenticationPrincipal String userIdStr) {
        return medecinService.getMedecinByUserId(UUID.fromString(userIdStr))
                .flatMap(medecin -> consentService.demanderConsent(
                        req.getConsultationId(), medecin.getId(), req.getHopitalId(), req.getMotif()))
                .map(c -> ResponseEntity.ok(ApiResponse.success(c, "Demande de consentement envoyée")));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'un consentement")
    Mono<ResponseEntity<ApiResponse<?>>> getById(@PathVariable UUID id) {
        return consentService.getById(id)
                .map(c -> ResponseEntity.ok(ApiResponse.success(c)));
    }

    @PutMapping("/{id}/approuver")
    @PreAuthorize("hasAnyRole('MANAGER_HOPITAL', 'ADMIN')")
    @Operation(summary = "Approuver le consentement (manager hôpital)")
    Mono<ResponseEntity<ApiResponse<?>>> approuver(
            @PathVariable UUID id,
            @AuthenticationPrincipal String userIdStr) {
        return consentService.approuver(id, UUID.fromString(userIdStr))
                .map(c -> ResponseEntity.ok(ApiResponse.success(c, "Consentement approuvé")));
    }

    @PutMapping("/{id}/refuser")
    @PreAuthorize("hasAnyRole('MANAGER_HOPITAL', 'ADMIN')")
    @Operation(summary = "Refuser le consentement (manager hôpital)")
    Mono<ResponseEntity<ApiResponse<?>>> refuser(
            @PathVariable UUID id,
            @AuthenticationPrincipal String userIdStr,
            @RequestBody MotifRequest req) {
        return consentService.refuser(id, UUID.fromString(userIdStr), req.getMotif())
                .map(c -> ResponseEntity.ok(ApiResponse.success(c, "Consentement refusé")));
    }
}

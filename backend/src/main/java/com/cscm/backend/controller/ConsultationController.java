package com.cscm.backend.controller;

import com.cscm.backend.entity.Consultation;
import com.cscm.backend.service.ConsultationService;
import com.cscm.backend.service.MedecinService;
import com.cscm.backend.util.ApiResponse;
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
@RequestMapping("/consultations")
@RequiredArgsConstructor
@Tag(name = "Consultations", description = "Gestion des consultations médicales")
public class ConsultationController {

    private final ConsultationService consultationService;
    private final MedecinService medecinService;

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Consultations d'un carnet (paginées)")
    Mono<ResponseEntity<ApiResponse<?>>> getByCarnet(
            @PathVariable UUID carnetId,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "0") long offset) {
        return consultationService.getConsultationsByCarnet(carnetId, size, offset)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/medecin/{medecinId}")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    @Operation(summary = "Consultations d'un médecin")
    Mono<ResponseEntity<ApiResponse<?>>> getByMedecin(
            @PathVariable UUID medecinId,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "0") long offset) {
        return consultationService.getConsultationsByMedecin(medecinId, size, offset)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @PostMapping("/carnet/{carnetId}")
    @PreAuthorize("hasRole('MEDECIN')")
    @Operation(summary = "Créer une consultation")
    Mono<ResponseEntity<ApiResponse<?>>> create(
            @PathVariable UUID carnetId,
            @RequestParam(required = false) UUID hopitalId,
            @RequestBody Consultation data,
            @AuthenticationPrincipal String userIdStr) {
        return medecinService.getMedecinByUserId(UUID.fromString(userIdStr))
                .flatMap(medecin -> consultationService.createConsultation(carnetId, medecin.getId(), hopitalId, data))
                .map(c -> ResponseEntity.ok(ApiResponse.success(c, "Consultation créée")));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'une consultation")
    Mono<ResponseEntity<ApiResponse<?>>> getById(@PathVariable UUID id) {
        return consultationService.getConsultationById(id)
                .map(c -> ResponseEntity.ok(ApiResponse.success(c)));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    @Operation(summary = "Modifier une consultation")
    Mono<ResponseEntity<ApiResponse<?>>> update(
            @PathVariable UUID id,
            @RequestBody Consultation updates) {
        return consultationService.updateConsultation(id, updates)
                .map(c -> ResponseEntity.ok(ApiResponse.success(c, "Consultation mise à jour")));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Supprimer une consultation (admin)")
    Mono<ResponseEntity<ApiResponse<Void>>> delete(@PathVariable UUID id) {
        return consultationService.deleteConsultation(id)
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Consultation supprimée")));
    }
}

package com.cscm.backend.controller;

import com.cscm.backend.entity.Allergie;
import com.cscm.backend.service.AllergieService;
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
@RequestMapping("/allergies")
@RequiredArgsConstructor
@Tag(name = "Allergies", description = "Gestion des allergies – priorité haute")
public class AllergieController {

    private final AllergieService allergieService;
    private final MedecinService medecinService;

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Toutes les allergies d'un carnet")
    Mono<ResponseEntity<ApiResponse<?>>> getByCarnet(@PathVariable UUID carnetId) {
        return allergieService.getByCarnet(carnetId)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/carnet/{carnetId}/actives")
    @Operation(summary = "Allergies actives d'un carnet")
    Mono<ResponseEntity<ApiResponse<?>>> getActives(@PathVariable UUID carnetId) {
        return allergieService.getActivesByCarnet(carnetId)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @PostMapping("/carnet/{carnetId}")
    @PreAuthorize("hasAnyRole('MEDECIN', 'PATIENT')")
    @Operation(summary = "Ajouter une allergie")
    Mono<ResponseEntity<ApiResponse<?>>> create(
            @PathVariable UUID carnetId,
            @RequestBody Allergie data,
            @AuthenticationPrincipal String userIdStr) {
        UUID userId = UUID.fromString(userIdStr);
        return medecinService.getMedecinByUserId(userId)
                .map(m -> m.getId())
                .onErrorReturn((UUID) null)
                .flatMap(medecinId -> allergieService.create(carnetId, data, medecinId))
                .map(a -> ResponseEntity.ok(ApiResponse.success(a, "Allergie ajoutée")));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'une allergie")
    Mono<ResponseEntity<ApiResponse<?>>> getById(@PathVariable UUID id) {
        return allergieService.getById(id)
                .map(a -> ResponseEntity.ok(ApiResponse.success(a)));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('MEDECIN', 'PATIENT', 'ADMIN')")
    @Operation(summary = "Modifier une allergie")
    Mono<ResponseEntity<ApiResponse<?>>> update(
            @PathVariable UUID id,
            @RequestBody Allergie updates) {
        return allergieService.update(id, updates)
                .map(a -> ResponseEntity.ok(ApiResponse.success(a, "Allergie mise à jour")));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    @Operation(summary = "Supprimer une allergie")
    Mono<ResponseEntity<ApiResponse<Void>>> delete(@PathVariable UUID id) {
        return allergieService.delete(id)
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Allergie supprimée")));
    }
}

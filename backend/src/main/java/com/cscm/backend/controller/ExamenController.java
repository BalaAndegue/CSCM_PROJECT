package com.cscm.backend.controller;

import com.cscm.backend.entity.Examen;
import com.cscm.backend.entity.ResultatExamen;
import com.cscm.backend.service.ExamenService;
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
@RequestMapping("/examens")
@RequiredArgsConstructor
@Tag(name = "Examens", description = "Prescription et gestion des examens médicaux")
public class ExamenController {

    private final ExamenService examenService;
    private final MedecinService medecinService;

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Examens d'un carnet")
    Mono<ResponseEntity<ApiResponse<?>>> getByCarnet(
            @PathVariable UUID carnetId,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "0") long offset) {
        return examenService.getByCarnet(carnetId, size, offset)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @PostMapping("/carnet/{carnetId}")
    @PreAuthorize("hasRole('MEDECIN')")
    @Operation(summary = "Prescrire un examen")
    Mono<ResponseEntity<ApiResponse<?>>> create(
            @PathVariable UUID carnetId,
            @RequestBody Examen data,
            @AuthenticationPrincipal String userIdStr) {
        return medecinService.getMedecinByUserId(UUID.fromString(userIdStr))
                .flatMap(medecin -> examenService.create(carnetId, medecin.getId(), data))
                .map(e -> ResponseEntity.ok(ApiResponse.success(e, "Examen prescrit")));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'un examen")
    Mono<ResponseEntity<ApiResponse<?>>> getById(@PathVariable UUID id) {
        return examenService.getById(id)
                .map(e -> ResponseEntity.ok(ApiResponse.success(e)));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    @Operation(summary = "Modifier un examen")
    Mono<ResponseEntity<ApiResponse<?>>> update(
            @PathVariable UUID id,
            @RequestBody Examen updates) {
        return examenService.update(id, updates)
                .map(e -> ResponseEntity.ok(ApiResponse.success(e, "Examen mis à jour")));
    }

    @PutMapping("/{id}/realise")
    @Operation(summary = "Marquer l'examen comme réalisé")
    Mono<ResponseEntity<ApiResponse<?>>> marquerRealise(@PathVariable UUID id) {
        return examenService.marquerRealise(id)
                .map(e -> ResponseEntity.ok(ApiResponse.success(e, "Examen marqué réalisé")));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    @Operation(summary = "Supprimer un examen")
    Mono<ResponseEntity<ApiResponse<Void>>> delete(@PathVariable UUID id) {
        return examenService.delete(id)
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Examen supprimé")));
    }

    @GetMapping("/{id}/resultats")
    @Operation(summary = "Résultats d'un examen")
    Mono<ResponseEntity<ApiResponse<?>>> getResultats(@PathVariable UUID id) {
        return examenService.getResultats(id)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @PostMapping("/{id}/resultats")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    @Operation(summary = "Ajouter un résultat d'examen")
    Mono<ResponseEntity<ApiResponse<?>>> addResultat(
            @PathVariable UUID id,
            @RequestBody ResultatExamen data) {
        return examenService.addResultat(id, data)
                .map(r -> ResponseEntity.ok(ApiResponse.success(r, "Résultat ajouté")));
    }
}

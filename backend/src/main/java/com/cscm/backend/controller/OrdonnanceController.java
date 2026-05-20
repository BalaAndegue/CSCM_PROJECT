package com.cscm.backend.controller;

import com.cscm.backend.entity.Ordonnance;
import com.cscm.backend.service.MedecinService;
import com.cscm.backend.service.OrdonnanceService;
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
@RequestMapping("/ordonnances")
@RequiredArgsConstructor
@Tag(name = "Ordonnances", description = "Création et gestion des ordonnances médicales")
public class OrdonnanceController {

    private final OrdonnanceService ordonnanceService;
    private final MedecinService medecinService;

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Ordonnances d'un carnet")
    Mono<ResponseEntity<ApiResponse<?>>> getByCarnet(
            @PathVariable UUID carnetId,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "0") long offset) {
        return ordonnanceService.getByCarnet(carnetId, size, offset)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @PostMapping("/carnet/{carnetId}")
    @PreAuthorize("hasRole('MEDECIN')")
    @Operation(summary = "Créer une ordonnance")
    Mono<ResponseEntity<ApiResponse<?>>> create(
            @PathVariable UUID carnetId,
            @RequestParam UUID hopitalId,
            @RequestBody Ordonnance data,
            @AuthenticationPrincipal String userIdStr) {
        return medecinService.getMedecinByUserId(UUID.fromString(userIdStr))
                .flatMap(medecin -> ordonnanceService.create(carnetId, medecin.getId(), hopitalId, data))
                .map(o -> ResponseEntity.ok(ApiResponse.success(o, "Ordonnance créée")));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'une ordonnance")
    Mono<ResponseEntity<ApiResponse<?>>> getById(@PathVariable UUID id) {
        return ordonnanceService.getById(id)
                .map(o -> ResponseEntity.ok(ApiResponse.success(o)));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    @Operation(summary = "Modifier une ordonnance")
    Mono<ResponseEntity<ApiResponse<?>>> update(
            @PathVariable UUID id,
            @RequestBody Ordonnance updates) {
        return ordonnanceService.update(id, updates)
                .map(o -> ResponseEntity.ok(ApiResponse.success(o, "Ordonnance mise à jour")));
    }

    @PutMapping("/{id}/annuler")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    @Operation(summary = "Annuler une ordonnance")
    Mono<ResponseEntity<ApiResponse<?>>> annuler(@PathVariable UUID id) {
        return ordonnanceService.annuler(id)
                .map(o -> ResponseEntity.ok(ApiResponse.success(o, "Ordonnance annulée")));
    }

    @GetMapping("/medecin/mes-ordonnances")
    @PreAuthorize("hasRole('MEDECIN')")
    @Operation(summary = "Mes ordonnances (médecin connecté)")
    Mono<ResponseEntity<ApiResponse<?>>> getMesOrdonnances(@AuthenticationPrincipal String userIdStr) {
        return medecinService.getMedecinByUserId(UUID.fromString(userIdStr))
                .flatMapMany(medecin -> ordonnanceService.getByMedecin(medecin.getId()))
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }
}

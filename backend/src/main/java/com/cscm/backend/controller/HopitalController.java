package com.cscm.backend.controller;

import com.cscm.backend.entity.Hopital;
import com.cscm.backend.entity.MedecinHopital;
import com.cscm.backend.service.HopitalService;
import com.cscm.backend.util.ApiResponse;
import com.cscm.backend.dto.request.ServiceRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.UUID;

@RestController
@RequestMapping("/hopitaux")
@RequiredArgsConstructor
@Tag(name = "Hôpitaux", description = "Gestion des établissements de santé")
public class HopitalController {

    private final HopitalService hopitalService;

    @GetMapping
    @Operation(summary = "Lister les hôpitaux")
    Mono<ResponseEntity<ApiResponse<?>>> getAll(
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "0") long offset) {
        return hopitalService.getAll(size, offset)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Créer un hôpital (admin)")
    Mono<ResponseEntity<ApiResponse<?>>> create(@RequestBody Hopital data) {
        return hopitalService.create(data)
                .map(h -> ResponseEntity.ok(ApiResponse.success(h, "Hôpital créé")));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'un hôpital")
    Mono<ResponseEntity<ApiResponse<?>>> getById(@PathVariable UUID id) {
        return hopitalService.getById(id)
                .map(h -> ResponseEntity.ok(ApiResponse.success(h)));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER_HOPITAL')")
    @Operation(summary = "Modifier un hôpital")
    Mono<ResponseEntity<ApiResponse<?>>> update(
            @PathVariable UUID id,
            @RequestBody Hopital updates) {
        return hopitalService.update(id, updates)
                .map(h -> ResponseEntity.ok(ApiResponse.success(h, "Hôpital mis à jour")));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Supprimer un hôpital (admin)")
    Mono<ResponseEntity<ApiResponse<Void>>> delete(@PathVariable UUID id) {
        return hopitalService.delete(id)
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Hôpital supprimé")));
    }

    @PostMapping("/{id}/medecins/{medecinId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER_HOPITAL')")
    @Operation(summary = "Rattacher un médecin à l'hôpital")
    Mono<ResponseEntity<ApiResponse<?>>> rattacherMedecin(
            @PathVariable UUID id,
            @PathVariable UUID medecinId,
            @RequestBody(required = false) ServiceRequest req) {
        String service = req != null ? req.getService() : null;
        return hopitalService.rattacherMedecin(id, medecinId, service)
                .map(mh -> ResponseEntity.ok(ApiResponse.success(mh, "Médecin rattaché")));
    }

    @DeleteMapping("/{id}/medecins/{medecinId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER_HOPITAL')")
    @Operation(summary = "Détacher un médecin de l'hôpital")
    Mono<ResponseEntity<ApiResponse<Void>>> detacherMedecin(
            @PathVariable UUID id,
            @PathVariable UUID medecinId) {
        return hopitalService.detacherMedecin(id, medecinId)
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Médecin détaché")));
    }

    @GetMapping("/{id}/medecins")
    @Operation(summary = "Médecins d'un hôpital")
    Mono<ResponseEntity<ApiResponse<?>>> getMedecins(@PathVariable UUID id) {
        return hopitalService.getMedecinsHopital(id)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }
}

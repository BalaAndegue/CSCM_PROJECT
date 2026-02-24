package com.cscm.backend.controller;

import com.cscm.backend.entity.Hopital;
import com.cscm.backend.entity.MedecinHopital;
import com.cscm.backend.service.HopitalService;
import com.cscm.backend.util.ApiResponse;
import com.cscm.backend.dto.request.ServiceRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/hopitaux")
@RequiredArgsConstructor
@Tag(name = "Hôpitaux", description = "Gestion des établissements de santé")
public class HopitalController {

    private final HopitalService hopitalService;

    @GetMapping
    @Operation(summary = "Lister les hôpitaux")
    public ResponseEntity<ApiResponse<Page<Hopital>>> getAll(@PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(hopitalService.getAll(pageable)));
    }

    @PostMapping
    @Operation(summary = "Créer un hôpital (admin)")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Hopital>> create(@RequestBody Hopital data) {
        return ResponseEntity.ok(ApiResponse.success(hopitalService.create(data), "Hôpital créé"));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'un hôpital")
    public ResponseEntity<ApiResponse<Hopital>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(hopitalService.getById(id)));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Modifier un hôpital")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER_HOPITAL')")
    public ResponseEntity<ApiResponse<Hopital>> update(@PathVariable UUID id, @RequestBody Hopital updates) {
        return ResponseEntity.ok(ApiResponse.success(hopitalService.update(id, updates), "Hôpital mis à jour"));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Supprimer un hôpital (admin)")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        hopitalService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok("Hôpital supprimé"));
    }

    @PostMapping("/{id}/medecins/{medecinId}")
    @Operation(summary = "Rattacher un médecin à l'hôpital")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER_HOPITAL')")
    public ResponseEntity<ApiResponse<MedecinHopital>> rattacherMedecin(
            @PathVariable UUID id, @PathVariable UUID medecinId,
            @RequestBody(required = false) ServiceRequest req) {
        String service = req != null ? req.getService() : null;
        return ResponseEntity.ok(ApiResponse.success(hopitalService.rattacherMedecin(id, medecinId, service), "Médecin rattaché"));
    }

    @DeleteMapping("/{id}/medecins/{medecinId}")
    @Operation(summary = "Détacher un médecin de l'hôpital")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER_HOPITAL')")
    public ResponseEntity<ApiResponse<Void>> detacherMedecin(@PathVariable UUID id, @PathVariable UUID medecinId) {
        hopitalService.detacherMedecin(id, medecinId);
        return ResponseEntity.ok(ApiResponse.ok("Médecin détaché"));
    }

    @GetMapping("/{id}/medecins")
    @Operation(summary = "Médecins d'un hôpital")
    public ResponseEntity<ApiResponse<?>> getMedecins(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(hopitalService.getMedecinsHopital(id)));
    }
}


package com.cscm.backend.controller;

import com.cscm.backend.entity.*;
import com.cscm.backend.service.ExamenService;
import com.cscm.backend.service.MedecinService;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/examens")
@RequiredArgsConstructor
@Tag(name = "Examens", description = "Prescription et gestion des examens médicaux")
public class ExamenController {

    private final ExamenService examenService;
    private final MedecinService medecinService;
    private final com.cscm.backend.repository.UserRepository userRepository;

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Examens d'un carnet")
    public ResponseEntity<ApiResponse<Page<Examen>>> getByCarnet(
            @PathVariable UUID carnetId, @PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(examenService.getByCarnet(carnetId, pageable)));
    }

    @PostMapping("/carnet/{carnetId}")
    @Operation(summary = "Prescrire un examen")
    @PreAuthorize("hasRole('MEDECIN')")
    public ResponseEntity<ApiResponse<Examen>> create(
            @PathVariable UUID carnetId,
            @RequestBody Examen data,
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Medecin medecin = medecinService.getMedecinByUserId(user.getId());
        return ResponseEntity.ok(ApiResponse.success(examenService.create(carnetId, medecin.getId(), data), "Examen prescrit"));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'un examen")
    public ResponseEntity<ApiResponse<Examen>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(examenService.getById(id)));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Modifier un examen")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<Examen>> update(@PathVariable UUID id, @RequestBody Examen updates) {
        return ResponseEntity.ok(ApiResponse.success(examenService.update(id, updates), "Examen mis à jour"));
    }

    @PutMapping("/{id}/realise")
    @Operation(summary = "Marquer l'examen comme réalisé")
    public ResponseEntity<ApiResponse<Examen>> marquerRealise(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(examenService.marquerRealise(id), "Examen marqué réalisé"));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Supprimer un examen")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        examenService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok("Examen supprimé"));
    }

    @GetMapping("/{id}/resultats")
    @Operation(summary = "Résultats d'un examen")
    public ResponseEntity<ApiResponse<List<ResultatExamen>>> getResultats(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(examenService.getResultats(id)));
    }

    @PostMapping("/{id}/resultats")
    @Operation(summary = "Ajouter un résultat d'examen")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<ResultatExamen>> addResultat(
            @PathVariable UUID id, @RequestBody ResultatExamen data) {
        return ResponseEntity.ok(ApiResponse.success(examenService.addResultat(id, data), "Résultat ajouté"));
    }
}

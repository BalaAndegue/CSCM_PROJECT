package com.cscm.backend.controller;

import com.cscm.backend.entity.Allergie;
import com.cscm.backend.entity.User;
import com.cscm.backend.service.AllergieService;
import com.cscm.backend.service.MedecinService;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/allergies")
@RequiredArgsConstructor
@Tag(name = "Allergies", description = "Gestion des allergies (priorité haute)")
public class AllergieController {

    private final AllergieService allergieService;
    private final MedecinService medecinService;
    private final com.cscm.backend.repository.UserRepository userRepository;

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Toutes les allergies d'un carnet")
    public ResponseEntity<ApiResponse<List<Allergie>>> getByCarnet(@PathVariable UUID carnetId) {
        return ResponseEntity.ok(ApiResponse.success(allergieService.getByCarnet(carnetId)));
    }

    @GetMapping("/carnet/{carnetId}/actives")
    @Operation(summary = "Allergies actives d'un carnet")
    public ResponseEntity<ApiResponse<List<Allergie>>> getActives(@PathVariable UUID carnetId) {
        return ResponseEntity.ok(ApiResponse.success(allergieService.getActivesByCarnet(carnetId)));
    }

    @PostMapping("/carnet/{carnetId}")
    @Operation(summary = "Ajouter une allergie")
    @PreAuthorize("hasAnyRole('MEDECIN', 'PATIENT')")
    public ResponseEntity<ApiResponse<Allergie>> create(
            @PathVariable UUID carnetId,
            @RequestBody Allergie data,
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        UUID medecinId = null;
        try { medecinId = medecinService.getMedecinByUserId(user.getId()).getId(); } catch (Exception e) { /* patient */ }
        return ResponseEntity.ok(ApiResponse.success(allergieService.create(carnetId, data, medecinId), "Allergie ajoutée"));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'une allergie")
    public ResponseEntity<ApiResponse<Allergie>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(allergieService.getById(id)));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Modifier une allergie")
    @PreAuthorize("hasAnyRole('MEDECIN', 'PATIENT', 'ADMIN')")
    public ResponseEntity<ApiResponse<Allergie>> update(@PathVariable UUID id, @RequestBody Allergie updates) {
        return ResponseEntity.ok(ApiResponse.success(allergieService.update(id, updates), "Allergie mise à jour"));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Supprimer une allergie")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        allergieService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok("Allergie supprimée"));
    }
}

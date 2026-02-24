package com.cscm.backend.controller;

import com.cscm.backend.entity.*;
import com.cscm.backend.service.MedecinService;
import com.cscm.backend.service.OrdonnanceService;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/ordonnances")
@RequiredArgsConstructor
@Tag(name = "Ordonnances", description = "Création et gestion des ordonnances médicales")
public class OrdonnanceController {

    private final OrdonnanceService ordonnanceService;
    private final MedecinService medecinService;
    private final com.cscm.backend.repository.UserRepository userRepository;

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Ordonnances d'un carnet")
    public ResponseEntity<ApiResponse<Page<Ordonnance>>> getByCarnet(
            @PathVariable UUID carnetId, @PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(ordonnanceService.getByCarnet(carnetId, pageable)));
    }

    @PostMapping("/carnet/{carnetId}")
    @Operation(summary = "Créer une ordonnance")
    @PreAuthorize("hasRole('MEDECIN')")
    public ResponseEntity<ApiResponse<Ordonnance>> create(
            @PathVariable UUID carnetId,
            @RequestParam UUID hopitalId,
            @RequestBody Ordonnance data,
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Medecin medecin = medecinService.getMedecinByUserId(user.getId());
        return ResponseEntity.ok(ApiResponse.success(
                ordonnanceService.create(carnetId, medecin.getId(), hopitalId, data), "Ordonnance créée"));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'une ordonnance")
    public ResponseEntity<ApiResponse<Ordonnance>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(ordonnanceService.getById(id)));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Modifier une ordonnance")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<Ordonnance>> update(@PathVariable UUID id, @RequestBody Ordonnance updates) {
        return ResponseEntity.ok(ApiResponse.success(ordonnanceService.update(id, updates), "Ordonnance mise à jour"));
    }

    @PutMapping("/{id}/annuler")
    @Operation(summary = "Annuler une ordonnance")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<Ordonnance>> annuler(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(ordonnanceService.annuler(id), "Ordonnance annulée"));
    }

    @GetMapping("/medecin/mes-ordonnances")
    @Operation(summary = "Mes ordonnances (médecin connecté)")
    @PreAuthorize("hasRole('MEDECIN')")
    public ResponseEntity<ApiResponse<Page<Ordonnance>>> getMesOrdonnances(
            @AuthenticationPrincipal UserDetails userDetails,
            @PageableDefault(size = 20) Pageable pageable) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Medecin medecin = medecinService.getMedecinByUserId(user.getId());
        return ResponseEntity.ok(ApiResponse.success(ordonnanceService.getByMedecin(medecin.getId(), pageable)));
    }
}

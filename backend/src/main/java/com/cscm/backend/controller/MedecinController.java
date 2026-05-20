package com.cscm.backend.controller;

import com.cscm.backend.dto.request.RaisonRequest;
import com.cscm.backend.dto.request.UpdateMedecinRequest;
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
@RequestMapping("/medecins")
@RequiredArgsConstructor
@Tag(name = "Médecins", description = "Profil médecin et gestion administrative")
public class MedecinController {

    private final MedecinService medecinService;

    @GetMapping("/me")
    @PreAuthorize("hasRole('MEDECIN')")
    @Operation(summary = "Mon profil médecin")
    Mono<ResponseEntity<ApiResponse<?>>> getMyProfile(@AuthenticationPrincipal String userIdStr) {
        return medecinService.getMedecinByUserId(UUID.fromString(userIdStr))
                .map(m -> ResponseEntity.ok(ApiResponse.success(m)));
    }

    @PutMapping("/me")
    @PreAuthorize("hasRole('MEDECIN')")
    @Operation(summary = "Modifier mon profil médecin")
    Mono<ResponseEntity<ApiResponse<?>>> updateMyProfile(
            @AuthenticationPrincipal String userIdStr,
            @RequestBody UpdateMedecinRequest req) {
        UUID userId = UUID.fromString(userIdStr);
        return medecinService.getMedecinByUserId(userId)
                .flatMap(medecin -> medecinService.updateMedecin(
                        medecin.getId(), userId,
                        req.getSpecialite(), req.getSousSpecialite(), req.getBiographie(),
                        req.getAnneesExperience(), req.getConsultationFee(), req.getLanguesJson()))
                .map(m -> ResponseEntity.ok(ApiResponse.success(m, "Profil mis à jour")));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'un médecin")
    Mono<ResponseEntity<ApiResponse<?>>> getById(@PathVariable UUID id) {
        return medecinService.getMedecinById(id)
                .map(m -> ResponseEntity.ok(ApiResponse.success(m)));
    }

    @GetMapping
    @Operation(summary = "Rechercher des médecins par spécialité")
    Mono<ResponseEntity<ApiResponse<?>>> searchBySpecialite(
            @RequestParam(required = false) String specialite,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "0") long offset) {
        var flux = (specialite != null && !specialite.isBlank())
                ? medecinService.searchBySpecialite(specialite, size, offset)
                : medecinService.getMedecinsEnAttente(size, offset);
        return flux.collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/hopital/{hopitalId}")
    @Operation(summary = "Médecins d'un hôpital")
    Mono<ResponseEntity<ApiResponse<?>>> parHopital(@PathVariable UUID hopitalId) {
        return medecinService.getMedecinsParHopital(hopitalId)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }
}

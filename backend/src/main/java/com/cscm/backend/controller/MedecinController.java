package com.cscm.backend.controller;

import com.cscm.backend.entity.Medecin;
import com.cscm.backend.entity.User;
import com.cscm.backend.service.MedecinService;
import com.cscm.backend.util.ApiResponse;
import com.cscm.backend.dto.request.UpdateMedecinRequest;
import com.cscm.backend.dto.request.RaisonRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.NotBlank;
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

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/medecins")
@RequiredArgsConstructor
@Tag(name = "Médecins", description = "Gestion des médecins")
public class MedecinController {

    private final MedecinService medecinService;
    private final com.cscm.backend.repository.UserRepository userRepository;

    @GetMapping("/me")
    @Operation(summary = "Mon profil médecin")
    @PreAuthorize("hasRole('MEDECIN')")
    public ResponseEntity<ApiResponse<Medecin>> getMyProfile(@AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        return ResponseEntity.ok(ApiResponse.success(medecinService.getMedecinByUserId(user.getId())));
    }

    @PutMapping("/me")
    @Operation(summary = "Modifier mon profil médecin")
    @PreAuthorize("hasRole('MEDECIN')")
    public ResponseEntity<ApiResponse<Medecin>> updateMyProfile(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestBody UpdateMedecinRequest req) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Medecin medecin = medecinService.getMedecinByUserId(user.getId());
        Medecin updated = medecinService.updateMedecin(medecin.getId(), req.getSpecialite(),
                req.getSousSpecialite(), req.getBiographie(), req.getAnneesExperience(), req.getConsultationFee(), req.getDiplomes());
        return ResponseEntity.ok(ApiResponse.success(updated, "Profil mis à jour"));
    }

    @GetMapping
    @Operation(summary = "Lister les médecins")
    public ResponseEntity<ApiResponse<Page<Medecin>>> getAll(
            @RequestParam(required = false) String specialite,
            @PageableDefault(size = 20) Pageable pageable) {
        Page<Medecin> result = (specialite != null && !specialite.isBlank())
                ? medecinService.searchBySpecialite(specialite, pageable)
                : medecinService.getAllMedecins(pageable);
        return ResponseEntity.ok(ApiResponse.success(result));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'un médecin")
    public ResponseEntity<ApiResponse<Medecin>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(medecinService.getMedecinById(id)));
    }

    @PutMapping("/{id}/valider")
    @Operation(summary = "Valider un médecin (admin)")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Medecin>> valider(
            @PathVariable UUID id,
            @AuthenticationPrincipal UserDetails userDetails) {
        User admin = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        return ResponseEntity.ok(ApiResponse.success(medecinService.validerMedecin(id, admin.getId()), "Médecin validé"));
    }

    @PutMapping("/{id}/rejeter")
    @Operation(summary = "Rejeter un médecin (admin)")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Medecin>> rejeter(
            @PathVariable UUID id,
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestBody RaisonRequest req) {
        User admin = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        return ResponseEntity.ok(ApiResponse.success(medecinService.rejeterMedecin(id, admin.getId(), req.getRaison()), "Médecin rejeté"));
    }

    @PutMapping("/{id}/suspendre")
    @Operation(summary = "Suspendre un médecin (admin)")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Medecin>> suspendre(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(medecinService.suspendMedecin(id), "Médecin suspendu"));
    }

    @GetMapping("/{id}/hopitaux")
    @Operation(summary = "Hôpitaux d'un médecin")
    public ResponseEntity<ApiResponse<List<Medecin>>> getHopitaux(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(medecinService.getMedecinsParHopital(id)));
    }
}


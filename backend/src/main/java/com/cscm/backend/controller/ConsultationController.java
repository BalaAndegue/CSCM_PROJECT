package com.cscm.backend.controller;

import com.cscm.backend.entity.Consultation;
import com.cscm.backend.entity.User;
import com.cscm.backend.service.ConsultationService;
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

import java.util.UUID;

@RestController
@RequestMapping("/consultations")
@RequiredArgsConstructor
@Tag(name = "Consultations", description = "Gestion des consultations médicales")
public class ConsultationController {

    private final ConsultationService consultationService;
    private final MedecinService medecinService;
    private final com.cscm.backend.repository.UserRepository userRepository;

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Consultations d'un carnet")
    public ResponseEntity<ApiResponse<Page<Consultation>>> getByCarnet(
            @PathVariable UUID carnetId, @PageableDefault(size = 20, sort = "dateConsultation") Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(consultationService.getConsultationsByCarnet(carnetId, pageable)));
    }

    @GetMapping("/medecin/{medecinId}")
    @Operation(summary = "Consultations d'un médecin")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<Page<Consultation>>> getByMedecin(
            @PathVariable UUID medecinId, @PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(consultationService.getConsultationsByMedecin(medecinId, pageable)));
    }

    @PostMapping("/carnet/{carnetId}")
    @Operation(summary = "Ajouter une consultation")
    @PreAuthorize("hasRole('MEDECIN')")
    public ResponseEntity<ApiResponse<Consultation>> create(
            @PathVariable UUID carnetId,
            @RequestParam(required = false) UUID hopitalId,
            @RequestBody Consultation data,
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        var medecin = medecinService.getMedecinByUserId(user.getId());
        Consultation created = consultationService.createConsultation(carnetId, medecin.getId(), hopitalId, data);
        return ResponseEntity.ok(ApiResponse.success(created, "Consultation ajoutée"));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'une consultation")
    public ResponseEntity<ApiResponse<Consultation>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(consultationService.getConsultationById(id)));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Modifier une consultation")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<Consultation>> update(
            @PathVariable UUID id, @RequestBody Consultation updates) {
        return ResponseEntity.ok(ApiResponse.success(consultationService.updateConsultation(id, updates), "Consultation mise à jour"));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Supprimer une consultation (admin)")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable UUID id) {
        consultationService.deleteConsultation(id);
        return ResponseEntity.ok(ApiResponse.ok("Consultation supprimée"));
    }
}

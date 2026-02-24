package com.cscm.backend.controller;

import com.cscm.backend.entity.ConsentDiagnosticHopital;
import com.cscm.backend.entity.User;
import com.cscm.backend.service.ConsentService;
import com.cscm.backend.service.MedecinService;
import com.cscm.backend.util.ApiResponse;
import com.cscm.backend.dto.request.DemandeConsentRequest;
import com.cscm.backend.dto.request.MotifRequest;
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
@RequestMapping("/consents")
@RequiredArgsConstructor
@Tag(name = "Consentements Diagnostic", description = "Gestion des autorisations diagnostic hôpital")
public class ConsentController {

    private final ConsentService consentService;
    private final MedecinService medecinService;
    private final com.cscm.backend.repository.UserRepository userRepository;

    @GetMapping("/hopital/{hopitalId}")
    @Operation(summary = "Consentements d'un hôpital")
    @PreAuthorize("hasAnyRole('MANAGER_HOPITAL', 'ADMIN')")
    public ResponseEntity<ApiResponse<Page<ConsentDiagnosticHopital>>> getByHopital(
            @PathVariable UUID hopitalId, @PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(consentService.getByHopital(hopitalId, pageable)));
    }

    @GetMapping("/hopital/{hopitalId}/pending")
    @Operation(summary = "Consentements en attente (manager)")
    @PreAuthorize("hasAnyRole('MANAGER_HOPITAL', 'ADMIN')")
    public ResponseEntity<ApiResponse<Page<ConsentDiagnosticHopital>>> getPending(
            @PathVariable UUID hopitalId, @PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(consentService.getPendingByHopital(hopitalId, pageable)));
    }

    @PostMapping
    @Operation(summary = "Demander un consentement (médecin)")
    @PreAuthorize("hasRole('MEDECIN')")
    public ResponseEntity<ApiResponse<ConsentDiagnosticHopital>> demander(
            @RequestBody DemandeConsentRequest req,
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        var medecin = medecinService.getMedecinByUserId(user.getId());
        ConsentDiagnosticHopital consent = consentService.demanderConsent(
                req.getConsultationId(), medecin.getId(), req.getHopitalId(), req.getMotif());
        return ResponseEntity.ok(ApiResponse.success(consent, "Demande de consentement envoyée"));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Détail d'un consentement")
    public ResponseEntity<ApiResponse<ConsentDiagnosticHopital>> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(consentService.getById(id)));
    }

    @PutMapping("/{id}/approuver")
    @Operation(summary = "Approuver le consentement (manager hôpital)")
    @PreAuthorize("hasAnyRole('MANAGER_HOPITAL', 'ADMIN')")
    public ResponseEntity<ApiResponse<ConsentDiagnosticHopital>> approuver(
            @PathVariable UUID id, @AuthenticationPrincipal UserDetails userDetails) {
        User manager = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        return ResponseEntity.ok(ApiResponse.success(consentService.approuver(id, manager.getId()), "Consentement approuvé"));
    }

    @PutMapping("/{id}/refuser")
    @Operation(summary = "Refuser le consentement (manager hôpital)")
    @PreAuthorize("hasAnyRole('MANAGER_HOPITAL', 'ADMIN')")
    public ResponseEntity<ApiResponse<ConsentDiagnosticHopital>> refuser(
            @PathVariable UUID id,
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestBody MotifRequest req) {
        User manager = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        return ResponseEntity.ok(ApiResponse.success(consentService.refuser(id, manager.getId(), req.getMotif()), "Consentement refusé"));
    }
}


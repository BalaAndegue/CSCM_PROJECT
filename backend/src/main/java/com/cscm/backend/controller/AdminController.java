package com.cscm.backend.controller;

import com.cscm.backend.entity.User;
import com.cscm.backend.enums.MedecinStatus;
import com.cscm.backend.repository.*;
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
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/admin")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
@Tag(name = "Administration", description = "Gestion globale de la plateforme (ADMIN seulement)")
public class AdminController {

    private final UserRepository userRepository;
    private final MedecinService medecinService;
    private final PatientRepository patientRepository;
    private final MedecinRepository medecinRepository;
    private final AuditLogRepository auditLogRepository;
    private final AbonnementRepository abonnementRepository;

    @GetMapping("/users")
    @Operation(summary = "Lister tous les utilisateurs")
    public ResponseEntity<ApiResponse<Page<User>>> getAllUsers(@PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(userRepository.findAll(pageable)));
    }

    @PutMapping("/users/{id}/desactiver")
    @Operation(summary = "Désactiver un compte")
    public ResponseEntity<ApiResponse<Void>> desactiver(@PathVariable UUID id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new com.cscm.backend.exception.ResourceNotFoundException("Utilisateur introuvable"));
        user.setCompteActif(false);
        userRepository.save(user);
        return ResponseEntity.ok(ApiResponse.ok("Compte désactivé"));
    }

    @PutMapping("/users/{id}/activer")
    @Operation(summary = "Activer un compte")
    public ResponseEntity<ApiResponse<Void>> activer(@PathVariable UUID id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new com.cscm.backend.exception.ResourceNotFoundException("Utilisateur introuvable"));
        user.setCompteActif(true);
        userRepository.save(user);
        return ResponseEntity.ok(ApiResponse.ok("Compte activé"));
    }

    @GetMapping("/medecins/pending")
    @Operation(summary = "Médecins en attente de validation")
    public ResponseEntity<ApiResponse<Page<?>>> getMedecinsPending(@PageableDefault(size = 20) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(medecinService.getMedecinsByStatus(MedecinStatus.EN_ATTENTE, pageable)));
    }

    @GetMapping("/audit-logs")
    @Operation(summary = "Journaux d'audit")
    public ResponseEntity<ApiResponse<?>> getAuditLogs(@PageableDefault(size = 50) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(auditLogRepository.findAll(pageable)));
    }

    @GetMapping("/audit-logs/user/{userId}")
    @Operation(summary = "Logs d'un utilisateur")
    public ResponseEntity<ApiResponse<?>> getByUser(@PathVariable UUID userId, @PageableDefault(size = 50) Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(auditLogRepository.findByUserId(userId, pageable)));
    }

    @GetMapping("/stats")
    @Operation(summary = "Statistiques globales")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalPatients", patientRepository.count());
        stats.put("totalMedecins", medecinRepository.count());
        stats.put("medecinsPendants", medecinRepository.countByStatus(MedecinStatus.EN_ATTENTE));
        stats.put("medecinsValides", medecinRepository.countByStatus(MedecinStatus.VALIDE));
        stats.put("totalUtilisateurs", userRepository.count());
        stats.put("abonnementsActifs", abonnementRepository.countByStatut(com.cscm.backend.enums.AbonnementStatut.ACTIF));
        return ResponseEntity.ok(ApiResponse.success(stats));
    }
}

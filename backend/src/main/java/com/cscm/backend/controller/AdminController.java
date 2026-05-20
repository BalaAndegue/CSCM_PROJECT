package com.cscm.backend.controller;

import com.cscm.backend.enums.MedecinStatus;
import com.cscm.backend.repository.*;
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

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/admin")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
@Tag(name = "Administration", description = "Gestion globale de la plateforme – ADMIN uniquement")
public class AdminController {

    private final UserRepository userRepository;
    private final MedecinService medecinService;
    private final PatientRepository patientRepository;
    private final MedecinRepository medecinRepository;
    private final AuditLogRepository auditLogRepository;
    private final AbonnementRepository abonnementRepository;

    @GetMapping("/users")
    @Operation(summary = "Lister les utilisateurs actifs paginés")
    Mono<ResponseEntity<ApiResponse<?>>> getAllUsers(
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "0") long offset,
            @RequestParam(defaultValue = "PATIENT") String role) {
        return userRepository.findActiveByRolePaged(role, size, offset)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @PutMapping("/users/{id}/desactiver")
    @Operation(summary = "Désactiver un compte utilisateur")
    Mono<ResponseEntity<ApiResponse<Void>>> desactiver(@PathVariable UUID id) {
        return userRepository.findById(id)
                .switchIfEmpty(Mono.error(new com.cscm.backend.exception.BusinessException("Utilisateur introuvable")))
                .flatMap(user -> {
                    user.setCompteActif(false);
                    return userRepository.save(user);
                })
                .thenReturn(ResponseEntity.ok(ApiResponse.<Void>ok("Compte désactivé")));
    }

    @PutMapping("/users/{id}/activer")
    @Operation(summary = "Activer un compte utilisateur")
    Mono<ResponseEntity<ApiResponse<Void>>> activer(@PathVariable UUID id) {
        return userRepository.findById(id)
                .switchIfEmpty(Mono.error(new com.cscm.backend.exception.BusinessException("Utilisateur introuvable")))
                .flatMap(user -> {
                    user.setCompteActif(true);
                    return userRepository.save(user);
                })
                .thenReturn(ResponseEntity.ok(ApiResponse.<Void>ok("Compte activé")));
    }

    @GetMapping("/medecins/pending")
    @Operation(summary = "Médecins en attente de validation")
    Mono<ResponseEntity<ApiResponse<?>>> getMedecinsPending(
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "0") long offset) {
        return medecinService.getMedecinsEnAttente(size, offset)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @PutMapping("/medecins/{id}/valider")
    @Operation(summary = "Valider l'inscription d'un médecin")
    Mono<ResponseEntity<ApiResponse<?>>> validerMedecin(
            @PathVariable UUID id,
            @AuthenticationPrincipal String adminIdStr) {
        return medecinService.validerMedecin(id, UUID.fromString(adminIdStr))
                .map(m -> ResponseEntity.ok(ApiResponse.success(m, "Médecin validé")));
    }

    @PutMapping("/medecins/{id}/rejeter")
    @Operation(summary = "Rejeter l'inscription d'un médecin")
    Mono<ResponseEntity<ApiResponse<Void>>> rejeterMedecin(
            @PathVariable UUID id,
            @AuthenticationPrincipal String adminIdStr,
            @RequestBody Map<String, String> body) {
        return medecinService.rejeterMedecin(id, UUID.fromString(adminIdStr), body.get("raison"))
                .thenReturn(ResponseEntity.ok(ApiResponse.<Void>ok("Médecin rejeté")));
    }

    @PutMapping("/medecins/{id}/suspendre")
    @Operation(summary = "Suspendre un médecin")
    Mono<ResponseEntity<ApiResponse<Void>>> suspendMedecin(
            @PathVariable UUID id,
            @AuthenticationPrincipal String adminIdStr) {
        return medecinService.suspendMedecin(id, UUID.fromString(adminIdStr))
                .thenReturn(ResponseEntity.ok(ApiResponse.<Void>ok("Médecin suspendu")));
    }

    @GetMapping("/audit-logs")
    @Operation(summary = "Journaux d'audit paginés")
    Mono<ResponseEntity<ApiResponse<?>>> getAuditLogs(
            @RequestParam(defaultValue = "50") int size,
            @RequestParam(defaultValue = "0") long offset) {
        return auditLogRepository.findAllPaged(size, offset)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/audit-logs/user/{userId}")
    @Operation(summary = "Logs d'un utilisateur")
    Mono<ResponseEntity<ApiResponse<?>>> getByUser(
            @PathVariable UUID userId,
            @RequestParam(defaultValue = "50") int size,
            @RequestParam(defaultValue = "0") long offset) {
        return auditLogRepository.findByUserId(userId, size, offset)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/stats")
    @Operation(summary = "Statistiques globales de la plateforme")
    Mono<ResponseEntity<ApiResponse<Map<String, Object>>>> getStats() {
        return Mono.zip(
                patientRepository.count(),
                medecinRepository.count(),
                medecinRepository.countByStatus(MedecinStatus.EN_ATTENTE),
                medecinRepository.countByStatus(MedecinStatus.VALIDE),
                userRepository.count(),
                abonnementRepository.countByStatut(com.cscm.backend.enums.AbonnementStatut.ACTIF)
        ).map(tuple -> {
            Map<String, Object> stats = Map.of(
                    "totalPatients", tuple.getT1(),
                    "totalMedecins", tuple.getT2(),
                    "medecinsPendants", tuple.getT3(),
                    "medecinsValides", tuple.getT4(),
                    "totalUtilisateurs", tuple.getT5(),
                    "abonnementsActifs", tuple.getT6()
            );
            return ResponseEntity.ok(ApiResponse.success(stats));
        });
    }
}

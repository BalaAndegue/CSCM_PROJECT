package com.cscm.backend.controller;

import com.cscm.backend.dto.request.*;
import com.cscm.backend.service.AuthService;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.Map;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@Tag(name = "Authentification", description = "Inscription, connexion, gestion des tokens JWT")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/register/patient")
    @Operation(summary = "Inscription patient – CNI + avariste obligatoires")
    Mono<ResponseEntity<ApiResponse<Map<String, Object>>>> registerPatient(
            @Valid @RequestBody RegisterPatientRequest req) {
        return authService.registerPatient(
                        req.getEmail(), req.getMotDePasse(), req.getNomComplet(), req.getTelephone(),
                        req.getDateNaissance(), req.getGenre(),
                        req.getNumeroCNI(), req.getDateDelivranceCNI(), req.getLieuDelivranceCNI(),
                        req.getLieuNaissance(), req.getNationalite(),
                        req.getGarantNomComplet(), req.getGarantTelephone(), req.getGarantLienParente(),
                        req.getGarantNumeroCNI(), req.getGarantEmail())
                .map(data -> ResponseEntity.ok(ApiResponse.success(data, "Inscription réussie. Vérifiez votre email.")));
    }

    @PostMapping("/register/medecin")
    @Operation(summary = "Inscription médecin – CNOM + CNI obligatoires")
    Mono<ResponseEntity<ApiResponse<Map<String, Object>>>> registerMedecin(
            @Valid @RequestBody RegisterMedecinRequest req) {
        return authService.registerMedecin(
                        req.getEmail(), req.getMotDePasse(), req.getNomComplet(), req.getTelephone(),
                        req.getSpecialite(), req.getNumeroCNOM(),
                        req.getNumeroCNI(), req.getDateDelivranceCNI(), req.getLieuDelivranceCNI(),
                        req.getVillePrincipale(), req.getRegionPrincipale())
                .map(data -> ResponseEntity.ok(ApiResponse.success(data, "Inscription soumise. En attente de validation CNOM/MINSANTE.")));
    }

    @PostMapping("/login")
    @Operation(summary = "Connexion utilisateur")
    Mono<ResponseEntity<ApiResponse<Map<String, Object>>>> login(@Valid @RequestBody LoginRequest req) {
        return authService.login(req.getEmail(), req.getMotDePasse())
                .map(data -> ResponseEntity.ok(ApiResponse.success(data, "Connexion réussie")));
    }

    @PostMapping("/refresh")
    @Operation(summary = "Renouveler le token JWT")
    Mono<ResponseEntity<ApiResponse<Map<String, Object>>>> refresh(@RequestBody RefreshRequest req) {
        return authService.refreshToken(req.getRefreshToken())
                .map(data -> ResponseEntity.ok(ApiResponse.success(data, "Token renouvelé")));
    }

    @PostMapping("/forgot-password")
    @Operation(summary = "Demande de réinitialisation du mot de passe")
    Mono<ResponseEntity<ApiResponse<Void>>> forgotPassword(@RequestBody EmailRequest req) {
        return authService.forgotPassword(req.getEmail())
                .thenReturn(ResponseEntity.ok(ApiResponse.<Void>ok("Si ce compte existe, un email a été envoyé.")));
    }

    @PostMapping("/reset-password")
    @Operation(summary = "Réinitialiser le mot de passe via token")
    Mono<ResponseEntity<ApiResponse<Void>>> resetPassword(@Valid @RequestBody ResetPasswordRequest req) {
        return authService.resetPassword(req.getToken(), req.getNouveauMotDePasse())
                .thenReturn(ResponseEntity.ok(ApiResponse.<Void>ok("Mot de passe réinitialisé avec succès")));
    }

    @PostMapping("/verify-email")
    @Operation(summary = "Vérifier l'adresse email")
    Mono<ResponseEntity<ApiResponse<Void>>> verifyEmail(@RequestParam String token) {
        return authService.verifyEmail(token)
                .thenReturn(ResponseEntity.ok(ApiResponse.<Void>ok("Email vérifié avec succès")));
    }
}

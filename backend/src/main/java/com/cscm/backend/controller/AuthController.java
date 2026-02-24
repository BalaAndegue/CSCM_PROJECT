package com.cscm.backend.controller;

import com.cscm.backend.enums.Genre;
import com.cscm.backend.service.AuthService;
import com.cscm.backend.util.ApiResponse;
import com.cscm.backend.dto.request.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@Tag(name = "Authentification", description = "Inscription, connexion, gestion des tokens")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/register/patient")
    @Operation(summary = "Inscription d'un patient")
    public ResponseEntity<ApiResponse<Map<String, Object>>> registerPatient(
            @Valid @RequestBody RegisterPatientRequest req) {
        Map<String, Object> data = authService.registerPatient(
                req.getEmail(), req.getMotDePasse(), req.getNomComplet(), req.getTelephone(),
                req.getDateNaissance(), req.getGenre());
        return ResponseEntity.ok(ApiResponse.success(data, "Inscription réussie. Vérifiez votre email."));
    }

    @PostMapping("/register/medecin")
    @Operation(summary = "Inscription d'un médecin")
    public ResponseEntity<ApiResponse<Map<String, Object>>> registerMedecin(
            @Valid @RequestBody RegisterMedecinRequest req) {
        Map<String, Object> data = authService.registerMedecin(
                req.getEmail(), req.getMotDePasse(), req.getNomComplet(), req.getTelephone(),
                req.getSpecialite(), req.getNumeroOrdre(), req.getNumeroCarteProfessionnelle());
        return ResponseEntity.ok(ApiResponse.success(data, "Inscription soumise. En attente de validation."));
    }

    @PostMapping("/login")
    @Operation(summary = "Connexion utilisateur")
    public ResponseEntity<ApiResponse<Map<String, Object>>> login(@Valid @RequestBody LoginRequest req) {
        Map<String, Object> data = authService.login(req.getEmail(), req.getMotDePasse());
        return ResponseEntity.ok(ApiResponse.success(data, "Connexion réussie"));
    }

    @PostMapping("/refresh")
    @Operation(summary = "Renouvelé le token JWT")
    public ResponseEntity<ApiResponse<Map<String, Object>>> refresh(@RequestBody RefreshRequest req) {
        Map<String, Object> data = authService.refreshToken(req.getRefreshToken());
        return ResponseEntity.ok(ApiResponse.success(data, "Token renouvelé"));
    }

    @PostMapping("/logout")
    @Operation(summary = "Déconnexion")
    public ResponseEntity<ApiResponse<Void>> logout(@RequestHeader("Authorization") String authHeader) {
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            authService.logout(authHeader.substring(7));
        }
        return ResponseEntity.ok(ApiResponse.ok("Déconnexion réussie"));
    }

    @PostMapping("/forgot-password")
    @Operation(summary = "Mot de passe oublié – envoi du lien de réinitialisation")
    public ResponseEntity<ApiResponse<Void>> forgotPassword(@RequestBody EmailRequest req) {
        authService.forgotPassword(req.getEmail());
        return ResponseEntity.ok(ApiResponse.ok("Si ce compte existe, un email a été envoyé."));
    }

    @PostMapping("/reset-password")
    @Operation(summary = "Réinitialiser le mot de passe")
    public ResponseEntity<ApiResponse<Void>> resetPassword(@Valid @RequestBody ResetPasswordRequest req) {
        authService.resetPassword(req.getToken(), req.getNouveauMotDePasse());
        return ResponseEntity.ok(ApiResponse.ok("Mot de passe réinitialisé avec succès"));
    }

    @PostMapping("/verify-email")
    @Operation(summary = "Vérifier l'adresse email")
    public ResponseEntity<ApiResponse<Void>> verifyEmail(@RequestParam String token) {
        authService.verifyEmail(token);
        return ResponseEntity.ok(ApiResponse.ok("Email vérifié avec succès"));
    }
}


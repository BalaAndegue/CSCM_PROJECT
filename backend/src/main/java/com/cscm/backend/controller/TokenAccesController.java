package com.cscm.backend.controller;

import com.cscm.backend.service.TokenAccesService;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/acces")
@RequiredArgsConstructor
@Tag(name = "Accès Carnet", description = "Génération et validation QR code / code court")
public class TokenAccesController {

    private final TokenAccesService tokenAccesService;

    // ─── Génération QR Code ──────────────────────────────────────────────────

    @PostMapping("/qr/{carnetId}")
    @Operation(summary = "Générer un QR code d'accès temporaire (patient)")
    Mono<ResponseEntity<byte[]>> genererQr(
            @PathVariable UUID carnetId,
            @AuthenticationPrincipal String patientIdStr,
            @RequestBody(required = false) AccesRequest req) {
        if (req == null) req = new AccesRequest();
        AccesRequest finalReq = req;
        return tokenAccesService.genererTokenQr(
                        carnetId, UUID.fromString(patientIdStr),
                        finalReq.isAccesHistorique(), finalReq.isAccesOrdonnances(),
                        finalReq.isAccesExamens(), finalReq.isPeutEditer())
                .map(result -> ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_PNG)
                        .header(HttpHeaders.CONTENT_DISPOSITION,
                                "inline; filename=\"qr-acces-" + carnetId + ".png\"")
                        .header("X-Token-Id", result.token().getId().toString())
                        .body(result.qrCodePng()));
    }

    // ─── Génération Code Court ───────────────────────────────────────────────

    @PostMapping("/code/{carnetId}")
    @Operation(summary = "Générer un code à 6 chiffres d'accès temporaire (patient)")
    Mono<ResponseEntity<ApiResponse<?>>> genererCode(
            @PathVariable UUID carnetId,
            @AuthenticationPrincipal String patientIdStr,
            @RequestBody(required = false) AccesRequest req) {
        if (req == null) req = new AccesRequest();
        AccesRequest finalReq = req;
        return tokenAccesService.genererCodeCourt(
                        carnetId, UUID.fromString(patientIdStr),
                        finalReq.isAccesHistorique(), finalReq.isAccesOrdonnances(),
                        finalReq.isAccesExamens(), finalReq.isPeutEditer())
                .map(token -> ResponseEntity.ok(ApiResponse.success(
                        Map.of("codeCourt", token.getCodeCourt(),
                               "tokenId", token.getId(),
                               "expiresAt", token.getExpiresAt()),
                        "Code généré – valable 30 minutes")));
    }

    // ─── Validation par le médecin ───────────────────────────────────────────

    @PostMapping("/valider/qr")
    @Operation(summary = "Valider un QR code et obtenir l'accès (médecin)")
    Mono<ResponseEntity<ApiResponse<?>>> validerQr(
            @RequestBody Map<String, String> body,
            @AuthenticationPrincipal String medecinIdStr) {
        return tokenAccesService.validerQrEtAccorder(
                        body.get("qrPayload"), UUID.fromString(medecinIdStr))
                .map(token -> ResponseEntity.ok(ApiResponse.success(token, "Accès accordé via QR code")));
    }

    @PostMapping("/valider/code")
    @Operation(summary = "Valider un code à 6 chiffres et obtenir l'accès (médecin)")
    Mono<ResponseEntity<ApiResponse<?>>> validerCode(
            @RequestBody Map<String, String> body,
            @AuthenticationPrincipal String medecinIdStr) {
        return tokenAccesService.validerCodeCourtEtAccorder(
                        body.get("codeCourt"), UUID.fromString(medecinIdStr))
                .map(token -> ResponseEntity.ok(ApiResponse.success(token, "Accès accordé via code")));
    }

    // ─── Révocation ──────────────────────────────────────────────────────────

    @DeleteMapping("/revoquer/{tokenId}")
    @Operation(summary = "Révoquer un token d'accès (patient)")
    Mono<ResponseEntity<ApiResponse<Void>>> revoquerToken(
            @PathVariable UUID tokenId,
            @AuthenticationPrincipal String patientIdStr) {
        return tokenAccesService.revoquerToken(tokenId, UUID.fromString(patientIdStr))
                .thenReturn(ResponseEntity.ok(ApiResponse.<Void>ok("Token révoqué")));
    }

    @DeleteMapping("/revoquer/carnet/{carnetId}")
    @Operation(summary = "Révoquer tous les tokens actifs d'un carnet (patient)")
    Mono<ResponseEntity<ApiResponse<Void>>> revoquerTous(@PathVariable UUID carnetId) {
        return tokenAccesService.revoquerTousLesTokensCarnet(carnetId)
                .thenReturn(ResponseEntity.ok(ApiResponse.<Void>ok("Tous les accès révoqués")));
    }

    // ─── Listing ─────────────────────────────────────────────────────────────

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Tokens actifs pour un carnet")
    Mono<ResponseEntity<ApiResponse<?>>> getTokensActifs(@PathVariable UUID carnetId) {
        return tokenAccesService.getTokensActifsCarnet(carnetId)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/historique")
    @Operation(summary = "Historique complet des accès du patient")
    Mono<ResponseEntity<ApiResponse<?>>> getHistorique(@AuthenticationPrincipal String patientIdStr) {
        return tokenAccesService.getHistoriquePatient(UUID.fromString(patientIdStr))
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    // ─── DTO interne ─────────────────────────────────────────────────────────

    @Data
    static class AccesRequest {
        private boolean accesHistorique = true;
        private boolean accesOrdonnances = true;
        private boolean accesExamens = true;
        private boolean peutEditer = false;
    }
}

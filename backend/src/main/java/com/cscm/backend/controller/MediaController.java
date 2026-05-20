package com.cscm.backend.controller;

import com.cscm.backend.enums.TypeMedia;
import com.cscm.backend.service.MediaService;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.codec.multipart.FilePart;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.UUID;

@RestController
@RequestMapping("/medias")
@RequiredArgsConstructor
@Tag(name = "Médias Médicaux", description = "Upload, téléchargement et gestion des fichiers médicaux")
public class MediaController {

    private final MediaService mediaService;

    @PostMapping(value = "/carnet/{carnetId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @Operation(summary = "Uploader un fichier médical")
    Mono<ResponseEntity<ApiResponse<?>>> uploader(
            @PathVariable UUID carnetId,
            @RequestPart("fichier") FilePart fichier,
            @RequestParam TypeMedia typeMedia,
            @RequestParam(defaultValue = "false") boolean confidentiel,
            @RequestParam(required = false) UUID consultationId,
            @RequestParam(required = false) UUID examenId,
            @RequestParam(required = false) UUID ordonnanceId,
            @AuthenticationPrincipal String userIdStr) {
        return mediaService.uploader(fichier, carnetId, UUID.fromString(userIdStr),
                        typeMedia, confidentiel, consultationId, examenId, ordonnanceId)
                .map(media -> ResponseEntity.ok(ApiResponse.success(media, "Fichier uploadé avec succès")));
    }

    @GetMapping("/{mediaId}/info")
    @Operation(summary = "Informations sur un fichier médical")
    Mono<ResponseEntity<ApiResponse<?>>> getInfo(@PathVariable UUID mediaId) {
        return mediaService.getMediaInfo(mediaId)
                .map(media -> ResponseEntity.ok(ApiResponse.success(media)));
    }

    @GetMapping("/{mediaId}/download")
    @Operation(summary = "Télécharger un fichier médical")
    Mono<ResponseEntity<Resource>> telecharger(
            @PathVariable UUID mediaId,
            @AuthenticationPrincipal String userIdStr) {
        return mediaService.getMediaInfo(mediaId)
                .flatMap(media -> mediaService.telecharger(mediaId, UUID.fromString(userIdStr))
                        .map(resource -> ResponseEntity.ok()
                                .contentType(MediaType.parseMediaType(media.getTypeMime()))
                                .header(HttpHeaders.CONTENT_DISPOSITION,
                                        ContentDisposition.attachment()
                                                .filename(media.getNomOriginal()).build().toString())
                                .body(resource)));
    }

    @GetMapping("/carnet/{carnetId}")
    @Operation(summary = "Tous les médias d'un carnet")
    Mono<ResponseEntity<ApiResponse<?>>> getMediasCarnet(@PathVariable UUID carnetId) {
        return mediaService.getMediasCarnet(carnetId)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/carnet/{carnetId}/type/{typeMedia}")
    @Operation(summary = "Médias d'un carnet filtrés par type")
    Mono<ResponseEntity<ApiResponse<?>>> getParType(
            @PathVariable UUID carnetId,
            @PathVariable TypeMedia typeMedia) {
        return mediaService.getMediasParType(carnetId, typeMedia)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/consultation/{consultationId}")
    @Operation(summary = "Médias d'une consultation")
    Mono<ResponseEntity<ApiResponse<?>>> getParConsultation(@PathVariable UUID consultationId) {
        return mediaService.getMediasConsultation(consultationId)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/examen/{examenId}")
    @Operation(summary = "Médias d'un examen")
    Mono<ResponseEntity<ApiResponse<?>>> getParExamen(@PathVariable UUID examenId) {
        return mediaService.getMediasExamen(examenId)
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/carnet/{carnetId}/stockage")
    @Operation(summary = "Espace total utilisé par le carnet")
    Mono<ResponseEntity<ApiResponse<?>>> getStockage(@PathVariable UUID carnetId) {
        return mediaService.getTailleStockageCarnet(carnetId)
                .map(taille -> ResponseEntity.ok(ApiResponse.success(
                        java.util.Map.of("tailleOctets", taille,
                                "tailleMo", taille / (1024.0 * 1024.0)))));
    }

    @DeleteMapping("/{mediaId}")
    @Operation(summary = "Supprimer un fichier médical (suppression logique)")
    Mono<ResponseEntity<ApiResponse<Void>>> supprimer(
            @PathVariable UUID mediaId,
            @AuthenticationPrincipal String userIdStr) {
        return mediaService.supprimerMedia(mediaId, UUID.fromString(userIdStr))
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Fichier supprimé")));
    }
}

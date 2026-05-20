package com.cscm.backend.service;

import com.cscm.backend.entity.MediaFichier;
import com.cscm.backend.enums.TypeMedia;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.repository.MediaFichierRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.http.codec.multipart.FilePart;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class MediaService {

    private final MediaFichierRepository mediaRepo;
    private final FileStorageService fileStorage;

    private static final long MAX_SIZE_BYTES = 50L * 1024 * 1024; // 50 MB

    private static final Map<String, Set<TypeMedia>> MIME_TYPE_MAP = Map.of(
            "image/jpeg", Set.of(TypeMedia.RADIOGRAPHIE, TypeMedia.ECHOGRAPHIE,
                    TypeMedia.FOND_OEIL, TypeMedia.PHOTO_PORTRAIT, TypeMedia.AUTRE),
            "image/png", Set.of(TypeMedia.RADIOGRAPHIE, TypeMedia.PHOTO_PORTRAIT, TypeMedia.AUTRE),
            "application/pdf", Set.of(TypeMedia.ORDONNANCE_NUMERISEE, TypeMedia.CERTIFICAT_MEDICAL,
                    TypeMedia.COMPTE_RENDU_HOSPITALISATION, TypeMedia.BILAN_BIOLOGIQUE,
                    TypeMedia.ANATOMOPATHOLOGIE, TypeMedia.AUTRE),
            "video/mp4", Set.of(TypeMedia.ECHOGRAPHIE_CARDIAQUE, TypeMedia.ECHOGRAPHIE,
                    TypeMedia.ENDOSCOPIE, TypeMedia.COLONOSCOPIE, TypeMedia.VIDEO_EXAMEN),
            "application/dicom", Set.of(TypeMedia.SCANNER_CT, TypeMedia.IRM, TypeMedia.RADIOGRAPHIE,
                    TypeMedia.SCINTIGRAPHIE, TypeMedia.PET_SCAN)
    );

    // ─── Upload ──────────────────────────────────────────────────────────────

    public Mono<MediaFichier> uploader(FilePart filePart, UUID carnetId, UUID uploadedBy,
                                        TypeMedia typeMedia, boolean confidentiel,
                                        UUID consultationId, UUID examenId, UUID ordonnanceId) {
        String subDir = "carnets/" + carnetId + "/" + typeMedia.name().toLowerCase();

        return fileStorage.store(filePart, subDir)
                .flatMap(result -> {
                    if (result.tailleFichier() > MAX_SIZE_BYTES) {
                        return fileStorage.delete(result.cheminStockage())
                                .then(Mono.error(new BusinessException(
                                        "Fichier trop volumineux (max 50 Mo): " + result.tailleFichier() / 1024 / 1024 + " Mo")));
                    }

                    MediaFichier media = MediaFichier.builder()
                            .id(UUID.randomUUID())
                            .carnetId(carnetId)
                            .uploadedBy(uploadedBy)
                            .typeMedia(typeMedia)
                            .nomOriginal(filePart.filename())
                            .nomStockage(result.nomStockage())
                            .cheminStockage(result.cheminStockage())
                            .typeMime(detecterMime(filePart.filename()))
                            .tailleFichier(result.tailleFichier())
                            .checksum(result.checksum())
                            .confidentiel(confidentiel)
                            .actif(true)
                            .consultationId(consultationId)
                            .examenId(examenId)
                            .ordonnanceId(ordonnanceId)
                            .build();

                    return mediaRepo.save(media);
                })
                .doOnSuccess(m -> log.info("Média uploadé: carnet={} type={} taille={}o",
                        carnetId, typeMedia, m.getTailleFichier()))
                .doOnError(e -> log.error("Erreur upload média: {}", e.getMessage()));
    }

    // ─── Téléchargement ──────────────────────────────────────────────────────

    public Mono<Resource> telecharger(UUID mediaId, UUID demandeurId) {
        return mediaRepo.findById(mediaId)
                .switchIfEmpty(Mono.error(new BusinessException("Fichier introuvable")))
                .flatMap(media -> {
                    if (!media.getActif()) {
                        return Mono.error(new BusinessException("Fichier supprimé"));
                    }
                    // Les vérifications d'autorisation sont faites dans le contrôleur
                    return fileStorage.load(media.getCheminStockage());
                });
    }

    public Mono<MediaFichier> getMediaInfo(UUID mediaId) {
        return mediaRepo.findById(mediaId)
                .switchIfEmpty(Mono.error(new BusinessException("Fichier introuvable")));
    }

    // ─── Listing ─────────────────────────────────────────────────────────────

    public Flux<MediaFichier> getMediasCarnet(UUID carnetId) {
        return mediaRepo.findByCarnetIdAndActifTrue(carnetId);
    }

    public Flux<MediaFichier> getMediasParType(UUID carnetId, TypeMedia typeMedia) {
        return mediaRepo.findByCarnetIdAndTypeMediaAndActifTrue(carnetId, typeMedia);
    }

    public Flux<MediaFichier> getMediasConsultation(UUID consultationId) {
        return mediaRepo.findByConsultationId(consultationId);
    }

    public Flux<MediaFichier> getMediasExamen(UUID examenId) {
        return mediaRepo.findByExamenId(examenId);
    }

    public Mono<Long> getTailleStockageCarnet(UUID carnetId) {
        return mediaRepo.getTotalSizeForCarnet(carnetId);
    }

    // ─── Suppression logique ─────────────────────────────────────────────────

    public Mono<Void> supprimerMedia(UUID mediaId, UUID demandeurId) {
        return mediaRepo.findById(mediaId)
                .switchIfEmpty(Mono.error(new BusinessException("Fichier introuvable")))
                .flatMap(media -> {
                    media.setActif(false);
                    return mediaRepo.save(media);
                })
                .then();
    }

    // ─── Helpers ─────────────────────────────────────────────────────────────

    private String detecterMime(String filename) {
        if (filename == null) return "application/octet-stream";
        String lower = filename.toLowerCase();
        if (lower.endsWith(".jpg") || lower.endsWith(".jpeg")) return "image/jpeg";
        if (lower.endsWith(".png")) return "image/png";
        if (lower.endsWith(".pdf")) return "application/pdf";
        if (lower.endsWith(".mp4")) return "video/mp4";
        if (lower.endsWith(".dcm")) return "application/dicom";
        if (lower.endsWith(".gif")) return "image/gif";
        if (lower.endsWith(".mp3") || lower.endsWith(".wav")) return "audio/mpeg";
        return "application/octet-stream";
    }
}

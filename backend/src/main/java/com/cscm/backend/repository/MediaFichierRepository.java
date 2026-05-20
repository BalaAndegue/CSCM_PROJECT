package com.cscm.backend.repository;

import com.cscm.backend.entity.MediaFichier;
import com.cscm.backend.enums.TypeMedia;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface MediaFichierRepository extends R2dbcRepository<MediaFichier, UUID> {

    Flux<MediaFichier> findByCarnetIdAndActifTrue(UUID carnetId);
    Flux<MediaFichier> findByCarnetIdAndTypeMediaAndActifTrue(UUID carnetId, TypeMedia typeMedia);
    Flux<MediaFichier> findByExamenId(UUID examenId);
    Flux<MediaFichier> findByConsultationId(UUID consultationId);
    Mono<MediaFichier> findByNomStockage(String nomStockage);

    @Query("SELECT * FROM medias_fichiers WHERE carnet_id = :carnetId AND actif = TRUE ORDER BY created_at DESC LIMIT :size OFFSET :offset")
    Flux<MediaFichier> findByCarnetIdPaged(UUID carnetId, int size, long offset);

    @Query("SELECT SUM(taille_fichier) FROM medias_fichiers WHERE carnet_id = :carnetId AND actif = TRUE")
    Mono<Long> getTotalSizeForCarnet(UUID carnetId);
}

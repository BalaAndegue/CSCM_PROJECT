package com.cscm.backend.repository;

import com.cscm.backend.entity.ApprobationMedecin;
import org.springframework.data.r2dbc.repository.Modifying;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.UUID;

public interface ApprobationMedecinRepository extends R2dbcRepository<ApprobationMedecin, UUID> {

    Flux<ApprobationMedecin> findByCarnetIdAndActifTrue(UUID carnetId);
    Mono<ApprobationMedecin> findByCarnetIdAndMedecinId(UUID carnetId, UUID medecinId);
    Flux<ApprobationMedecin> findByMedecinIdAndActifTrue(UUID medecinId);
    Mono<Boolean> existsByCarnetIdAndMedecinIdAndActifTrue(UUID carnetId, UUID medecinId);

    @Query("SELECT * FROM approbations_medecins WHERE carnet_id = :carnetId AND actif = TRUE AND est_medecin_personnel = TRUE")
    Flux<ApprobationMedecin> findMedecinsPersonnelsByCarnet(UUID carnetId);

    @Modifying
    @Query("""
        UPDATE approbations_medecins
        SET actif = FALSE, date_revocation = :now, motif_revocation = 'Expiration automatique'
        WHERE actif = TRUE AND date_expiration IS NOT NULL AND date_expiration < :now
        """)
    Mono<Integer> revokeExpiredApprobations(LocalDateTime now);

    @Modifying
    @Query("UPDATE approbations_medecins SET actif = FALSE, date_revocation = NOW() WHERE carnet_id = :carnetId AND actif = TRUE")
    Mono<Integer> revokeAllForCarnet(UUID carnetId);
}

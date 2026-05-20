package com.cscm.backend.repository;

import com.cscm.backend.entity.TokenAccesMedecin;
import com.cscm.backend.enums.StatutTokenAcces;
import org.springframework.data.r2dbc.repository.Modifying;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.UUID;

public interface TokenAccesMedecinRepository extends R2dbcRepository<TokenAccesMedecin, UUID> {

    Mono<TokenAccesMedecin> findByCodeCourtAndStatut(String codeCourt, StatutTokenAcces statut);
    Flux<TokenAccesMedecin> findByCarnetIdAndStatut(UUID carnetId, StatutTokenAcces statut);
    Flux<TokenAccesMedecin> findByPatientId(UUID patientId);

    @Query("SELECT * FROM tokens_acces_medecin WHERE code_court = :codeCourt AND statut = 'ACTIF' AND expires_at > NOW()")
    Mono<TokenAccesMedecin> findActiveByCodeCourt(String codeCourt);

    @Modifying
    @Query("UPDATE tokens_acces_medecin SET statut = 'EXPIRE' WHERE statut = 'ACTIF' AND expires_at < :now")
    Mono<Integer> expireTokens(LocalDateTime now);

    @Modifying
    @Query("UPDATE tokens_acces_medecin SET statut = 'REVOQUE' WHERE carnet_id = :carnetId AND statut = 'ACTIF'")
    Mono<Integer> revokeAllForCarnet(UUID carnetId);
}

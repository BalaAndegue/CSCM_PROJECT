package com.cscm.backend.repository;

import com.cscm.backend.entity.Ordonnance;
import com.cscm.backend.enums.OrdonnanceStatus;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface OrdonnanceRepository extends R2dbcRepository<Ordonnance, UUID> {

    Flux<Ordonnance> findByCarnetId(UUID carnetId);
    Flux<Ordonnance> findByMedecinId(UUID medecinId);
    Flux<Ordonnance> findByCarnetIdAndStatus(UUID carnetId, OrdonnanceStatus status);
    Mono<Ordonnance> findByNumeroOrdonnance(String numeroOrdonnance);
    Mono<Boolean> existsByNumeroOrdonnance(String numeroOrdonnance);

    @Query("SELECT * FROM ordonnances WHERE carnet_id = :carnetId ORDER BY date_prescription DESC LIMIT :size OFFSET :offset")
    Flux<Ordonnance> findByCarnetIdPaged(UUID carnetId, int size, long offset);
}

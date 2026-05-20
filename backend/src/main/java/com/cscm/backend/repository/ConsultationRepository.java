package com.cscm.backend.repository;

import com.cscm.backend.entity.Consultation;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.UUID;

public interface ConsultationRepository extends R2dbcRepository<Consultation, UUID> {

    Flux<Consultation> findByCarnetIdOrderByDateConsultationDesc(UUID carnetId);
    Mono<Long> countByMedecinId(UUID medecinId);
    Mono<Long> countByCarnetId(UUID carnetId);

    @Query("SELECT * FROM consultations WHERE carnet_id = :carnetId ORDER BY date_consultation DESC LIMIT :size OFFSET :offset")
    Flux<Consultation> findByCarnetIdPaged(UUID carnetId, int size, long offset);

    @Query("SELECT * FROM consultations WHERE medecin_id = :medecinId ORDER BY date_consultation DESC LIMIT :size OFFSET :offset")
    Flux<Consultation> findByMedecinIdPaged(UUID medecinId, int size, long offset);

    @Query("SELECT * FROM consultations WHERE medecin_id = :medecinId AND date_consultation BETWEEN :start AND :end ORDER BY date_consultation DESC")
    Flux<Consultation> findByMedecinIdAndDateBetween(UUID medecinId, LocalDateTime start, LocalDateTime end);
}

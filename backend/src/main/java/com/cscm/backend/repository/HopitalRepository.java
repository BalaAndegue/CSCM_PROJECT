package com.cscm.backend.repository;

import com.cscm.backend.entity.Hopital;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface HopitalRepository extends R2dbcRepository<Hopital, UUID> {

    Mono<Boolean> existsByNumeroAgrement(String numeroAgrement);
    Mono<Hopital> findByManagerId(UUID managerId);
    Mono<Hopital> findByMatricule(String matricule);

    @Query("SELECT * FROM hopitaux WHERE LOWER(nom) LIKE LOWER(CONCAT('%', :nom, '%')) AND status = 'ACTIF' LIMIT :size OFFSET :offset")
    Flux<Hopital> searchByNom(String nom, int size, long offset);

    @Query("SELECT * FROM hopitaux WHERE region = :region AND status = 'ACTIF' ORDER BY nom")
    Flux<Hopital> findByRegion(String region);

    @Query("SELECT * FROM hopitaux ORDER BY nom LIMIT :size OFFSET :offset")
    Flux<Hopital> findAllPaged(int size, long offset);

    @Query("SELECT nextval('seq_matricule_hopital')")
    Mono<Long> nextMatriculeSequence();
}

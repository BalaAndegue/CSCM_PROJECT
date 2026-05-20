package com.cscm.backend.repository;

import com.cscm.backend.entity.Allergie;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

import java.util.UUID;

public interface AllergieRepository extends R2dbcRepository<Allergie, UUID> {

    Flux<Allergie> findByCarnetId(UUID carnetId);
    Flux<Allergie> findByCarnetIdAndActiveTrue(UUID carnetId);
    Flux<Allergie> findByCarnetIdAndVisibleTousMedecinsTrue(UUID carnetId);
}

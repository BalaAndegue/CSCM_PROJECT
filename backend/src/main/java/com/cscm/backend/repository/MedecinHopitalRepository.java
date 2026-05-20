package com.cscm.backend.repository;

import com.cscm.backend.entity.MedecinHopital;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface MedecinHopitalRepository extends R2dbcRepository<MedecinHopital, UUID> {

    Flux<MedecinHopital> findByHopitalIdAndActifTrue(UUID hopitalId);
    Flux<MedecinHopital> findByMedecinIdAndActifTrue(UUID medecinId);
    Mono<MedecinHopital> findByMedecinIdAndHopitalId(UUID medecinId, UUID hopitalId);
    Mono<Boolean> existsByMedecinIdAndHopitalIdAndActifTrue(UUID medecinId, UUID hopitalId);
}

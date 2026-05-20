package com.cscm.backend.repository;

import com.cscm.backend.entity.MedecinPersonnel;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface MedecinPersonnelRepository extends R2dbcRepository<MedecinPersonnel, UUID> {

    Mono<MedecinPersonnel> findByPatientIdAndMedecinIdAndActifTrue(UUID patientId, UUID medecinId);
    Flux<MedecinPersonnel> findByPatientIdAndActifTrue(UUID patientId);
    Flux<MedecinPersonnel> findByMedecinIdAndActifTrue(UUID medecinId);
    Mono<MedecinPersonnel> findByCarnetIdAndMedecinIdAndActifTrue(UUID carnetId, UUID medecinId);
    Mono<Boolean> existsByPatientIdAndMedecinIdAndActifTrue(UUID patientId, UUID medecinId);
}

package com.cscm.backend.repository;

import com.cscm.backend.entity.Abonnement;
import com.cscm.backend.enums.AbonnementStatut;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface AbonnementRepository extends R2dbcRepository<Abonnement, UUID> {

    Mono<Abonnement> findByPatientIdAndStatut(UUID patientId, AbonnementStatut statut);
    Flux<Abonnement> findByPatientId(UUID patientId);
    Mono<Long> countByStatut(AbonnementStatut statut);
}

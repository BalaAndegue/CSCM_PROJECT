package com.cscm.backend.repository;

import com.cscm.backend.entity.CarnetMedical;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface CarnetMedicalRepository extends R2dbcRepository<CarnetMedical, UUID> {

    Mono<CarnetMedical> findByPatientId(UUID patientId);
    Mono<CarnetMedical> findByPatientIdAndStatut(UUID patientId, String statut);
    Mono<Boolean> existsByPatientId(UUID patientId);
}

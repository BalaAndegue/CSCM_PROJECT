package com.cscm.backend.repository;

import com.cscm.backend.entity.Patient;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface PatientRepository extends R2dbcRepository<Patient, UUID> {

    Mono<Patient> findByUserId(UUID userId);
    Mono<Patient> findByNumeroCarnet(String numeroCarnet);
    Mono<Patient> findByMatricule(String matricule);
    Mono<Patient> findByNumeroCNI(String numeroCNI);
    Mono<Boolean> existsByNumeroCarnet(String numeroCarnet);
    Mono<Boolean> existsByNumeroCNI(String numeroCNI);

    @Query("""
        SELECT p.* FROM patients p
        JOIN users u ON u.id = p.user_id
        WHERE LOWER(u.nom_complet) LIKE LOWER(CONCAT('%', :query, '%'))
           OR p.numero_carnet ILIKE CONCAT('%', :query, '%')
           OR p.numero_cni ILIKE CONCAT('%', :query, '%')
        ORDER BY p.created_at DESC LIMIT :size OFFSET :offset
        """)
    Flux<Patient> searchPatients(String query, int size, long offset);

    @Query("SELECT nextval('seq_matricule_patient')")
    Mono<Long> nextMatriculeSequence();
}

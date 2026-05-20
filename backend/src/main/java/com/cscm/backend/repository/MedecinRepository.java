package com.cscm.backend.repository;

import com.cscm.backend.entity.Medecin;
import com.cscm.backend.enums.MedecinStatus;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface MedecinRepository extends R2dbcRepository<Medecin, UUID> {

    Mono<Medecin> findByUserId(UUID userId);
    Mono<Medecin> findByNumeroOrdre(String numeroOrdre);
    Mono<Medecin> findByNumeroCNOM(String numeroCNOM);
    Mono<Medecin> findByMatricule(String matricule);
    Mono<Boolean> existsByNumeroOrdre(String numeroOrdre);
    Mono<Boolean> existsByNumeroCNOM(String numeroCNOM);
    Flux<Medecin> findByStatus(MedecinStatus status);
    Mono<Long> countByStatus(MedecinStatus status);

    @Query("SELECT * FROM medecins WHERE status = 'EN_ATTENTE' ORDER BY created_at ASC LIMIT :size OFFSET :offset")
    Flux<Medecin> findEnAttentePaged(int size, long offset);

    @Query("""
        SELECT m.* FROM medecins m
        JOIN medecin_hopital mh ON mh.medecin_id = m.id
        WHERE mh.hopital_id = :hopitalId AND mh.actif = TRUE AND m.status = 'VALIDE'
        """)
    Flux<Medecin> findByHopitalId(UUID hopitalId);

    @Query("SELECT * FROM medecins WHERE status = 'VALIDE' AND LOWER(specialite) LIKE LOWER(CONCAT('%', :specialite, '%')) LIMIT :size OFFSET :offset")
    Flux<Medecin> findBySpecialitePaged(String specialite, int size, long offset);

    @Query("SELECT nextval('seq_matricule_medecin')")
    Mono<Long> nextMatriculeSequence();
}

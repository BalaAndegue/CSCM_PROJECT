package com.cscm.backend.repository;

import com.cscm.backend.entity.Examen;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

import java.util.UUID;

public interface ExamenRepository extends R2dbcRepository<Examen, UUID> {

    Flux<Examen> findByCarnetId(UUID carnetId);
    Flux<Examen> findByMedecinPrescripteurId(UUID medecinId);

    @Query("SELECT * FROM examens WHERE carnet_id = :carnetId ORDER BY date_prescription DESC LIMIT :size OFFSET :offset")
    Flux<Examen> findByCarnetIdPaged(UUID carnetId, int size, long offset);

    @Query("SELECT * FROM examens WHERE carnet_id = :carnetId AND LOWER(type_examen) LIKE LOWER(CONCAT('%', :type, '%'))")
    Flux<Examen> findByCarnetIdAndTypeContaining(UUID carnetId, String type);
}

package com.cscm.backend.repository;

import com.cscm.backend.entity.ResultatExamen;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

import java.util.UUID;

public interface ResultatExamenRepository extends R2dbcRepository<ResultatExamen, UUID> {

    Flux<ResultatExamen> findByExamenId(UUID examenId);
}

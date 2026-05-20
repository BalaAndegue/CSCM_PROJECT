package com.cscm.backend.repository;

import com.cscm.backend.entity.ConsentDiagnosticHopital;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

import java.util.UUID;

public interface ConsentDiagnosticHopitalRepository extends R2dbcRepository<ConsentDiagnosticHopital, UUID> {

    Flux<ConsentDiagnosticHopital> findByHopitalId(UUID hopitalId);
    Flux<ConsentDiagnosticHopital> findByMedecinId(UUID medecinId);

    @Query("SELECT * FROM consents_diagnostic_hopital WHERE hopital_id = :hopitalId AND approuve_par_manager = :approved ORDER BY created_at DESC LIMIT :size OFFSET :offset")
    Flux<ConsentDiagnosticHopital> findByHopitalIdAndApprouveParManager(UUID hopitalId, Boolean approved, int size, long offset);
}

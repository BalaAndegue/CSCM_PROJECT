package com.cscm.backend.repository;

import com.cscm.backend.entity.ConsentDiagnosticHopital;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ConsentDiagnosticHopitalRepository extends JpaRepository<ConsentDiagnosticHopital, UUID> {
    Page<ConsentDiagnosticHopital> findByHopitalId(UUID hopitalId, Pageable pageable);
    Page<ConsentDiagnosticHopital> findByMedecinId(UUID medecinId, Pageable pageable);
    Page<ConsentDiagnosticHopital> findByHopitalIdAndApprouveParManager(UUID hopitalId, Boolean approved, Pageable pageable);
}

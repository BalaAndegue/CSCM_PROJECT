package com.cscm.backend.repository;

import com.cscm.backend.entity.Ordonnance;
import com.cscm.backend.enums.OrdonnanceStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface OrdonnanceRepository extends JpaRepository<Ordonnance, UUID> {
    Page<Ordonnance> findByCarnetId(UUID carnetId, Pageable pageable);
    Page<Ordonnance> findByMedecinId(UUID medecinId, Pageable pageable);
    List<Ordonnance> findByCarnetIdAndStatus(UUID carnetId, OrdonnanceStatus status);
    Optional<Ordonnance> findByNumeroOrdonnance(String numeroOrdonnance);
    boolean existsByNumeroOrdonnance(String numeroOrdonnance);
}

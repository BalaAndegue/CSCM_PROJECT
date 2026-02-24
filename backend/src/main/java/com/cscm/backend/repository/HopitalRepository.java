package com.cscm.backend.repository;

import com.cscm.backend.entity.Hopital;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface HopitalRepository extends JpaRepository<Hopital, UUID> {
    boolean existsByNumeroAgrement(String numeroAgrement);
    Optional<Hopital> findByManagerId(UUID managerId);
    Page<Hopital> findByNomContainingIgnoreCase(String nom, Pageable pageable);
}

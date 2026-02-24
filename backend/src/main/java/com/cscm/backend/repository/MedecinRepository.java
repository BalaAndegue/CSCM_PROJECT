package com.cscm.backend.repository;

import com.cscm.backend.entity.Medecin;
import com.cscm.backend.enums.MedecinStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface MedecinRepository extends JpaRepository<Medecin, UUID> {
    Optional<Medecin> findByUserId(UUID userId);
    boolean existsByNumeroOrdre(String numeroOrdre);
    Page<Medecin> findByStatus(MedecinStatus status, Pageable pageable);
    Page<Medecin> findBySpecialiteContainingIgnoreCase(String specialite, Pageable pageable);

    @Query("SELECT m FROM Medecin m JOIN MedecinHopital mh ON mh.medecin = m WHERE mh.hopital.id = :hopitalId AND mh.actif = true")
    List<Medecin> findByHopitalId(UUID hopitalId);

    long countByStatus(MedecinStatus status);
}

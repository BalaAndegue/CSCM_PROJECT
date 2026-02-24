package com.cscm.backend.repository;

import com.cscm.backend.entity.Patient;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface PatientRepository extends JpaRepository<Patient, UUID> {
    Optional<Patient> findByUserId(UUID userId);
    Optional<Patient> findByNumeroCarnet(String numeroCarnet);
    boolean existsByNumeroCarnet(String numeroCarnet);

    @Query("SELECT p FROM Patient p WHERE LOWER(p.user.nomComplet) LIKE LOWER(CONCAT('%', :query, '%')) OR p.numeroCarnet LIKE CONCAT('%', :query, '%')")
    Page<Patient> searchPatients(String query, Pageable pageable);
}

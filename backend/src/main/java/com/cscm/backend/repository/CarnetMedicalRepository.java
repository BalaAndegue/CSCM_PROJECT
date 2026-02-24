package com.cscm.backend.repository;

import com.cscm.backend.entity.CarnetMedical;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface CarnetMedicalRepository extends JpaRepository<CarnetMedical, UUID> {
    Optional<CarnetMedical> findByPatientId(UUID patientId);
    Optional<CarnetMedical> findByPatientIdAndStatut(UUID patientId, String statut);
    boolean existsByPatientId(UUID patientId);
}

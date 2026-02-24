package com.cscm.backend.repository;

import com.cscm.backend.entity.Abonnement;
import com.cscm.backend.enums.AbonnementStatut;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface AbonnementRepository extends JpaRepository<Abonnement, UUID> {
    Optional<Abonnement> findByPatientIdAndStatut(UUID patientId, AbonnementStatut statut);
    Page<Abonnement> findByPatientId(UUID patientId, Pageable pageable);
    long countByStatut(AbonnementStatut statut);
}

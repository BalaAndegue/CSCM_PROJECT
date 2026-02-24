package com.cscm.backend.repository;

import com.cscm.backend.entity.Consultation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Repository
public interface ConsultationRepository extends JpaRepository<Consultation, UUID> {
    Page<Consultation> findByCarnetId(UUID carnetId, Pageable pageable);
    Page<Consultation> findByMedecinId(UUID medecinId, Pageable pageable);
    List<Consultation> findByCarnetIdOrderByDateConsultationDesc(UUID carnetId);
    long countByMedecinId(UUID medecinId);
    long countByCarnetId(UUID carnetId);
    List<Consultation> findByMedecinIdAndDateConsultationBetween(UUID medecinId, LocalDateTime start, LocalDateTime end);
}

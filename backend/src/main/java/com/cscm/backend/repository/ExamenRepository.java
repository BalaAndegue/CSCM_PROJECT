package com.cscm.backend.repository;

import com.cscm.backend.entity.Examen;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ExamenRepository extends JpaRepository<Examen, UUID> {
    Page<Examen> findByCarnetId(UUID carnetId, Pageable pageable);
    Page<Examen> findByMedecinPrescripteurId(UUID medecinId, Pageable pageable);
    Page<Examen> findByCarnetIdAndTypeExamenContainingIgnoreCase(UUID carnetId, String typeExamen, Pageable pageable);
}

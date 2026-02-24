package com.cscm.backend.repository;

import com.cscm.backend.entity.ResultatExamen;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ResultatExamenRepository extends JpaRepository<ResultatExamen, UUID> {
    List<ResultatExamen> findByExamenId(UUID examenId);
}

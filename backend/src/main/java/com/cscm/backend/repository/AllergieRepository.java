package com.cscm.backend.repository;

import com.cscm.backend.entity.Allergie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface AllergieRepository extends JpaRepository<Allergie, UUID> {
    List<Allergie> findByCarnetIdAndActiveTrue(UUID carnetId);
    List<Allergie> findByCarnetId(UUID carnetId);
    List<Allergie> findByCarnetIdAndVisibleTousMedecinsTrue(UUID carnetId);
}

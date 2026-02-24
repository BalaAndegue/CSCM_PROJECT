package com.cscm.backend.repository;

import com.cscm.backend.entity.MedecinHopital;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface MedecinHopitalRepository extends JpaRepository<MedecinHopital, UUID> {
    List<MedecinHopital> findByHopitalIdAndActifTrue(UUID hopitalId);
    List<MedecinHopital> findByMedecinIdAndActifTrue(UUID medecinId);
    Optional<MedecinHopital> findByMedecinIdAndHopitalId(UUID medecinId, UUID hopitalId);
    boolean existsByMedecinIdAndHopitalIdAndActifTrue(UUID medecinId, UUID hopitalId);
}

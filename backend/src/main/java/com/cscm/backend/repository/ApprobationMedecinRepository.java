package com.cscm.backend.repository;

import com.cscm.backend.entity.ApprobationMedecin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ApprobationMedecinRepository extends JpaRepository<ApprobationMedecin, UUID> {
    List<ApprobationMedecin> findByCarnetIdAndActifTrue(UUID carnetId);
    Optional<ApprobationMedecin> findByCarnetIdAndMedecinId(UUID carnetId, UUID medecinId);
    List<ApprobationMedecin> findByMedecinIdAndActifTrue(UUID medecinId);
    boolean existsByCarnetIdAndMedecinIdAndActifTrue(UUID carnetId, UUID medecinId);

    @org.springframework.data.jpa.repository.Modifying
    @org.springframework.data.jpa.repository.Query("UPDATE ApprobationMedecin a SET a.actif = false, a.dateRevocation = :now, a.motifRevocation = 'Expiration automatique (24h)' WHERE a.actif = true AND a.dateExpiration < :now")
    int revokeExpiredApprobations(@org.springframework.data.repository.query.Param("now") java.time.LocalDateTime now);
}

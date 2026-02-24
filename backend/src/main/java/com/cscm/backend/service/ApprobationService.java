package com.cscm.backend.service;

import com.cscm.backend.entity.*;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ApprobationService {
    private final ApprobationMedecinRepository approbationRepository;
    private final CarnetMedicalRepository carnetMedicalRepository;
    private final MedecinRepository medecinRepository;

    public List<ApprobationMedecin> getMedecinsApprouves(UUID carnetId) {
        return approbationRepository.findByCarnetIdAndActifTrue(carnetId);
    }

    public List<ApprobationMedecin> getApprobationsParMedecin(UUID medecinId) {
        return approbationRepository.findByMedecinIdAndActifTrue(medecinId);
    }

    @Transactional
    public ApprobationMedecin approuverMedecin(UUID carnetId, UUID medecinId, String signaturePatient, Boolean isGarant, String signatureGarant) {
        CarnetMedical carnet = carnetMedicalRepository.findById(carnetId)
                .orElseThrow(() -> new ResourceNotFoundException("Carnet introuvable"));
        Medecin medecin = medecinRepository.findById(medecinId)
                .orElseThrow(() -> new ResourceNotFoundException("Médecin introuvable"));

        approbationRepository.findByCarnetIdAndMedecinId(carnetId, medecinId).ifPresent(a -> {
            if (a.getActif()) throw new BusinessException("Ce médecin est déjà approuvé pour ce carnet");
        });

        boolean byGarant = isGarant != null && isGarant;
        LocalDateTime now = LocalDateTime.now();

        ApprobationMedecin approbation = ApprobationMedecin.builder()
                .carnet(carnet)
                .medecin(medecin)
                .approuveParPatient(!byGarant)
                .dateSignaturePatient(!byGarant ? now : null)
                .signaturePatient(!byGarant ? (signaturePatient != null ? signaturePatient : "APPROVED") : null)
                .approuveParGarant(byGarant)
                .dateSignatureGarant(byGarant ? now : null)
                .signatureGarant(byGarant ? (signatureGarant != null ? signatureGarant : "APPROVED_BY_GARANT") : null)
                .actif(true)
                .dateExpiration(now.plusHours(24)) // L'accès expire automatiquement après 24 heures
                .build();
        return approbationRepository.save(approbation);
    }

    @Transactional
    public ApprobationMedecin revoquerApprobation(UUID id, String motif) {
        ApprobationMedecin approbation = approbationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Approbation introuvable"));
        approbation.setActif(false);
        approbation.setDateRevocation(LocalDateTime.now());
        approbation.setMotifRevocation(motif);
        return approbationRepository.save(approbation);
    }
}

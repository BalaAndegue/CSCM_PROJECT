package com.cscm.backend.service;

import com.cscm.backend.entity.*;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ConsultationService {

    private final ConsultationRepository consultationRepository;
    private final CarnetMedicalRepository carnetMedicalRepository;
    private final MedecinRepository medecinRepository;
    private final HopitalRepository hopitalRepository;

    public Page<Consultation> getConsultationsByCarnet(UUID carnetId, Pageable pageable) {
        return consultationRepository.findByCarnetId(carnetId, pageable);
    }

    public Page<Consultation> getConsultationsByMedecin(UUID medecinId, Pageable pageable) {
        return consultationRepository.findByMedecinId(medecinId, pageable);
    }

    public Consultation getConsultationById(UUID id) {
        return consultationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Consultation introuvable: " + id));
    }

    public List<Consultation> getDernieresConsultations(UUID carnetId) {
        return consultationRepository.findByCarnetIdOrderByDateConsultationDesc(carnetId);
    }

    @Transactional
    public Consultation createConsultation(UUID carnetId, UUID medecinId, UUID hopitalId,
                                            Consultation data) {
        CarnetMedical carnet = carnetMedicalRepository.findById(carnetId)
                .orElseThrow(() -> new ResourceNotFoundException("Carnet introuvable"));
        Medecin medecin = medecinRepository.findById(medecinId)
                .orElseThrow(() -> new ResourceNotFoundException("Médecin introuvable"));

        data.setCarnet(carnet);
        data.setMedecin(medecin);

        if (hopitalId != null) {
            Hopital hopital = hopitalRepository.findById(hopitalId)
                    .orElseThrow(() -> new ResourceNotFoundException("Hôpital introuvable"));
            data.setHopital(hopital);
        }
        if (data.getDateConsultation() == null) {
            data.setDateConsultation(LocalDateTime.now());
        }
        return consultationRepository.save(data);
    }

    @Transactional
    public Consultation updateConsultation(UUID id, Consultation updates) {
        Consultation consultation = getConsultationById(id);
        if (updates.getMotif() != null) consultation.setMotif(updates.getMotif());
        if (updates.getSymptomes() != null) consultation.setSymptomes(updates.getSymptomes());
        if (updates.getDiagnostic() != null) consultation.setDiagnostic(updates.getDiagnostic());
        if (updates.getTraitementRecommande() != null) consultation.setTraitementRecommande(updates.getTraitementRecommande());
        if (updates.getSuiviRecommande() != null) consultation.setSuiviRecommande(updates.getSuiviRecommande());
        if (updates.getGravite() != null) consultation.setGravite(updates.getGravite());
        if (updates.getNotesComplementaires() != null) consultation.setNotesComplementaires(updates.getNotesComplementaires());
        if (updates.getPoids() != null) consultation.setPoids(updates.getPoids());
        if (updates.getTaille() != null) consultation.setTaille(updates.getTaille());
        if (updates.getTemperature() != null) consultation.setTemperature(updates.getTemperature());
        if (updates.getFrequenceCardiaque() != null) consultation.setFrequenceCardiaque(updates.getFrequenceCardiaque());
        if (updates.getPressionArterielle() != null) consultation.setPressionArterielle(updates.getPressionArterielle());
        if (updates.getProchaineConsultation() != null) consultation.setProchaineConsultation(updates.getProchaineConsultation());
        return consultationRepository.save(consultation);
    }

    @Transactional
    public void deleteConsultation(UUID id) {
        if (!consultationRepository.existsById(id)) {
            throw new ResourceNotFoundException("Consultation introuvable: " + id);
        }
        consultationRepository.deleteById(id);
    }
}

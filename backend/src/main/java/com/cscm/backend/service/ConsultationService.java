package com.cscm.backend.service;

import com.cscm.backend.entity.Consultation;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.ApprobationMedecinRepository;
import com.cscm.backend.repository.ConsultationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ConsultationService {

    private final ConsultationRepository consultationRepository;
    private final ApprobationMedecinRepository approbationRepository;

    public Flux<Consultation> getConsultationsByCarnet(UUID carnetId, int size, long offset) {
        return consultationRepository.findByCarnetIdPaged(carnetId, size, offset);
    }

    public Flux<Consultation> getConsultationsByMedecin(UUID medecinId, int size, long offset) {
        return consultationRepository.findByMedecinIdPaged(medecinId, size, offset);
    }

    public Flux<Consultation> getDernieresConsultations(UUID carnetId) {
        return consultationRepository.findByCarnetIdOrderByDateConsultationDesc(carnetId);
    }

    public Mono<Consultation> getConsultationById(UUID id) {
        return consultationRepository.findById(id)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Consultation introuvable: " + id)));
    }

    public Mono<Consultation> createConsultation(UUID carnetId, UUID medecinId, UUID hopitalId, Consultation data) {
        return approbationRepository.existsByCarnetIdAndMedecinIdAndActifTrue(carnetId, medecinId)
                .flatMap(approved -> {
                    if (!approved) {
                        return Mono.error(new BusinessException(
                                "Accès refusé : le patient n'a pas autorisé ce médecin à éditer son carnet"));
                    }
                    data.setId(UUID.randomUUID());
                    data.setCarnetId(carnetId);
                    data.setMedecinId(medecinId);
                    data.setHopitalId(hopitalId);
                    if (data.getDateConsultation() == null) {
                        data.setDateConsultation(LocalDateTime.now());
                    }
                    return consultationRepository.save(data);
                });
    }

    public Mono<Consultation> updateConsultation(UUID id, Consultation updates) {
        return getConsultationById(id)
                .flatMap(consultation -> {
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
                });
    }

    public Mono<Void> deleteConsultation(UUID id) {
        return consultationRepository.existsById(id)
                .flatMap(exists -> exists
                        ? consultationRepository.deleteById(id)
                        : Mono.error(new ResourceNotFoundException("Consultation introuvable: " + id)));
    }
}

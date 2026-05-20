package com.cscm.backend.service;

import com.cscm.backend.entity.CarnetMedical;
import com.cscm.backend.exception.AccessDeniedException;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.ApprobationMedecinRepository;
import com.cscm.backend.repository.CarnetMedicalRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CarnetService {

    private final CarnetMedicalRepository carnetMedicalRepository;
    private final ApprobationMedecinRepository approbationMedecinRepository;

    public Mono<CarnetMedical> getCarnetByPatientId(UUID patientId) {
        return carnetMedicalRepository.findByPatientId(patientId)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Carnet médical introuvable")));
    }

    public Mono<CarnetMedical> getCarnetById(UUID id) {
        return carnetMedicalRepository.findById(id)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Carnet introuvable: " + id)));
    }

    public Mono<CarnetMedical> getCarnetByIdWithMedecinAccess(UUID carnetId, UUID medecinId) {
        return getCarnetById(carnetId)
                .flatMap(carnet ->
                        approbationMedecinRepository.existsByCarnetIdAndMedecinIdAndActifTrue(carnetId, medecinId)
                                .flatMap(approved -> approved
                                        ? Mono.just(carnet)
                                        : Mono.error(new AccessDeniedException("Vous n'avez pas les droits pour accéder à ce carnet")))
                );
    }

    public Mono<CarnetMedical> archiverCarnet(UUID id) {
        return getCarnetById(id)
                .flatMap(carnet -> {
                    carnet.setStatut("archive");
                    return carnetMedicalRepository.save(carnet);
                });
    }

    public Mono<CarnetMedical> updateNotes(UUID id, String notes) {
        return getCarnetById(id)
                .flatMap(carnet -> {
                    carnet.setNotesGenerales(notes);
                    return carnetMedicalRepository.save(carnet);
                });
    }
}

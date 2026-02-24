package com.cscm.backend.service;

import com.cscm.backend.entity.CarnetMedical;
import com.cscm.backend.exception.AccessDeniedException;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.ApprobationMedecinRepository;
import com.cscm.backend.repository.CarnetMedicalRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CarnetService {

    private final CarnetMedicalRepository carnetMedicalRepository;
    private final ApprobationMedecinRepository approbationMedecinRepository;

    public CarnetMedical getCarnetByPatientId(UUID patientId) {
        return carnetMedicalRepository.findByPatientId(patientId)
                .orElseThrow(() -> new ResourceNotFoundException("Carnet médical introuvable"));
    }

    public CarnetMedical getCarnetById(UUID id) {
        return carnetMedicalRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Carnet introuvable: " + id));
    }

    public CarnetMedical getCarnetByIdWithMedecinAccess(UUID carnetId, UUID medecinId) {
        CarnetMedical carnet = getCarnetById(carnetId);
        boolean approved = approbationMedecinRepository
                .existsByCarnetIdAndMedecinIdAndActifTrue(carnetId, medecinId);
        if (!approved) {
            throw new AccessDeniedException("Vous n'avez pas les droits pour accéder à ce carnet");
        }
        return carnet;
    }

    @Transactional
    public CarnetMedical archiverCarnet(UUID id) {
        CarnetMedical carnet = getCarnetById(id);
        carnet.setStatut("archive");
        return carnetMedicalRepository.save(carnet);
    }

    @Transactional
    public CarnetMedical updateNotes(UUID id, String notes) {
        CarnetMedical carnet = getCarnetById(id);
        carnet.setNotesGenerales(notes);
        return carnetMedicalRepository.save(carnet);
    }
}

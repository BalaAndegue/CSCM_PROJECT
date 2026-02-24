package com.cscm.backend.service;

import com.cscm.backend.entity.Patient;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.PatientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PatientService {

    private final PatientRepository patientRepository;

    public Page<Patient> getAllPatients(Pageable pageable) {
        return patientRepository.findAll(pageable);
    }

    public Page<Patient> searchPatients(String query, Pageable pageable) {
        return patientRepository.searchPatients(query, pageable);
    }

    public Patient getPatientById(UUID id) {
        return patientRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Patient introuvable: " + id));
    }

    public Patient getPatientByUserId(UUID userId) {
        return patientRepository.findByUserId(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Profil patient introuvable"));
    }

    public Patient getPatientByNumeroCarnet(String numeroCarnet) {
        return patientRepository.findByNumeroCarnet(numeroCarnet)
                .orElseThrow(() -> new ResourceNotFoundException("Carnet introuvable: " + numeroCarnet));
    }

    @Transactional
    public Patient updatePatient(UUID id, Patient updates) {
        Patient patient = getPatientById(id);
        if (updates.getAdresse() != null) patient.setAdresse(updates.getAdresse());
        if (updates.getTelephone() != null) patient.setTelephone(updates.getTelephone());
        if (updates.getSituationFamiliale() != null) patient.setSituationFamiliale(updates.getSituationFamiliale());
        if (updates.getProfession() != null) patient.setProfession(updates.getProfession());
        if (updates.getGroupeSanguin() != null) patient.setGroupeSanguin(updates.getGroupeSanguin());
        if (updates.getAntecedentsChirurgicaux() != null) patient.setAntecedentsChirurgicaux(updates.getAntecedentsChirurgicaux());
        if (updates.getAntecedentsFamiliaux() != null) patient.setAntecedentsFamiliaux(updates.getAntecedentsFamiliaux());
        if (updates.getAntecedentsMedicaux() != null) patient.setAntecedentsMedicaux(updates.getAntecedentsMedicaux());
        if (updates.getContactUrgenceNom() != null) patient.setContactUrgenceNom(updates.getContactUrgenceNom());
        if (updates.getContactUrgenceTelephone() != null) patient.setContactUrgenceTelephone(updates.getContactUrgenceTelephone());
        if (updates.getMedecinTraitantId() != null) patient.setMedecinTraitantId(updates.getMedecinTraitantId());
        return patientRepository.save(patient);
    }
}

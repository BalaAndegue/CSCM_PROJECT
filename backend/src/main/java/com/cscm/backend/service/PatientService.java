package com.cscm.backend.service;

import com.cscm.backend.entity.Patient;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.repository.PatientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PatientService {

    private final PatientRepository patientRepository;

    public Flux<Patient> searchPatients(String query, int size, long offset) {
        return patientRepository.searchPatients(query, size, offset);
    }

    public Mono<Patient> getPatientById(UUID id) {
        return patientRepository.findById(id)
                .switchIfEmpty(Mono.error(new BusinessException("Patient introuvable: " + id)));
    }

    public Mono<Patient> getPatientByUserId(UUID userId) {
        return patientRepository.findByUserId(userId)
                .switchIfEmpty(Mono.error(new BusinessException("Profil patient introuvable")));
    }

    public Mono<Patient> getPatientByNumeroCNI(String numeroCNI) {
        return patientRepository.findByNumeroCNI(numeroCNI)
                .switchIfEmpty(Mono.error(new BusinessException("Aucun patient avec ce numéro CNI")));
    }

    public Mono<Patient> updatePatient(UUID patientId, UUID requestingUserId, Patient updates) {
        return patientRepository.findById(patientId)
                .switchIfEmpty(Mono.error(new BusinessException("Patient introuvable")))
                .flatMap(patient -> {
                    if (!patient.getUserId().equals(requestingUserId)) {
                        return Mono.error(new BusinessException("Accès non autorisé"));
                    }
                    if (updates.getAdresse() != null) patient.setAdresse(updates.getAdresse());
                    if (updates.getTelephone() != null) patient.setTelephone(updates.getTelephone());
                    if (updates.getSituationFamiliale() != null) patient.setSituationFamiliale(updates.getSituationFamiliale());
                    if (updates.getProfession() != null) patient.setProfession(updates.getProfession());
                    if (updates.getGroupeSanguin() != null) patient.setGroupeSanguin(updates.getGroupeSanguin());
                    if (updates.getVille() != null) patient.setVille(updates.getVille());
                    if (updates.getRegionResidence() != null) patient.setRegionResidence(updates.getRegionResidence());
                    if (updates.getAntecedentsChirurgicaux() != null) patient.setAntecedentsChirurgicaux(updates.getAntecedentsChirurgicaux());
                    if (updates.getAntecedentsFamiliaux() != null) patient.setAntecedentsFamiliaux(updates.getAntecedentsFamiliaux());
                    if (updates.getAntecedentsMedicaux() != null) patient.setAntecedentsMedicaux(updates.getAntecedentsMedicaux());
                    if (updates.getContactUrgenceNom() != null) patient.setContactUrgenceNom(updates.getContactUrgenceNom());
                    if (updates.getContactUrgenceTelephone() != null) patient.setContactUrgenceTelephone(updates.getContactUrgenceTelephone());
                    return patientRepository.save(patient);
                });
    }

    public Mono<Patient> updateGarant(UUID patientId, UUID requestingUserId,
                                       String garantNomComplet, String garantTelephone,
                                       com.cscm.backend.enums.LienParente garantLienParente,
                                       String garantNumeroCNI, String garantEmail) {
        return patientRepository.findById(patientId)
                .switchIfEmpty(Mono.error(new BusinessException("Patient introuvable")))
                .flatMap(patient -> {
                    if (!patient.getUserId().equals(requestingUserId)) {
                        return Mono.error(new BusinessException("Accès non autorisé"));
                    }
                    if (garantNomComplet != null) patient.setGarantNomComplet(garantNomComplet);
                    if (garantTelephone != null) patient.setGarantTelephone(garantTelephone);
                    if (garantLienParente != null) patient.setGarantLienParente(garantLienParente);
                    if (garantNumeroCNI != null) patient.setGarantNumeroCNI(garantNumeroCNI);
                    if (garantEmail != null) patient.setGarantEmail(garantEmail);
                    return patientRepository.save(patient);
                });
    }

    public Mono<Patient> activerAccesGarant(UUID patientId, boolean activer) {
        return patientRepository.findById(patientId)
                .switchIfEmpty(Mono.error(new BusinessException("Patient introuvable")))
                .flatMap(patient -> {
                    patient.setGarantAccesActif(activer);
                    return patientRepository.save(patient);
                });
    }
}

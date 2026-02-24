package com.cscm.backend.service;

import com.cscm.backend.entity.Medecin;
import com.cscm.backend.entity.Patient;
import com.cscm.backend.entity.User;
import com.cscm.backend.enums.MedecinStatus;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.MedecinRepository;
import com.cscm.backend.repository.UserRepository;
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
public class MedecinService {

    private final MedecinRepository medecinRepository;
    private final UserRepository userRepository;

    public Page<Medecin> getAllMedecins(Pageable pageable) {
        return medecinRepository.findAll(pageable);
    }

    public Page<Medecin> getMedecinsByStatus(MedecinStatus status, Pageable pageable) {
        return medecinRepository.findByStatus(status, pageable);
    }

    public Medecin getMedecinById(UUID id) {
        return medecinRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Médecin introuvable: " + id));
    }

    public Medecin getMedecinByUserId(UUID userId) {
        return medecinRepository.findByUserId(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Profil médecin introuvable"));
    }

    @Transactional
    public Medecin updateMedecin(UUID id, String specialite, String sousSpecialite,
                                  String biographie, Integer anneesExperience,
                                  Double consultationFee, List<String> diplomes) {
        Medecin medecin = getMedecinById(id);
        if (specialite != null) medecin.setSpecialite(specialite);
        if (sousSpecialite != null) medecin.setSousSpecialite(sousSpecialite);
        if (biographie != null) medecin.setBiographie(biographie);
        if (anneesExperience != null) medecin.setAnneesExperience(anneesExperience);
        if (consultationFee != null) medecin.setConsultationFee(consultationFee);
        if (diplomes != null) medecin.setDiplomes(diplomes);
        return medecinRepository.save(medecin);
    }

    @Transactional
    public Medecin validerMedecin(UUID id, UUID adminId) {
        Medecin medecin = getMedecinById(id);
        if (medecin.getStatus() != MedecinStatus.EN_ATTENTE) {
            throw new BusinessException("Ce médecin n'est pas en attente de validation");
        }
        medecin.setStatus(MedecinStatus.VALIDE);
        medecin.setValidePar(adminId);
        medecin.setDateValidation(LocalDateTime.now());
        medecin.setRaisonRejet(null);
        return medecinRepository.save(medecin);
    }

    @Transactional
    public Medecin rejeterMedecin(UUID id, UUID adminId, String raison) {
        Medecin medecin = getMedecinById(id);
        medecin.setStatus(MedecinStatus.REJETE);
        medecin.setValidePar(adminId);
        medecin.setDateValidation(LocalDateTime.now());
        medecin.setRaisonRejet(raison);
        return medecinRepository.save(medecin);
    }

    @Transactional
    public Medecin suspendMedecin(UUID id) {
        Medecin medecin = getMedecinById(id);
        medecin.setStatus(MedecinStatus.SUSPENDU);
        return medecinRepository.save(medecin);
    }

    public List<Medecin> getMedecinsParHopital(UUID hopitalId) {
        return medecinRepository.findByHopitalId(hopitalId);
    }

    public Page<Medecin> searchBySpecialite(String specialite, Pageable pageable) {
        return medecinRepository.findBySpecialiteContainingIgnoreCase(specialite, pageable);
    }
}

package com.cscm.backend.service;

import com.cscm.backend.entity.*;
import com.cscm.backend.exception.BusinessException;
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
public class HopitalService {
    private final HopitalRepository hopitalRepository;
    private final MedecinRepository medecinRepository;
    private final MedecinHopitalRepository medecinHopitalRepository;

    public Page<Hopital> getAll(Pageable pageable) {
        return hopitalRepository.findAll(pageable);
    }

    public Hopital getById(UUID id) {
        return hopitalRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Hôpital introuvable: " + id));
    }

    @Transactional
    public Hopital create(Hopital data) {
        if (hopitalRepository.existsByNumeroAgrement(data.getNumeroAgrement())) {
            throw new BusinessException("Un hôpital avec ce numéro d'agrément existe déjà");
        }
        return hopitalRepository.save(data);
    }

    @Transactional
    public Hopital update(UUID id, Hopital updates) {
        Hopital hopital = getById(id);
        if (updates.getNom() != null) hopital.setNom(updates.getNom());
        if (updates.getAdresse() != null) hopital.setAdresse(updates.getAdresse());
        if (updates.getTelephone() != null) hopital.setTelephone(updates.getTelephone());
        if (updates.getEmail() != null) hopital.setEmail(updates.getEmail());
        if (updates.getDescription() != null) hopital.setDescription(updates.getDescription());
        return hopitalRepository.save(hopital);
    }

    @Transactional
    public void delete(UUID id) {
        if (!hopitalRepository.existsById(id))
            throw new ResourceNotFoundException("Hôpital introuvable: " + id);
        hopitalRepository.deleteById(id);
    }

    @Transactional
    public MedecinHopital rattacherMedecin(UUID hopitalId, UUID medecinId, String service) {
        Hopital hopital = getById(hopitalId);
        Medecin medecin = medecinRepository.findById(medecinId)
                .orElseThrow(() -> new ResourceNotFoundException("Médecin introuvable"));
        if (medecinHopitalRepository.existsByMedecinIdAndHopitalIdAndActifTrue(medecinId, hopitalId)) {
            throw new BusinessException("Ce médecin est déjà rattaché à cet hôpital");
        }
        MedecinHopital mh = MedecinHopital.builder()
                .medecin(medecin).hopital(hopital).service(service).actif(true).build();
        return medecinHopitalRepository.save(mh);
    }

    @Transactional
    public void detacherMedecin(UUID hopitalId, UUID medecinId) {
        MedecinHopital mh = medecinHopitalRepository.findByMedecinIdAndHopitalId(medecinId, hopitalId)
                .orElseThrow(() -> new ResourceNotFoundException("Association introuvable"));
        mh.setActif(false);
        medecinHopitalRepository.save(mh);
    }

    public List<Medecin> getMedecinsHopital(UUID hopitalId) {
        return medecinRepository.findByHopitalId(hopitalId);
    }
}

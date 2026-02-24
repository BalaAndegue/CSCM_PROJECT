package com.cscm.backend.service;

import com.cscm.backend.entity.*;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AllergieService {
    private final AllergieRepository allergieRepository;
    private final CarnetMedicalRepository carnetMedicalRepository;
    private final MedecinRepository medecinRepository;

    public List<Allergie> getByCarnet(UUID carnetId) {
        return allergieRepository.findByCarnetId(carnetId);
    }

    public List<Allergie> getActivesByCarnet(UUID carnetId) {
        return allergieRepository.findByCarnetIdAndActiveTrue(carnetId);
    }

    public Allergie getById(UUID id) {
        return allergieRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Allergie introuvable: " + id));
    }

    @Transactional
    public Allergie create(UUID carnetId, Allergie data, UUID medecinId) {
        CarnetMedical carnet = carnetMedicalRepository.findById(carnetId)
                .orElseThrow(() -> new ResourceNotFoundException("Carnet introuvable"));
        data.setCarnet(carnet);
        if (medecinId != null) {
            medecinRepository.findById(medecinId).ifPresent(data::setMedecinNotificateur);
        }
        return allergieRepository.save(data);
    }

    @Transactional
    public Allergie update(UUID id, Allergie updates) {
        Allergie allergie = getById(id);
        if (updates.getNomAllergene() != null) allergie.setNomAllergene(updates.getNomAllergene());
        if (updates.getGravite() != null) allergie.setGravite(updates.getGravite());
        if (updates.getTypeReaction() != null) allergie.setTypeReaction(updates.getTypeReaction());
        if (updates.getDescription() != null) allergie.setDescription(updates.getDescription());
        if (updates.getTraitementUrgence() != null) allergie.setTraitementUrgence(updates.getTraitementUrgence());
        if (updates.getActive() != null) allergie.setActive(updates.getActive());
        if (updates.getVisibleTousMedecins() != null) allergie.setVisibleTousMedecins(updates.getVisibleTousMedecins());
        return allergieRepository.save(allergie);
    }

    @Transactional
    public void delete(UUID id) {
        if (!allergieRepository.existsById(id))
            throw new ResourceNotFoundException("Allergie introuvable: " + id);
        allergieRepository.deleteById(id);
    }
}

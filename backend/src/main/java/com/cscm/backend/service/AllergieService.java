package com.cscm.backend.service;

import com.cscm.backend.entity.Allergie;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.AllergieRepository;
import com.cscm.backend.repository.ApprobationMedecinRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AllergieService {

    private final AllergieRepository allergieRepository;
    private final ApprobationMedecinRepository approbationRepository;

    public Flux<Allergie> getByCarnet(UUID carnetId) {
        return allergieRepository.findByCarnetId(carnetId);
    }

    public Flux<Allergie> getActivesByCarnet(UUID carnetId) {
        return allergieRepository.findByCarnetIdAndActiveTrue(carnetId);
    }

    public Mono<Allergie> getById(UUID id) {
        return allergieRepository.findById(id)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Allergie introuvable: " + id)));
    }

    public Mono<Allergie> create(UUID carnetId, Allergie data, UUID medecinId) {
        Mono<Void> authorisationCheck = medecinId == null ? Mono.empty() :
                approbationRepository.existsByCarnetIdAndMedecinIdAndActifTrue(carnetId, medecinId)
                        .flatMap(approved -> approved ? Mono.empty() :
                                Mono.error(new BusinessException(
                                        "Accès refusé : le patient n'a pas autorisé ce médecin à éditer son carnet")));

        return authorisationCheck
                .then(Mono.fromCallable(() -> {
                    data.setId(UUID.randomUUID());
                    data.setCarnetId(carnetId);
                    data.setMedecinNotificateurId(medecinId);
                    return data;
                }))
                .flatMap(allergieRepository::save);
    }

    public Mono<Allergie> update(UUID id, Allergie updates) {
        return getById(id)
                .flatMap(allergie -> {
                    if (updates.getNomAllergene() != null) allergie.setNomAllergene(updates.getNomAllergene());
                    if (updates.getGravite() != null) allergie.setGravite(updates.getGravite());
                    if (updates.getTypeReaction() != null) allergie.setTypeReaction(updates.getTypeReaction());
                    if (updates.getDescription() != null) allergie.setDescription(updates.getDescription());
                    if (updates.getTraitementUrgence() != null) allergie.setTraitementUrgence(updates.getTraitementUrgence());
                    if (updates.getActive() != null) allergie.setActive(updates.getActive());
                    if (updates.getVisibleTousMedecins() != null) allergie.setVisibleTousMedecins(updates.getVisibleTousMedecins());
                    return allergieRepository.save(allergie);
                });
    }

    public Mono<Void> delete(UUID id) {
        return allergieRepository.existsById(id)
                .flatMap(exists -> exists
                        ? allergieRepository.deleteById(id)
                        : Mono.error(new ResourceNotFoundException("Allergie introuvable: " + id)));
    }
}

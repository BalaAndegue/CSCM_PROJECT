package com.cscm.backend.service;

import com.cscm.backend.entity.Hopital;
import com.cscm.backend.entity.MedecinHopital;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.HopitalRepository;
import com.cscm.backend.repository.MedecinHopitalRepository;
import com.cscm.backend.repository.MedecinRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class HopitalService {

    private final HopitalRepository hopitalRepository;
    private final MedecinRepository medecinRepository;
    private final MedecinHopitalRepository medecinHopitalRepository;
    private final MatriculeService matriculeService;

    public Flux<Hopital> getAll(int size, long offset) {
        return hopitalRepository.findAllPaged(size, offset);
    }

    public Flux<Hopital> searchByNom(String nom, int size, long offset) {
        return hopitalRepository.searchByNom(nom, size, offset);
    }

    public Mono<Hopital> getById(UUID id) {
        return hopitalRepository.findById(id)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Hôpital introuvable: " + id)));
    }

    public Mono<Hopital> create(Hopital data) {
        return hopitalRepository.existsByNumeroAgrement(data.getNumeroAgrement())
                .flatMap(exists -> {
                    if (exists) return Mono.error(new BusinessException("Un hôpital avec ce numéro d'agrément existe déjà"));
                    return matriculeService.genererMatriculeHopital();
                })
                .flatMap(matricule -> {
                    data.setId(UUID.randomUUID());
                    data.setMatricule(matricule);
                    return hopitalRepository.save(data);
                });
    }

    public Mono<Hopital> update(UUID id, Hopital updates) {
        return getById(id)
                .flatMap(hopital -> {
                    if (updates.getNom() != null) hopital.setNom(updates.getNom());
                    if (updates.getAdresse() != null) hopital.setAdresse(updates.getAdresse());
                    if (updates.getTelephone() != null) hopital.setTelephone(updates.getTelephone());
                    if (updates.getEmail() != null) hopital.setEmail(updates.getEmail());
                    if (updates.getDescription() != null) hopital.setDescription(updates.getDescription());
                    return hopitalRepository.save(hopital);
                });
    }

    public Mono<Void> delete(UUID id) {
        return hopitalRepository.existsById(id)
                .flatMap(exists -> exists
                        ? hopitalRepository.deleteById(id)
                        : Mono.error(new ResourceNotFoundException("Hôpital introuvable: " + id)));
    }

    public Mono<MedecinHopital> rattacherMedecin(UUID hopitalId, UUID medecinId, String service) {
        return medecinHopitalRepository.existsByMedecinIdAndHopitalIdAndActifTrue(medecinId, hopitalId)
                .flatMap(exists -> {
                    if (exists) return Mono.error(new BusinessException("Ce médecin est déjà rattaché à cet hôpital"));
                    return medecinRepository.findById(medecinId)
                            .switchIfEmpty(Mono.error(new ResourceNotFoundException("Médecin introuvable")));
                })
                .flatMap(medecin -> {
                    MedecinHopital mh = MedecinHopital.builder()
                            .id(UUID.randomUUID())
                            .medecinId(medecinId)
                            .hopitalId(hopitalId)
                            .service(service)
                            .actif(true)
                            .dateDebut(LocalDateTime.now())
                            .build();
                    return medecinHopitalRepository.save(mh);
                });
    }

    public Mono<Void> detacherMedecin(UUID hopitalId, UUID medecinId) {
        return medecinHopitalRepository.findByMedecinIdAndHopitalId(medecinId, hopitalId)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Association introuvable")))
                .flatMap(mh -> {
                    mh.setActif(false);
                    return medecinHopitalRepository.save(mh);
                })
                .then();
    }

    public Flux<MedecinHopital> getMedecinsHopital(UUID hopitalId) {
        return medecinHopitalRepository.findByHopitalIdAndActifTrue(hopitalId);
    }
}

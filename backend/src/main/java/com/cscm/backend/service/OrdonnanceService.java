package com.cscm.backend.service;

import com.cscm.backend.entity.Ordonnance;
import com.cscm.backend.enums.OrdonnanceStatus;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.ApprobationMedecinRepository;
import com.cscm.backend.repository.OrdonnanceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class OrdonnanceService {

    private final OrdonnanceRepository ordonnanceRepository;
    private final ApprobationMedecinRepository approbationRepository;

    public Flux<Ordonnance> getByCarnet(UUID carnetId, int size, long offset) {
        return ordonnanceRepository.findByCarnetIdPaged(carnetId, size, offset);
    }

    public Flux<Ordonnance> getByMedecin(UUID medecinId) {
        return ordonnanceRepository.findByMedecinId(medecinId);
    }

    public Mono<Ordonnance> getById(UUID id) {
        return ordonnanceRepository.findById(id)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Ordonnance introuvable: " + id)));
    }

    public Mono<Ordonnance> create(UUID carnetId, UUID medecinId, UUID hopitalId, Ordonnance data) {
        return approbationRepository.existsByCarnetIdAndMedecinIdAndActifTrue(carnetId, medecinId)
                .flatMap(approved -> {
                    if (!approved) {
                        return Mono.error(new BusinessException(
                                "Accès refusé : le patient n'a pas autorisé ce médecin à éditer son carnet"));
                    }
                    return genererNumeroOrdonnance();
                })
                .flatMap(numero -> {
                    data.setId(UUID.randomUUID());
                    data.setCarnetId(carnetId);
                    data.setMedecinId(medecinId);
                    data.setHopitalId(hopitalId);
                    data.setNumeroOrdonnance(numero);
                    if (data.getDatePrescription() == null) {
                        data.setDatePrescription(LocalDateTime.now());
                    }
                    return ordonnanceRepository.save(data);
                });
    }

    public Mono<Ordonnance> update(UUID id, Ordonnance updates) {
        return getById(id)
                .flatMap(ord -> {
                    if (ord.getStatus() != OrdonnanceStatus.ACTIVE) {
                        return Mono.error(new BusinessException("Cette ordonnance n'est plus modifiable"));
                    }
                    if (updates.getMedicamentsJson() != null) ord.setMedicamentsJson(updates.getMedicamentsJson());
                    if (updates.getInstructions() != null) ord.setInstructions(updates.getInstructions());
                    if (updates.getPosologieDetaillee() != null) ord.setPosologieDetaillee(updates.getPosologieDetaillee());
                    if (updates.getRenouvelable() != null) ord.setRenouvelable(updates.getRenouvelable());
                    if (updates.getDateExpiration() != null) ord.setDateExpiration(updates.getDateExpiration());
                    return ordonnanceRepository.save(ord);
                });
    }

    public Mono<Ordonnance> annuler(UUID id) {
        return getById(id)
                .flatMap(ord -> {
                    ord.setStatus(OrdonnanceStatus.ANNULEE);
                    return ordonnanceRepository.save(ord);
                });
    }

    private Mono<String> genererNumeroOrdonnance() {
        String candidate = "ORD-" + System.currentTimeMillis();
        return ordonnanceRepository.existsByNumeroOrdonnance(candidate)
                .flatMap(exists -> exists
                        ? genererNumeroOrdonnance()
                        : Mono.just(candidate));
    }
}

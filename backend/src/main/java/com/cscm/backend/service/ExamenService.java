package com.cscm.backend.service;

import com.cscm.backend.entity.Examen;
import com.cscm.backend.entity.ResultatExamen;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.ExamenRepository;
import com.cscm.backend.repository.ResultatExamenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ExamenService {

    private final ExamenRepository examenRepository;
    private final ResultatExamenRepository resultatRepository;

    public Flux<Examen> getByCarnet(UUID carnetId, int size, long offset) {
        return examenRepository.findByCarnetIdPaged(carnetId, size, offset);
    }

    public Mono<Examen> getById(UUID id) {
        return examenRepository.findById(id)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Examen introuvable: " + id)));
    }

    public Mono<Examen> create(UUID carnetId, UUID medecinId, Examen data) {
        data.setId(UUID.randomUUID());
        data.setCarnetId(carnetId);
        data.setMedecinPrescripteurId(medecinId);
        return examenRepository.save(data);
    }

    public Mono<Examen> marquerRealise(UUID id) {
        return getById(id)
                .flatMap(examen -> {
                    if (examen.getDateRealisation() == null) {
                        examen.setDateRealisation(LocalDateTime.now());
                    }
                    return examenRepository.save(examen);
                });
    }

    public Mono<Examen> update(UUID id, Examen updates) {
        return getById(id)
                .flatMap(examen -> {
                    if (updates.getTypeExamen() != null) examen.setTypeExamen(updates.getTypeExamen());
                    if (updates.getInstructions() != null) examen.setInstructions(updates.getInstructions());
                    if (updates.getEtablissementRealisation() != null) examen.setEtablissementRealisation(updates.getEtablissementRealisation());
                    if (updates.getDateRealisation() != null) examen.setDateRealisation(updates.getDateRealisation());
                    if (updates.getNotes() != null) examen.setNotes(updates.getNotes());
                    return examenRepository.save(examen);
                });
    }

    public Mono<Void> delete(UUID id) {
        return examenRepository.existsById(id)
                .flatMap(exists -> exists
                        ? examenRepository.deleteById(id)
                        : Mono.error(new ResourceNotFoundException("Examen introuvable: " + id)));
    }

    public Flux<ResultatExamen> getResultats(UUID examenId) {
        return resultatRepository.findByExamenId(examenId);
    }

    public Mono<ResultatExamen> addResultat(UUID examenId, ResultatExamen data) {
        return getById(examenId)
                .flatMap(examen -> {
                    data.setId(UUID.randomUUID());
                    data.setExamenId(examenId);
                    return resultatRepository.save(data)
                            .flatMap(saved -> {
                                examen.setResultatPrisEnCompte(true);
                                return examenRepository.save(examen).thenReturn(saved);
                            });
                });
    }
}

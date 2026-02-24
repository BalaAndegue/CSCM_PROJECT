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

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ExamenService {
    private final ExamenRepository examenRepository;
    private final ResultatExamenRepository resultatRepository;
    private final CarnetMedicalRepository carnetMedicalRepository;
    private final MedecinRepository medecinRepository;

    public Page<Examen> getByCarnet(UUID carnetId, Pageable pageable) {
        return examenRepository.findByCarnetId(carnetId, pageable);
    }

    public Examen getById(UUID id) {
        return examenRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Examen introuvable: " + id));
    }

    @Transactional
    public Examen create(UUID carnetId, UUID medecinId, Examen data) {
        CarnetMedical carnet = carnetMedicalRepository.findById(carnetId)
                .orElseThrow(() -> new ResourceNotFoundException("Carnet introuvable"));
        Medecin medecin = medecinRepository.findById(medecinId)
                .orElseThrow(() -> new ResourceNotFoundException("Médecin introuvable"));
        data.setCarnet(carnet);
        data.setMedecinPrescripteur(medecin);
        return examenRepository.save(data);
    }

    @Transactional
    public Examen marquerRealise(UUID id) {
        Examen examen = getById(id);
        if (examen.getDateRealisation() == null)
            examen.setDateRealisation(java.time.LocalDateTime.now());
        return examenRepository.save(examen);
    }

    @Transactional
    public Examen update(UUID id, Examen updates) {
        Examen examen = getById(id);
        if (updates.getTypeExamen() != null) examen.setTypeExamen(updates.getTypeExamen());
        if (updates.getInstructions() != null) examen.setInstructions(updates.getInstructions());
        if (updates.getEtablissementRealisation() != null) examen.setEtablissementRealisation(updates.getEtablissementRealisation());
        if (updates.getDateRealisation() != null) examen.setDateRealisation(updates.getDateRealisation());
        if (updates.getNotes() != null) examen.setNotes(updates.getNotes());
        return examenRepository.save(examen);
    }

    @Transactional
    public void delete(UUID id) {
        if (!examenRepository.existsById(id))
            throw new ResourceNotFoundException("Examen introuvable: " + id);
        examenRepository.deleteById(id);
    }

    public List<ResultatExamen> getResultats(UUID examenId) {
        return resultatRepository.findByExamenId(examenId);
    }

    @Transactional
    public ResultatExamen addResultat(UUID examenId, ResultatExamen data) {
        Examen examen = getById(examenId);
        data.setExamen(examen);
        ResultatExamen saved = resultatRepository.save(data);
        examen.setResultatPrisEnCompte(true);
        examenRepository.save(examen);
        return saved;
    }
}

package com.cscm.backend.service;

import com.cscm.backend.entity.*;
import com.cscm.backend.enums.OrdonnanceStatus;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class OrdonnanceService {
    private final OrdonnanceRepository ordonnanceRepository;
    private final CarnetMedicalRepository carnetMedicalRepository;
    private final MedecinRepository medecinRepository;
    private final HopitalRepository hopitalRepository;

    public Page<Ordonnance> getByCarnet(UUID carnetId, Pageable pageable) {
        return ordonnanceRepository.findByCarnetId(carnetId, pageable);
    }

    public Page<Ordonnance> getByMedecin(UUID medecinId, Pageable pageable) {
        return ordonnanceRepository.findByMedecinId(medecinId, pageable);
    }

    public Ordonnance getById(UUID id) {
        return ordonnanceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Ordonnance introuvable: " + id));
    }

    @Transactional
    public Ordonnance create(UUID carnetId, UUID medecinId, UUID hopitalId, Ordonnance data) {
        CarnetMedical carnet = carnetMedicalRepository.findById(carnetId)
                .orElseThrow(() -> new ResourceNotFoundException("Carnet introuvable"));
        Medecin medecin = medecinRepository.findById(medecinId)
                .orElseThrow(() -> new ResourceNotFoundException("Médecin introuvable"));
        Hopital hopital = hopitalRepository.findById(hopitalId)
                .orElseThrow(() -> new ResourceNotFoundException("Hôpital introuvable"));

        data.setCarnet(carnet);
        data.setMedecin(medecin);
        data.setHopital(hopital);

        // Générer numéro unique
        String numOrd = genererNumeroOrdonnance();
        data.setNumeroOrdonnance(numOrd);
        if (data.getDatePrescription() == null)
            data.setDatePrescription(java.time.LocalDateTime.now());

        return ordonnanceRepository.save(data);
    }

    @Transactional
    public Ordonnance update(UUID id, Ordonnance updates) {
        Ordonnance ord = getById(id);
        if (ord.getStatus() != OrdonnanceStatus.ACTIVE)
            throw new BusinessException("Cette ordonnance n'est plus modifiable");
        if (updates.getMedicaments() != null) ord.setMedicaments(updates.getMedicaments());
        if (updates.getInstructions() != null) ord.setInstructions(updates.getInstructions());
        if (updates.getPosologieDetaillee() != null) ord.setPosologieDetaillee(updates.getPosologieDetaillee());
        if (updates.getRenouvelable() != null) ord.setRenouvelable(updates.getRenouvelable());
        if (updates.getDateExpiration() != null) ord.setDateExpiration(updates.getDateExpiration());
        return ordonnanceRepository.save(ord);
    }

    @Transactional
    public Ordonnance annuler(UUID id) {
        Ordonnance ord = getById(id);
        ord.setStatus(OrdonnanceStatus.ANNULEE);
        return ordonnanceRepository.save(ord);
    }

    private String genererNumeroOrdonnance() {
        String num = "ORD-" + System.currentTimeMillis();
        while (ordonnanceRepository.existsByNumeroOrdonnance(num)) {
            num = "ORD-" + System.currentTimeMillis() + "-" + (int)(Math.random() * 999);
        }
        return num;
    }
}

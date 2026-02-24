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
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ConsentService {
    private final ConsentDiagnosticHopitalRepository consentRepository;
    private final ConsultationRepository consultationRepository;
    private final MedecinRepository medecinRepository;
    private final HopitalRepository hopitalRepository;
    private final UserRepository userRepository;

    public Page<ConsentDiagnosticHopital> getByHopital(UUID hopitalId, Pageable pageable) {
        return consentRepository.findByHopitalId(hopitalId, pageable);
    }

    public Page<ConsentDiagnosticHopital> getPendingByHopital(UUID hopitalId, Pageable pageable) {
        return consentRepository.findByHopitalIdAndApprouveParManager(hopitalId, false, pageable);
    }

    public ConsentDiagnosticHopital getById(UUID id) {
        return consentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Consentement introuvable"));
    }

    @Transactional
    public ConsentDiagnosticHopital demanderConsent(UUID consultationId, UUID medecinId, UUID hopitalId, String motif) {
        Consultation consultation = consultationRepository.findById(consultationId)
                .orElseThrow(() -> new ResourceNotFoundException("Consultation introuvable"));
        Medecin medecin = medecinRepository.findById(medecinId)
                .orElseThrow(() -> new ResourceNotFoundException("Médecin introuvable"));
        Hopital hopital = hopitalRepository.findById(hopitalId)
                .orElseThrow(() -> new ResourceNotFoundException("Hôpital introuvable"));

        ConsentDiagnosticHopital consent = ConsentDiagnosticHopital.builder()
                .consultation(consultation)
                .medecin(medecin)
                .hopital(hopital)
                .motifDemande(motif)
                .demandeParMedecin(LocalDateTime.now())
                .build();
        return consentRepository.save(consent);
    }

    @Transactional
    public ConsentDiagnosticHopital approuver(UUID id, UUID managerId) {
        ConsentDiagnosticHopital consent = getById(id);
        User manager = userRepository.findById(managerId)
                .orElseThrow(() -> new ResourceNotFoundException("Manager introuvable"));
        consent.setApprouveParManager(true);
        consent.setManager(manager);
        consent.setDateApprouvation(LocalDateTime.now());
        consent.setDateExpiration(LocalDateTime.now().plusDays(30));
        return consentRepository.save(consent);
    }

    @Transactional
    public ConsentDiagnosticHopital refuser(UUID id, UUID managerId, String motifRefus) {
        ConsentDiagnosticHopital consent = getById(id);
        User manager = userRepository.findById(managerId)
                .orElseThrow(() -> new ResourceNotFoundException("Manager introuvable"));
        consent.setApprouveParManager(false);
        consent.setManager(manager);
        consent.setDateApprouvation(LocalDateTime.now());
        consent.setMotifRefus(motifRefus);
        return consentRepository.save(consent);
    }
}

package com.cscm.backend.service;

import com.cscm.backend.entity.ConsentDiagnosticHopital;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.ConsentDiagnosticHopitalRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ConsentService {

    private final ConsentDiagnosticHopitalRepository consentRepository;

    public Flux<ConsentDiagnosticHopital> getByHopital(UUID hopitalId) {
        return consentRepository.findByHopitalId(hopitalId);
    }

    public Flux<ConsentDiagnosticHopital> getPendingByHopital(UUID hopitalId, int size, long offset) {
        return consentRepository.findByHopitalIdAndApprouveParManager(hopitalId, false, size, offset);
    }

    public Mono<ConsentDiagnosticHopital> getById(UUID id) {
        return consentRepository.findById(id)
                .switchIfEmpty(Mono.error(new ResourceNotFoundException("Consentement introuvable")));
    }

    public Mono<ConsentDiagnosticHopital> demanderConsent(UUID consultationId, UUID medecinId,
                                                            UUID hopitalId, String motif) {
        ConsentDiagnosticHopital consent = ConsentDiagnosticHopital.builder()
                .id(UUID.randomUUID())
                .consultationId(consultationId)
                .medecinId(medecinId)
                .hopitalId(hopitalId)
                .motifDemande(motif)
                .demandeParMedecin(LocalDateTime.now())
                .approuveParManager(false)
                .build();
        return consentRepository.save(consent);
    }

    public Mono<ConsentDiagnosticHopital> approuver(UUID id, UUID managerId) {
        return getById(id)
                .flatMap(consent -> {
                    consent.setApprouveParManager(true);
                    consent.setManagerId(managerId);
                    consent.setDateApprouvation(LocalDateTime.now());
                    consent.setDateExpiration(LocalDateTime.now().plusDays(30));
                    return consentRepository.save(consent);
                });
    }

    public Mono<ConsentDiagnosticHopital> refuser(UUID id, UUID managerId, String motifRefus) {
        return getById(id)
                .flatMap(consent -> {
                    consent.setApprouveParManager(false);
                    consent.setManagerId(managerId);
                    consent.setDateApprouvation(LocalDateTime.now());
                    consent.setMotifRefus(motifRefus);
                    return consentRepository.save(consent);
                });
    }
}

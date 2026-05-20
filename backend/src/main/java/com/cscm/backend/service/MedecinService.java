package com.cscm.backend.service;

import com.cscm.backend.entity.Medecin;
import com.cscm.backend.enums.MedecinStatus;
import com.cscm.backend.enums.TypeNotification;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.repository.MedecinRepository;
import com.cscm.backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class MedecinService {

    private final MedecinRepository medecinRepository;
    private final UserRepository userRepository;
    private final NotificationService notificationService;

    public Mono<Medecin> getMedecinById(UUID id) {
        return medecinRepository.findById(id)
                .switchIfEmpty(Mono.error(new BusinessException("Médecin introuvable: " + id)));
    }

    public Mono<Medecin> getMedecinByUserId(UUID userId) {
        return medecinRepository.findByUserId(userId)
                .switchIfEmpty(Mono.error(new BusinessException("Profil médecin introuvable")));
    }

    public Flux<Medecin> getMedecinsEnAttente(int size, long offset) {
        return medecinRepository.findEnAttentePaged(size, offset);
    }

    public Flux<Medecin> getMedecinsParHopital(UUID hopitalId) {
        return medecinRepository.findByHopitalId(hopitalId);
    }

    public Flux<Medecin> searchBySpecialite(String specialite, int size, long offset) {
        return medecinRepository.findBySpecialitePaged(specialite, size, offset);
    }

    public Mono<Medecin> updateMedecin(UUID id, UUID requestingUserId, String specialite,
                                        String sousSpecialite, String biographie,
                                        Integer anneesExperience, Double consultationFee,
                                        String languesJson) {
        return medecinRepository.findById(id)
                .switchIfEmpty(Mono.error(new BusinessException("Médecin introuvable")))
                .flatMap(medecin -> {
                    if (!medecin.getUserId().equals(requestingUserId)) {
                        return Mono.error(new BusinessException("Accès non autorisé"));
                    }
                    if (specialite != null) medecin.setSpecialite(specialite);
                    if (sousSpecialite != null) medecin.setSousSpecialite(sousSpecialite);
                    if (biographie != null) medecin.setBiographie(biographie);
                    if (anneesExperience != null) medecin.setAnneesExperience(anneesExperience);
                    if (consultationFee != null) medecin.setConsultationFee(consultationFee);
                    if (languesJson != null) medecin.setLanguesJson(languesJson);
                    medecin.setUpdatedAt(LocalDateTime.now());
                    return medecinRepository.save(medecin);
                });
    }

    // ─── Validation admin ────────────────────────────────────────────────────

    public Mono<Medecin> validerMedecin(UUID id, UUID adminId) {
        return medecinRepository.findById(id)
                .switchIfEmpty(Mono.error(new BusinessException("Médecin introuvable")))
                .flatMap(medecin -> {
                    if (medecin.getStatus() != MedecinStatus.EN_ATTENTE) {
                        return Mono.error(new BusinessException("Ce médecin n'est pas en attente de validation"));
                    }
                    medecin.setStatus(MedecinStatus.VALIDE);
                    medecin.setValidePar(adminId);
                    medecin.setDateValidation(LocalDateTime.now());
                    medecin.setRaisonRejet(null);
                    return medecinRepository.save(medecin);
                })
                .flatMap(medecin -> {
                    notificationService.creerEtEnvoyer(
                            medecin.getUserId(), adminId,
                            TypeNotification.INSCRIPTION_MEDECIN_VALIDEE,
                            "Inscription validée",
                            "Votre dossier médecin a été validé. Vous pouvez maintenant exercer sur la plateforme.",
                            Map.of("medecinId", medecin.getId().toString())
                    ).subscribe();
                    return Mono.just(medecin);
                });
    }

    public Mono<Medecin> rejeterMedecin(UUID id, UUID adminId, String raison) {
        return medecinRepository.findById(id)
                .switchIfEmpty(Mono.error(new BusinessException("Médecin introuvable")))
                .flatMap(medecin -> {
                    medecin.setStatus(MedecinStatus.REJETE);
                    medecin.setValidePar(adminId);
                    medecin.setDateValidation(LocalDateTime.now());
                    medecin.setRaisonRejet(raison);
                    return medecinRepository.save(medecin);
                })
                .flatMap(medecin -> {
                    notificationService.creerEtEnvoyer(
                            medecin.getUserId(), adminId,
                            TypeNotification.DOCUMENT_REJETE,
                            "Inscription rejetée",
                            "Votre dossier a été rejeté. Motif: " + raison,
                            Map.of("medecinId", medecin.getId().toString(), "raison", raison)
                    ).subscribe();
                    return Mono.just(medecin);
                });
    }

    public Mono<Medecin> suspendMedecin(UUID id, UUID adminId) {
        return medecinRepository.findById(id)
                .switchIfEmpty(Mono.error(new BusinessException("Médecin introuvable")))
                .flatMap(medecin -> {
                    medecin.setStatus(MedecinStatus.SUSPENDU);
                    medecin.setUpdatedAt(LocalDateTime.now());
                    return medecinRepository.save(medecin);
                });
    }
}

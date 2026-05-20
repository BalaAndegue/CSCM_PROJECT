package com.cscm.backend.service;

import com.cscm.backend.entity.ApprobationMedecin;
import com.cscm.backend.entity.MedecinPersonnel;
import com.cscm.backend.enums.TypeAccesCarnet;
import com.cscm.backend.enums.TypeNotification;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ApprobationService {

    private final ApprobationMedecinRepository approbationRepository;
    private final CarnetMedicalRepository carnetMedicalRepository;
    private final MedecinRepository medecinRepository;
    private final MedecinPersonnelRepository medecinPersonnelRepository;
    private final PatientRepository patientRepository;
    private final NotificationService notificationService;

    // ─── Listing ─────────────────────────────────────────────────────────────

    public Flux<ApprobationMedecin> getMedecinsApprouves(UUID carnetId) {
        return approbationRepository.findByCarnetIdAndActifTrue(carnetId);
    }

    public Flux<ApprobationMedecin> getApprobationsParMedecin(UUID medecinId) {
        return approbationRepository.findByMedecinIdAndActifTrue(medecinId);
    }

    // ─── Approbation via token accès (QR/Code court) ─────────────────────────

    public Mono<ApprobationMedecin> enregistrerAccesParToken(UUID carnetId, UUID medecinId,
                                                               UUID tokenAccesId, TypeAccesCarnet typeAcces,
                                                               boolean accesHistorique, boolean accesOrdonnances,
                                                               boolean accesExamens, boolean peutEditer) {
        return carnetMedicalRepository.findById(carnetId)
                .switchIfEmpty(Mono.error(new BusinessException("Carnet introuvable")))
                .flatMap(carnet -> medecinRepository.findById(medecinId)
                        .switchIfEmpty(Mono.error(new BusinessException("Médecin introuvable")))
                        .flatMap(medecin -> approbationRepository.findByCarnetIdAndMedecinId(carnetId, medecinId)
                                .flatMap(existing -> {
                                    if (existing.getActif()) {
                                        // Déjà approuvé — on met à jour les droits
                                        existing.setTypeAcces(typeAcces);
                                        existing.setTokenAccesId(tokenAccesId);
                                        existing.setAccesHistorique(accesHistorique);
                                        existing.setAccesOrdonnances(accesOrdonnances);
                                        existing.setAccesExamens(accesExamens);
                                        existing.setPeutEditer(peutEditer);
                                        existing.setUpdatedAt(LocalDateTime.now());
                                        return approbationRepository.save(existing);
                                    }
                                    return creerNouvelleApprobation(carnetId, medecinId, tokenAccesId,
                                            typeAcces, false, accesHistorique, accesOrdonnances, accesExamens, peutEditer);
                                })
                                .switchIfEmpty(creerNouvelleApprobation(carnetId, medecinId, tokenAccesId,
                                        typeAcces, false, accesHistorique, accesOrdonnances, accesExamens, peutEditer))
                        )
                );
    }

    // ─── Médecin personnel (traitant) ─────────────────────────────────────────

    public Mono<MedecinPersonnel> definirMedecinPersonnel(UUID carnetId, UUID patientId, UUID medecinId) {
        return medecinPersonnelRepository.existsByPatientIdAndMedecinIdAndActifTrue(patientId, medecinId)
                .flatMap(exists -> {
                    if (exists) return Mono.error(new BusinessException("Ce médecin est déjà votre médecin traitant"));
                    return medecinRepository.findById(medecinId)
                            .switchIfEmpty(Mono.error(new BusinessException("Médecin introuvable")));
                })
                .flatMap(medecin -> {
                    MedecinPersonnel mp = MedecinPersonnel.builder()
                            .id(UUID.randomUUID())
                            .carnetId(carnetId)
                            .patientId(patientId)
                            .medecinId(medecinId)
                            .actif(true)
                            .dateDebut(LocalDateTime.now())
                            .build();
                    return medecinPersonnelRepository.save(mp);
                })
                .flatMap(mp -> {
                    // Approbation permanente pour le médecin traitant
                    return approbationRepository.findByCarnetIdAndMedecinId(carnetId, medecinId)
                            .flatMap(existing -> {
                                existing.setEstMedecinPersonnel(true);
                                existing.setActif(true);
                                existing.setAccesHistorique(true);
                                existing.setAccesOrdonnances(true);
                                existing.setAccesExamens(true);
                                existing.setAccesAllergies(true);
                                existing.setPeutEditer(true);
                                existing.setUpdatedAt(LocalDateTime.now());
                                return approbationRepository.save(existing);
                            })
                            .switchIfEmpty(creerNouvelleApprobation(carnetId, medecinId, null,
                                    TypeAccesCarnet.PERMANENT_PERSONNEL, true, true, true, true, true))
                            .thenReturn(mp);
                })
                .flatMap(mp -> {
                    notificationService.creerEtEnvoyer(
                            medecinId, patientId,
                            TypeNotification.ACCES_ACCORDE,
                            "Désigné médecin traitant",
                            "Un patient vous a désigné comme médecin traitant avec accès permanent.",
                            Map.of("carnetId", carnetId.toString(), "patientId", patientId.toString())
                    ).subscribe();
                    return Mono.just(mp);
                });
    }

    public Mono<Void> retirerMedecinPersonnel(UUID patientId, UUID medecinId) {
        return medecinPersonnelRepository.findByPatientIdAndMedecinIdAndActifTrue(patientId, medecinId)
                .switchIfEmpty(Mono.error(new BusinessException("Aucun médecin traitant avec cet ID")))
                .flatMap(mp -> {
                    mp.setActif(false);
                    mp.setDateFin(LocalDateTime.now());
                    mp.setMotifFin("Retiré par le patient");
                    return medecinPersonnelRepository.save(mp);
                })
                .flatMap(mp -> approbationRepository.findByCarnetIdAndMedecinId(mp.getCarnetId(), medecinId)
                        .flatMap(appro -> {
                            appro.setEstMedecinPersonnel(false);
                            appro.setActif(false);
                            appro.setDateRevocation(LocalDateTime.now());
                            appro.setMotifRevocation("Médecin traitant retiré");
                            return approbationRepository.save(appro);
                        }))
                .then();
    }

    public Flux<MedecinPersonnel> getMedecinsPersonnels(UUID patientId) {
        return medecinPersonnelRepository.findByPatientIdAndActifTrue(patientId);
    }

    // ─── Révocation ──────────────────────────────────────────────────────────

    public Mono<ApprobationMedecin> revoquerApprobation(UUID id, UUID patientId, String motif) {
        return approbationRepository.findById(id)
                .switchIfEmpty(Mono.error(new BusinessException("Approbation introuvable")))
                .flatMap(approbation -> {
                    if (approbation.getEstMedecinPersonnel()) {
                        return Mono.error(new BusinessException(
                                "Utilisez l'endpoint médecin traitant pour retirer un médecin personnel"));
                    }
                    approbation.setActif(false);
                    approbation.setDateRevocation(LocalDateTime.now());
                    approbation.setMotifRevocation(motif);
                    return approbationRepository.save(approbation);
                })
                .flatMap(appro -> {
                    notificationService.creerEtEnvoyer(
                            appro.getMedecinId(), patientId,
                            TypeNotification.ACCES_REVOQUE,
                            "Accès révoqué",
                            "Votre accès à un carnet médical a été révoqué.",
                            Map.of("carnetId", appro.getCarnetId().toString())
                    ).subscribe();
                    return Mono.just(appro);
                });
    }

    public Mono<Integer> revoquerTousLesMedecins(UUID carnetId) {
        return approbationRepository.revokeAllForCarnet(carnetId);
    }

    // ─── Helpers ─────────────────────────────────────────────────────────────

    private Mono<ApprobationMedecin> creerNouvelleApprobation(
            UUID carnetId, UUID medecinId, UUID tokenAccesId, TypeAccesCarnet typeAcces,
            boolean estMedecinPersonnel, boolean accesHistorique, boolean accesOrdonnances,
            boolean accesExamens, boolean peutEditer) {

        ApprobationMedecin approbation = ApprobationMedecin.builder()
                .id(UUID.randomUUID())
                .carnetId(carnetId)
                .medecinId(medecinId)
                .tokenAccesId(tokenAccesId)
                .typeAcces(typeAcces)
                .estMedecinPersonnel(estMedecinPersonnel)
                .actif(true)
                .approuveParPatient(!estMedecinPersonnel)
                .dateSignaturePatient(LocalDateTime.now())
                .accesHistorique(accesHistorique)
                .accesOrdonnances(accesOrdonnances)
                .accesExamens(accesExamens)
                .accesAllergies(estMedecinPersonnel)
                .peutEditer(peutEditer)
                .build();

        return approbationRepository.save(approbation);
    }
}

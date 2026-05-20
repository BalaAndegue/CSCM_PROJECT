package com.cscm.backend.service;

import com.cscm.backend.entity.TokenAccesMedecin;
import com.cscm.backend.enums.StatutTokenAcces;
import com.cscm.backend.enums.TypeAccesCarnet;
import com.cscm.backend.enums.TypeNotification;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.repository.CarnetMedicalRepository;
import com.cscm.backend.repository.MedecinRepository;
import com.cscm.backend.repository.TokenAccesMedecinRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class TokenAccesService {

    private final TokenAccesMedecinRepository tokenRepo;
    private final CarnetMedicalRepository carnetRepo;
    private final MedecinRepository medecinRepo;
    private final QrCodeService qrCodeService;
    private final NotificationService notificationService;

    @Value("${app.qrcode.expiry-minutes:15}")
    private int qrExpiryMinutes;

    @Value("${app.qrcode.code-court-expiry-minutes:30}")
    private int codeCourtExpiryMinutes;

    private static final SecureRandom RANDOM = new SecureRandom();

    // ─── Génération QR Code ──────────────────────────────────────────────────

    public Mono<TokenAvecQr> genererTokenQr(UUID carnetId, UUID patientId,
                                             boolean accesHistorique, boolean accesOrdonnances,
                                             boolean accesExamens, boolean peutEditer) {
        return carnetRepo.findById(carnetId)
                .switchIfEmpty(Mono.error(new BusinessException("Carnet introuvable")))
                .flatMap(carnet -> {
                    UUID tokenId = UUID.randomUUID();
                    String qrPayload = qrCodeService.genererPayloadJwt(carnetId, patientId, tokenId);

                    TokenAccesMedecin token = TokenAccesMedecin.builder()
                            .id(tokenId)
                            .carnetId(carnetId)
                            .patientId(patientId)
                            .typeAcces(TypeAccesCarnet.QR_CODE)
                            .qrPayload(qrPayload)
                            .statut(StatutTokenAcces.ACTIF)
                            .expiresAt(LocalDateTime.now().plusMinutes(qrExpiryMinutes))
                            .accesHistorique(accesHistorique)
                            .accesOrdonnances(accesOrdonnances)
                            .accesExamens(accesExamens)
                            .peutEditer(peutEditer)
                            .build();

                    return tokenRepo.save(token);
                })
                .flatMap(saved -> qrCodeService.genererQrCodePng(saved.getQrPayload())
                        .map(png -> new TokenAvecQr(saved, png)));
    }

    // ─── Génération Code Court ───────────────────────────────────────────────

    public Mono<TokenAccesMedecin> genererCodeCourt(UUID carnetId, UUID patientId,
                                                      boolean accesHistorique, boolean accesOrdonnances,
                                                      boolean accesExamens, boolean peutEditer) {
        return carnetRepo.findById(carnetId)
                .switchIfEmpty(Mono.error(new BusinessException("Carnet introuvable")))
                .flatMap(carnet -> {
                    String codeCourt = genererCode6Chiffres();
                    TokenAccesMedecin token = TokenAccesMedecin.builder()
                            .id(UUID.randomUUID())
                            .carnetId(carnetId)
                            .patientId(patientId)
                            .typeAcces(TypeAccesCarnet.CODE_COURT)
                            .codeCourt(codeCourt)
                            .statut(StatutTokenAcces.ACTIF)
                            .expiresAt(LocalDateTime.now().plusMinutes(codeCourtExpiryMinutes))
                            .accesHistorique(accesHistorique)
                            .accesOrdonnances(accesOrdonnances)
                            .accesExamens(accesExamens)
                            .peutEditer(peutEditer)
                            .build();
                    return tokenRepo.save(token);
                });
    }

    // ─── Validation QR ───────────────────────────────────────────────────────

    public Mono<TokenAccesMedecin> validerQrEtAccorder(String qrJwt, UUID medecinId) {
        if (!qrCodeService.estValide(qrJwt)) {
            return Mono.error(new BusinessException("QR code expiré ou invalide"));
        }

        UUID tokenId = qrCodeService.extraireTokenId(qrJwt);
        UUID carnetId = qrCodeService.extraireCarnetId(qrJwt);

        return tokenRepo.findById(tokenId)
                .switchIfEmpty(Mono.error(new BusinessException("Token QR introuvable")))
                .flatMap(token -> {
                    if (token.getStatut() != StatutTokenAcces.ACTIF) {
                        return Mono.error(new BusinessException("Ce QR code a déjà été utilisé"));
                    }
                    if (token.getExpiresAt().isBefore(LocalDateTime.now())) {
                        return Mono.error(new BusinessException("QR code expiré"));
                    }

                    token.setMedecinId(medecinId);
                    token.setStatut(StatutTokenAcces.UTILISE);
                    token.setUtiliséAt(LocalDateTime.now());

                    return tokenRepo.save(token)
                            .flatMap(saved -> {
                                notificationService.creerEtEnvoyer(
                                        saved.getPatientId(), medecinId,
                                        TypeNotification.ACCES_ACCORDE,
                                        "Accès carnet accordé",
                                        "Un médecin a accédé à votre carnet médical via QR code",
                                        Map.of("carnetId", carnetId.toString(), "medecinId", medecinId.toString())
                                ).subscribe();
                                return Mono.just(saved);
                            });
                });
    }

    // ─── Validation Code Court ───────────────────────────────────────────────

    public Mono<TokenAccesMedecin> validerCodeCourtEtAccorder(String codeCourt, UUID medecinId) {
        return tokenRepo.findActiveByCodeCourt(codeCourt)
                .switchIfEmpty(Mono.error(new BusinessException("Code invalide ou expiré")))
                .flatMap(token -> {
                    token.setMedecinId(medecinId);
                    token.setStatut(StatutTokenAcces.UTILISE);
                    token.setUtiliséAt(LocalDateTime.now());

                    return tokenRepo.save(token)
                            .flatMap(saved -> {
                                notificationService.creerEtEnvoyer(
                                        saved.getPatientId(), medecinId,
                                        TypeNotification.ACCES_ACCORDE,
                                        "Accès carnet accordé",
                                        "Un médecin a accédé à votre carnet via code à 6 chiffres",
                                        Map.of("carnetId", saved.getCarnetId().toString())
                                ).subscribe();
                                return Mono.just(saved);
                            });
                });
    }

    // ─── Révocation ──────────────────────────────────────────────────────────

    public Mono<Integer> revoquerTousLesTokensCarnet(UUID carnetId) {
        return tokenRepo.revokeAllForCarnet(carnetId);
    }

    public Mono<TokenAccesMedecin> revoquerToken(UUID tokenId, UUID patientId) {
        return tokenRepo.findById(tokenId)
                .switchIfEmpty(Mono.error(new BusinessException("Token introuvable")))
                .flatMap(token -> {
                    if (!token.getPatientId().equals(patientId)) {
                        return Mono.error(new BusinessException("Non autorisé"));
                    }
                    token.setStatut(StatutTokenAcces.REVOQUE);
                    return tokenRepo.save(token);
                });
    }

    // ─── Expiration automatique ───────────────────────────────────────────────

    public Mono<Integer> expireTokensObsoletes() {
        return tokenRepo.expireTokens(LocalDateTime.now())
                .doOnNext(count -> log.info("Tokens expirés: {}", count));
    }

    // ─── Listing ─────────────────────────────────────────────────────────────

    public Flux<TokenAccesMedecin> getTokensActifsCarnet(UUID carnetId) {
        return tokenRepo.findByCarnetIdAndStatut(carnetId, StatutTokenAcces.ACTIF);
    }

    public Flux<TokenAccesMedecin> getHistoriquePatient(UUID patientId) {
        return tokenRepo.findByPatientId(patientId);
    }

    // ─── Helpers ─────────────────────────────────────────────────────────────

    private String genererCode6Chiffres() {
        return String.format("%06d", RANDOM.nextInt(1_000_000));
    }

    public record TokenAvecQr(TokenAccesMedecin token, byte[] qrCodePng) {}
}

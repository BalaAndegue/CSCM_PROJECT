package com.cscm.backend.service;

import com.cscm.backend.entity.CarnetMedical;
import com.cscm.backend.entity.Medecin;
import com.cscm.backend.entity.Patient;
import com.cscm.backend.entity.User;
import com.cscm.backend.enums.LienParente;
import com.cscm.backend.enums.MedecinStatus;
import com.cscm.backend.enums.UserRole;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.repository.*;
import com.cscm.backend.security.JwtUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.ReactiveAuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.ReactiveUserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class AuthService {

    private final UserRepository userRepository;
    private final PatientRepository patientRepository;
    private final MedecinRepository medecinRepository;
    private final CarnetMedicalRepository carnetMedicalRepository;
    private final SessionRepository sessionRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtils jwtUtils;
    private final ReactiveAuthenticationManager authenticationManager;
    private final ReactiveUserDetailsService userDetailsService;
    private final MatriculeService matriculeService;

    // ─── Inscription patient ──────────────────────────────────────────────────

    public Mono<Map<String, Object>> registerPatient(
            String email, String motDePasse, String nomComplet, String telephone,
            LocalDate dateNaissance, com.cscm.backend.enums.Genre genre,
            // CNI obligatoire
            String numeroCNI, LocalDate dateDelivranceCNI, String lieuDelivranceCNI,
            String lieuNaissance, String nationalite,
            // Garant/Avariste obligatoire
            String garantNomComplet, String garantTelephone, LienParente garantLienParente,
            String garantNumeroCNI, String garantEmail) {

        if (numeroCNI == null || numeroCNI.isBlank()) {
            return Mono.error(new BusinessException("Le numéro de CNI est obligatoire"));
        }
        if (garantNomComplet == null || garantTelephone == null || garantLienParente == null) {
            return Mono.error(new BusinessException("Les informations de l'avariste (garant) sont obligatoires"));
        }

        return userRepository.existsByEmail(email)
                .flatMap(exists -> {
                    if (exists) return Mono.error(new BusinessException("Un compte existe déjà avec cet email"));
                    return matriculeService.genererMatriculePatient();
                })
                .flatMap(matricule -> {
                    User user = User.builder()
                            .id(UUID.randomUUID())
                            .email(email)
                            .motDePasseHash(passwordEncoder.encode(motDePasse))
                            .role(UserRole.PATIENT)
                            .nomComplet(nomComplet)
                            .telephone(telephone)
                            .matricule(matricule)
                            .tokenVerificationEmail(UUID.randomUUID().toString())
                            .compteActif(true)
                            .emailVerifie(false)
                            .build();
                    return userRepository.save(user);
                })
                .flatMap(user -> {
                    Patient patient = Patient.builder()
                            .id(UUID.randomUUID())
                            .userId(user.getId())
                            .dateNaissance(dateNaissance)
                            .genre(genre)
                            .numeroCNI(numeroCNI)
                            .dateDelivranceCNI(dateDelivranceCNI)
                            .lieuDelivranceCNI(lieuDelivranceCNI)
                            .lieuNaissance(lieuNaissance)
                            .nationalite(nationalite)
                            .garantNomComplet(garantNomComplet)
                            .garantTelephone(garantTelephone)
                            .garantLienParente(garantLienParente)
                            .garantNumeroCNI(garantNumeroCNI)
                            .garantEmail(garantEmail)
                            .garantAccesActif(false)
                            .build();
                    return patientRepository.save(patient)
                            .flatMap(savedPatient -> {
                                CarnetMedical carnet = CarnetMedical.builder()
                                        .id(UUID.randomUUID())
                                        .patientId(savedPatient.getId())
                                        .build();
                                return carnetMedicalRepository.save(carnet);
                            })
                            .thenReturn(user);
                })
                .flatMap(user -> {
                    log.info("Nouveau patient inscrit: {} | Matricule: {}", email, user.getMatricule());
                    return buildAuthResponse(user);
                });
    }

    // ─── Inscription médecin ──────────────────────────────────────────────────

    public Mono<Map<String, Object>> registerMedecin(
            String email, String motDePasse, String nomComplet, String telephone,
            String specialite, String numeroCNOM,
            String numeroCNI, LocalDate dateDelivranceCNI, String lieuDelivranceCNI,
            String villePrincipale, com.cscm.backend.enums.RegionCameroun regionPrincipale) {

        if (numeroCNOM == null || numeroCNOM.isBlank()) {
            return Mono.error(new BusinessException("Le numéro CNOM est obligatoire"));
        }

        return userRepository.existsByEmail(email)
                .flatMap(exists -> {
                    if (exists) return Mono.error(new BusinessException("Un compte existe déjà avec cet email"));
                    return medecinRepository.findByNumeroCNOM(numeroCNOM);
                })
                .flatMap(existing -> Mono.error(new BusinessException("Ce numéro CNOM est déjà enregistré")))
                .switchIfEmpty(matriculeService.genererMatriculeMedecin())
                .cast(String.class)
                .flatMap(matricule -> {
                    User user = User.builder()
                            .id(UUID.randomUUID())
                            .email(email)
                            .motDePasseHash(passwordEncoder.encode(motDePasse))
                            .role(UserRole.MEDECIN)
                            .nomComplet(nomComplet)
                            .telephone(telephone)
                            .matricule(matricule)
                            .tokenVerificationEmail(UUID.randomUUID().toString())
                            .compteActif(true)
                            .emailVerifie(false)
                            .build();
                    return userRepository.save(user);
                })
                .flatMap(user -> {
                    Medecin medecin = Medecin.builder()
                            .id(UUID.randomUUID())
                            .userId(user.getId())
                            .specialite(specialite)
                            .numeroCNOM(numeroCNOM)
                            .numeroCNI(numeroCNI)
                            .dateDelivranceCNI(dateDelivranceCNI)
                            .lieuDelivranceCNI(lieuDelivranceCNI)
                            .villePrincipale(villePrincipale)
                            .regionPrincipale(regionPrincipale)
                            .status(MedecinStatus.EN_ATTENTE)
                            .documentsComplets(false)
                            .documentsValides(false)
                            .build();
                    return medecinRepository.save(medecin).thenReturn(user);
                })
                .flatMap(user -> {
                    log.info("Nouveau médecin inscrit: {} | CNOM: {}", email, numeroCNOM);
                    return buildAuthResponse(user);
                });
    }

    // ─── Connexion ────────────────────────────────────────────────────────────

    public Mono<Map<String, Object>> login(String email, String motDePasse) {
        return authenticationManager
                .authenticate(new UsernamePasswordAuthenticationToken(email, motDePasse))
                .flatMap(auth -> userRepository.findByEmail(email))
                .switchIfEmpty(Mono.error(new BusinessException("Utilisateur introuvable")))
                .flatMap(user -> {
                    user.setDerniereConnexion(LocalDateTime.now());
                    return userRepository.save(user);
                })
                .flatMap(this::buildAuthResponse);
    }

    // ─── Refresh token ────────────────────────────────────────────────────────

    public Mono<Map<String, Object>> refreshToken(String refreshToken) {
        try {
            if (jwtUtils.isTokenExpired(refreshToken)) {
                return Mono.error(new BusinessException("Refresh token expiré"));
            }
            String email = jwtUtils.extractUsername(refreshToken);
            return userDetailsService.findByUsername(email)
                    .filter(ud -> jwtUtils.isTokenValid(refreshToken, ud))
                    .switchIfEmpty(Mono.error(new BusinessException("Refresh token invalide")))
                    .flatMap(ud -> userRepository.findByEmail(email))
                    .flatMap(this::buildAuthResponse);
        } catch (Exception e) {
            return Mono.error(new BusinessException("Refresh token invalide ou expiré"));
        }
    }

    // ─── Mot de passe oublié ──────────────────────────────────────────────────

    public Mono<Void> forgotPassword(String email) {
        return userRepository.findByEmail(email)
                .switchIfEmpty(Mono.error(new BusinessException("Aucun compte avec cet email")))
                .flatMap(user -> {
                    user.setTokenReinitialisation(UUID.randomUUID().toString());
                    user.setTokenReinitExpireAt(LocalDateTime.now().plusHours(2));
                    return userRepository.save(user);
                })
                .doOnNext(u -> log.info("Token réinitialisation généré pour: {}", email))
                .then();
    }

    public Mono<Void> resetPassword(String token, String nouveauMotDePasse) {
        return userRepository.findByTokenReinitialisation(token)
                .switchIfEmpty(Mono.error(new BusinessException("Token invalide ou expiré")))
                .flatMap(user -> {
                    if (user.getTokenReinitExpireAt() == null ||
                            user.getTokenReinitExpireAt().isBefore(LocalDateTime.now())) {
                        return Mono.error(new BusinessException("Ce lien de réinitialisation a expiré"));
                    }
                    user.setMotDePasseHash(passwordEncoder.encode(nouveauMotDePasse));
                    user.setTokenReinitialisation(null);
                    user.setTokenReinitExpireAt(null);
                    return userRepository.save(user);
                })
                .then();
    }

    public Mono<Void> verifyEmail(String token) {
        return userRepository.findByTokenVerificationEmail(token)
                .switchIfEmpty(Mono.error(new BusinessException("Token de vérification invalide")))
                .flatMap(user -> {
                    user.setEmailVerifie(true);
                    user.setTokenVerificationEmail(null);
                    return userRepository.save(user);
                })
                .then();
    }

    // ─── Helpers ─────────────────────────────────────────────────────────────

    private Mono<Map<String, Object>> buildAuthResponse(User user) {
        return userDetailsService.findByUsername(user.getEmail())
                .map(ud -> {
                    Map<String, Object> claims = Map.of(
                            "role", user.getRole().name(),
                            "userId", user.getId().toString(),
                            "matricule", user.getMatricule() != null ? user.getMatricule() : ""
                    );
                    String accessToken = jwtUtils.generateTokenWithClaims(ud, claims);
                    String refreshToken = jwtUtils.generateRefreshToken(ud);

                    Map<String, Object> response = new HashMap<>();
                    response.put("accessToken", accessToken);
                    response.put("refreshToken", refreshToken);
                    response.put("tokenType", "Bearer");
                    response.put("userId", user.getId());
                    response.put("email", user.getEmail());
                    response.put("nomComplet", user.getNomComplet());
                    response.put("role", user.getRole());
                    response.put("matricule", user.getMatricule() != null ? user.getMatricule() : "");
                    response.put("emailVerifie", Boolean.TRUE.equals(user.getEmailVerifie()));
                    return response;
                });
    }
}

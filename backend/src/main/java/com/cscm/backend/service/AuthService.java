package com.cscm.backend.service;

import com.cscm.backend.entity.*;
import com.cscm.backend.enums.UserRole;
import com.cscm.backend.exception.BusinessException;
import com.cscm.backend.exception.ResourceNotFoundException;
import com.cscm.backend.repository.*;
import com.cscm.backend.security.JwtUtils;
import com.cscm.backend.security.CustomUserDetailsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    private final AuthenticationManager authenticationManager;
    private final CustomUserDetailsService userDetailsService;

    @Transactional
    public Map<String, Object> registerPatient(String email, String motDePasse, String nomComplet,
                                                String telephone, java.time.LocalDate dateNaissance,
                                                com.cscm.backend.enums.Genre genre) {
        if (userRepository.existsByEmail(email)) {
            throw new BusinessException("Un compte existe déjà avec cet email");
        }

        User user = User.builder()
                .email(email)
                .motDePasseHash(passwordEncoder.encode(motDePasse))
                .role(UserRole.PATIENT)
                .nomComplet(nomComplet)
                .telephone(telephone)
                .tokenVerificationEmail(UUID.randomUUID().toString())
                .build();
        user = userRepository.save(user);

        String numeroCarnet = genererNumeroCarnet();
        Patient patient = Patient.builder()
                .user(user)
                .numeroCarnet(numeroCarnet)
                .dateNaissance(dateNaissance)
                .genre(genre)
                .build();
        patient = patientRepository.save(patient);

        // Créer le carnet automatiquement
        CarnetMedical carnet = CarnetMedical.builder().patient(patient).build();
        carnetMedicalRepository.save(carnet);

        log.info("Nouveau patient inscrit: {} | Carnet: {}", email, numeroCarnet);
        return generateAuthResponse(user);
    }

    @Transactional
    public Map<String, Object> registerMedecin(String email, String motDePasse, String nomComplet,
                                                 String telephone, String specialite, String numeroOrdre,
                                                 String numeroCarteProfessionnelle) {
        if (userRepository.existsByEmail(email)) {
            throw new BusinessException("Un compte existe déjà avec cet email");
        }

        User user = User.builder()
                .email(email)
                .motDePasseHash(passwordEncoder.encode(motDePasse))
                .role(UserRole.MEDECIN)
                .nomComplet(nomComplet)
                .telephone(telephone)
                .tokenVerificationEmail(UUID.randomUUID().toString())
                .build();
        user = userRepository.save(user);

        Medecin medecin = Medecin.builder()
                .user(user)
                .specialite(specialite)
                .numeroOrdre(numeroOrdre)
                .numeroCarteProfessionnelle(numeroCarteProfessionnelle)
                .build();
        medecinRepository.save(medecin);

        log.info("Nouveau médecin inscrit: {} | Spécialité: {}", email, specialite);
        return generateAuthResponse(user);
    }

    public Map<String, Object> login(String email, String motDePasse) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(email, motDePasse)
        );
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("Utilisateur introuvable"));

        user.setDerniereConnexion(LocalDateTime.now());
        userRepository.save(user);

        return generateAuthResponse(user);
    }

    public Map<String, Object> refreshToken(String refreshToken) {
        try {
            String email = jwtUtils.extractUsername(refreshToken);
            UserDetails userDetails = userDetailsService.loadUserByUsername(email);

            if (jwtUtils.isTokenValid(refreshToken, userDetails)) {
                User user = userRepository.findByEmail(email)
                        .orElseThrow(() -> new ResourceNotFoundException("Utilisateur introuvable"));
                return generateAuthResponse(user);
            }
        } catch (Exception e) {
            throw new BusinessException("Refresh token invalide ou expiré");
        }
        throw new BusinessException("Refresh token invalide");
    }

    @Transactional
    public void logout(String token) {
        String tokenHash = String.valueOf(token.hashCode());
        sessionRepository.findByTokenHash(tokenHash).ifPresent(session -> {
            session.setInvalide(true);
            sessionRepository.save(session);
        });
    }

    @Transactional
    public void forgotPassword(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("Aucun compte avec cet email"));
        user.setTokenReinitialisation(UUID.randomUUID().toString());
        user.setTokenReinitExpireAt(LocalDateTime.now().plusHours(2));
        userRepository.save(user);
        // TODO: Envoyer email avec lien de réinitialisation
        log.info("Token de réinitialisation généré pour: {}", email);
    }

    @Transactional
    public void resetPassword(String token, String nouveauMotDePasse) {
        User user = userRepository.findByTokenReinitialisation(token)
                .orElseThrow(() -> new BusinessException("Token invalide ou expiré"));
        if (user.getTokenReinitExpireAt().isBefore(LocalDateTime.now())) {
            throw new BusinessException("Ce lien de réinitialisation a expiré");
        }
        user.setMotDePasseHash(passwordEncoder.encode(nouveauMotDePasse));
        user.setTokenReinitialisation(null);
        user.setTokenReinitExpireAt(null);
        userRepository.save(user);
    }

    @Transactional
    public void verifyEmail(String token) {
        User user = userRepository.findByTokenVerificationEmail(token)
                .orElseThrow(() -> new BusinessException("Token de vérification invalide"));
        user.setEmailVerifie(true);
        user.setTokenVerificationEmail(null);
        userRepository.save(user);
    }

    private Map<String, Object> generateAuthResponse(User user) {
        UserDetails userDetails = userDetailsService.loadUserByUsername(user.getEmail());
        Map<String, Object> extraClaims = new HashMap<>();
        extraClaims.put("role", user.getRole());
        extraClaims.put("userId", user.getId());

        String accessToken = jwtUtils.generateToken(extraClaims, userDetails);
        String refreshToken = jwtUtils.generateRefreshToken(userDetails);

        Map<String, Object> response = new HashMap<>();
        response.put("accessToken", accessToken);
        response.put("refreshToken", refreshToken);
        response.put("tokenType", "Bearer");
        response.put("userId", user.getId());
        response.put("email", user.getEmail());
        response.put("nomComplet", user.getNomComplet());
        response.put("role", user.getRole());
        response.put("emailVerifie", user.getEmailVerifie());
        return response;
    }

    private String genererNumeroCarnet() {
        int year = java.time.LocalDate.now().getYear();
        String sequence = String.format("%06d", (int)(Math.random() * 999999));
        String candidat = "CM-" + year + "-" + sequence;
        // Vérification unicité (simple retry)
        while (patientRepository.existsByNumeroCarnet(candidat)) {
            sequence = String.format("%06d", (int)(Math.random() * 999999));
            candidat = "CM-" + year + "-" + sequence;
        }
        return candidat;
    }
}

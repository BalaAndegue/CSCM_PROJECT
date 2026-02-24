package com.cscm.backend.controller;

import com.cscm.backend.entity.*;
import com.cscm.backend.enums.MedecinStatus;
import com.cscm.backend.repository.*;
import com.cscm.backend.service.*;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/dashboard")
@RequiredArgsConstructor
@Tag(name = "Dashboard", description = "Données agrégées pour les dashboards par rôle")
public class DashboardController {

    private final UserRepository userRepository;
    private final PatientService patientService;
    private final MedecinService medecinService;
    private final CarnetService carnetService;
    private final ConsultationService consultationService;
    private final AllergieService allergieService;
    private final PatientRepository patientRepository;
    private final MedecinRepository medecinRepository;
    private final ConsultationRepository consultationRepository;
    private final AbonnementRepository abonnementRepository;

    @GetMapping("/patient")
    @Operation(summary = "Dashboard patient – résumé de son carnet")
    public ResponseEntity<ApiResponse<Map<String, Object>>> dashboardPatient(
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Patient patient = patientService.getPatientByUserId(user.getId());
        CarnetMedical carnet = carnetService.getCarnetByPatientId(patient.getId());

        Map<String, Object> data = new HashMap<>();
        data.put("patient", patient);
        data.put("carnet", carnet);
        data.put("nbConsultations", consultationRepository.countByCarnetId(carnet.getId()));
        data.put("allergiesActives", allergieService.getActivesByCarnet(carnet.getId()));
        data.put("dernieresConsultations", consultationService.getDernieresConsultations(carnet.getId())
                .stream().limit(3).toList());
        return ResponseEntity.ok(ApiResponse.success(data));
    }

    @GetMapping("/medecin")
    @Operation(summary = "Dashboard médecin – statistiques et accès patients")
    public ResponseEntity<ApiResponse<Map<String, Object>>> dashboardMedecin(
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Medecin medecin = medecinService.getMedecinByUserId(user.getId());

        Map<String, Object> data = new HashMap<>();
        data.put("medecin", medecin);
        data.put("nbConsultations", consultationRepository.countByMedecinId(medecin.getId()));
        data.put("statut", medecin.getStatus());
        return ResponseEntity.ok(ApiResponse.success(data));
    }

    @GetMapping("/admin")
    @Operation(summary = "Dashboard admin – vue globale de la plateforme")
    public ResponseEntity<ApiResponse<Map<String, Object>>> dashboardAdmin() {
        Map<String, Object> data = new HashMap<>();
        data.put("totalPatients", patientRepository.count());
        data.put("totalMedecins", medecinRepository.count());
        data.put("medecinsPendants", medecinRepository.countByStatus(MedecinStatus.EN_ATTENTE));
        data.put("medecinsValides", medecinRepository.countByStatus(MedecinStatus.VALIDE));
        data.put("abonnementsActifs", abonnementRepository.countByStatut(com.cscm.backend.enums.AbonnementStatut.ACTIF));
        return ResponseEntity.ok(ApiResponse.success(data));
    }

    @GetMapping("/manager")
    @Operation(summary = "Dashboard manager hôpital")
    public ResponseEntity<ApiResponse<Map<String, Object>>> dashboardManager(
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Map<String, Object> data = new HashMap<>();
        data.put("managerId", user.getId());
        data.put("role", user.getRole());
        return ResponseEntity.ok(ApiResponse.success(data));
    }
}

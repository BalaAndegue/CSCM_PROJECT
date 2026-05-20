package com.cscm.backend.controller;

import com.cscm.backend.enums.AbonnementStatut;
import com.cscm.backend.enums.MedecinStatus;
import com.cscm.backend.repository.AbonnementRepository;
import com.cscm.backend.repository.ConsultationRepository;
import com.cscm.backend.repository.MedecinRepository;
import com.cscm.backend.repository.PatientRepository;
import com.cscm.backend.service.AllergieService;
import com.cscm.backend.service.CarnetService;
import com.cscm.backend.service.ConsultationService;
import com.cscm.backend.service.MedecinService;
import com.cscm.backend.service.PatientService;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.Map;

@RestController
@RequestMapping("/dashboard")
@RequiredArgsConstructor
@Tag(name = "Dashboard", description = "Données agrégées pour les dashboards par rôle")
public class DashboardController {

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
    @PreAuthorize("hasRole('PATIENT')")
    @Operation(summary = "Dashboard patient – résumé de son carnet")
    Mono<ResponseEntity<ApiResponse<Map<String, Object>>>> dashboardPatient(
            @AuthenticationPrincipal String userIdStr) {
        return patientService.getPatientByUserId(java.util.UUID.fromString(userIdStr))
                .flatMap(patient -> carnetService.getCarnetByPatientId(patient.getId())
                        .flatMap(carnet -> Mono.zip(
                                consultationRepository.countByCarnetId(carnet.getId()),
                                allergieService.getActivesByCarnet(carnet.getId()).collectList(),
                                consultationService.getDernieresConsultations(carnet.getId()).take(3).collectList()
                        ).map(tuple -> ResponseEntity.ok(ApiResponse.success(Map.of(
                                "patient", patient,
                                "carnet", carnet,
                                "nbConsultations", tuple.getT1(),
                                "allergiesActives", tuple.getT2(),
                                "dernieresConsultations", tuple.getT3()
                        ))))));
    }

    @GetMapping("/medecin")
    @PreAuthorize("hasRole('MEDECIN')")
    @Operation(summary = "Dashboard médecin – statistiques et accès patients")
    Mono<ResponseEntity<ApiResponse<Map<String, Object>>>> dashboardMedecin(
            @AuthenticationPrincipal String userIdStr) {
        return medecinService.getMedecinByUserId(java.util.UUID.fromString(userIdStr))
                .flatMap(medecin -> consultationRepository.countByMedecinId(medecin.getId())
                        .map(nbConsultations -> ResponseEntity.ok(ApiResponse.success(Map.of(
                                "medecin", medecin,
                                "nbConsultations", nbConsultations,
                                "statut", medecin.getStatus()
                        )))));
    }

    @GetMapping("/admin")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Dashboard admin – vue globale de la plateforme")
    Mono<ResponseEntity<ApiResponse<Map<String, Object>>>> dashboardAdmin() {
        return Mono.zip(
                patientRepository.count(),
                medecinRepository.count(),
                medecinRepository.countByStatus(MedecinStatus.EN_ATTENTE),
                medecinRepository.countByStatus(MedecinStatus.VALIDE),
                abonnementRepository.countByStatut(AbonnementStatut.ACTIF)
        ).map(tuple -> ResponseEntity.ok(ApiResponse.success(Map.of(
                "totalPatients", tuple.getT1(),
                "totalMedecins", tuple.getT2(),
                "medecinsPendants", tuple.getT3(),
                "medecinsValides", tuple.getT4(),
                "abonnementsActifs", tuple.getT5()
        ))));
    }

    @GetMapping("/manager")
    @PreAuthorize("hasRole('MANAGER_HOPITAL')")
    @Operation(summary = "Dashboard manager hôpital")
    Mono<ResponseEntity<ApiResponse<Map<String, Object>>>> dashboardManager(
            @AuthenticationPrincipal String userIdStr) {
        return Mono.just(ResponseEntity.ok(ApiResponse.success(Map.of(
                "managerId", userIdStr
        ))));
    }
}

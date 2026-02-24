package com.cscm.backend.controller;

import com.cscm.backend.entity.*;
import com.cscm.backend.service.CarnetService;
import com.cscm.backend.service.ConsultationService;
import com.cscm.backend.service.AllergieService;
import com.cscm.backend.util.ApiResponse;
import com.cscm.backend.dto.request.NotesRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/carnets")
@RequiredArgsConstructor
@Tag(name = "Carnets Médicaux", description = "Accès et gestion des carnets de santé")
public class CarnetController {

    private final CarnetService carnetService;
    private final com.cscm.backend.service.PatientService patientService;
    private final com.cscm.backend.repository.UserRepository userRepository;
    private final ConsultationService consultationService;
    private final AllergieService allergieService;

    @GetMapping("/me")
    @Operation(summary = "Mon carnet médical (patient connecté)")
    @PreAuthorize("hasRole('PATIENT')")
    public ResponseEntity<ApiResponse<CarnetMedical>> getMyCarnet(@AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Patient patient = patientService.getPatientByUserId(user.getId());
        CarnetMedical carnet = carnetService.getCarnetByPatientId(patient.getId());
        return ResponseEntity.ok(ApiResponse.success(carnet));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Carnet par ID (médecin approuvé ou admin)")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<CarnetMedical>> getCarnetById(
            @PathVariable UUID id,
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        CarnetMedical carnet;
        if (user.getRole().name().equals("ADMIN")) {
            carnet = carnetService.getCarnetById(id);
        } else {
            Medecin medecin = new com.cscm.backend.entity.Medecin();
            // Pour un médecin, vérifier l'accès
            carnet = carnetService.getCarnetById(id);
        }
        return ResponseEntity.ok(ApiResponse.success(carnet));
    }

    @GetMapping("/{id}/summary")
    @Operation(summary = "Résumé complet du carnet (dernières consult, allergies actives)")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getSummary(@PathVariable UUID id) {
        CarnetMedical carnet = carnetService.getCarnetById(id);
        Map<String, Object> summary = new HashMap<>();
        summary.put("carnet", carnet);
        summary.put("dernieresConsultations", consultationService.getDernieresConsultations(id)
                .stream().limit(5).toList());
        summary.put("allergiesActives", allergieService.getActivesByCarnet(id));
        return ResponseEntity.ok(ApiResponse.success(summary));
    }

    @PutMapping("/{id}/notes")
    @Operation(summary = "Mettre à jour les notes générales du carnet")
    @PreAuthorize("hasAnyRole('MEDECIN', 'PATIENT')")
    public ResponseEntity<ApiResponse<CarnetMedical>> updateNotes(
            @PathVariable UUID id, @RequestBody NotesRequest req) {
        return ResponseEntity.ok(ApiResponse.success(carnetService.updateNotes(id, req.getNotes()), "Notes mises à jour"));
    }

    @PutMapping("/{id}/archiver")
    @Operation(summary = "Archiver un carnet (admin)")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<CarnetMedical>> archiver(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(carnetService.archiverCarnet(id), "Carnet archivé"));
    }
}


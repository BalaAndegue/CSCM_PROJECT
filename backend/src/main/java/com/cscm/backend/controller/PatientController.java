package com.cscm.backend.controller;

import com.cscm.backend.entity.Patient;
import com.cscm.backend.entity.User;
import com.cscm.backend.service.PatientService;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/patients")
@RequiredArgsConstructor
@Tag(name = "Patients", description = "Gestion des profils patients")
public class PatientController {

    private final PatientService patientService;
    private final com.cscm.backend.repository.UserRepository userRepository;

    @GetMapping("/me")
    @Operation(summary = "Mon profil patient")
    public ResponseEntity<ApiResponse<Patient>> getMyProfile(@AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Patient patient = patientService.getPatientByUserId(user.getId());
        return ResponseEntity.ok(ApiResponse.success(patient));
    }

    @PutMapping("/me")
    @Operation(summary = "Modifier mon profil")
    public ResponseEntity<ApiResponse<Patient>> updateMyProfile(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestBody Patient updates) {
        User user = userRepository.findByEmail(userDetails.getUsername()).orElseThrow();
        Patient patient = patientService.getPatientByUserId(user.getId());
        Patient updated = patientService.updatePatient(patient.getId(), updates);
        return ResponseEntity.ok(ApiResponse.success(updated, "Profil mis à jour"));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Voir un patient par ID")
    @PreAuthorize("hasAnyRole('ADMIN', 'MEDECIN')")
    public ResponseEntity<ApiResponse<Patient>> getPatientById(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(patientService.getPatientById(id)));
    }

    @GetMapping
    @Operation(summary = "Lister tous les patients (admin)")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Page<Patient>>> getAllPatients(
            @RequestParam(required = false) String query,
            @PageableDefault(size = 20, sort = "createdAt") Pageable pageable) {
        Page<Patient> result = (query != null && !query.isBlank())
                ? patientService.searchPatients(query, pageable)
                : patientService.getAllPatients(pageable);
        return ResponseEntity.ok(ApiResponse.success(result));
    }

    @GetMapping("/carnet/{numeroCarnet}")
    @Operation(summary = "Trouver un patient par numéro de carnet")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<Patient>> getByNumeroCarnet(@PathVariable String numeroCarnet) {
        return ResponseEntity.ok(ApiResponse.success(patientService.getPatientByNumeroCarnet(numeroCarnet)));
    }
}

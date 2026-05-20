package com.cscm.backend.controller;

import com.cscm.backend.dto.request.NotesRequest;
import com.cscm.backend.service.AllergieService;
import com.cscm.backend.service.CarnetService;
import com.cscm.backend.service.ConsultationService;
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
import java.util.UUID;

@RestController
@RequestMapping("/carnets")
@RequiredArgsConstructor
@Tag(name = "Carnets Médicaux", description = "Accès et gestion des carnets de santé")
public class CarnetController {

    private final CarnetService carnetService;
    private final PatientService patientService;
    private final ConsultationService consultationService;
    private final AllergieService allergieService;

    @GetMapping("/me")
    @PreAuthorize("hasRole('PATIENT')")
    @Operation(summary = "Mon carnet médical")
    Mono<ResponseEntity<ApiResponse<?>>> getMyCarnet(@AuthenticationPrincipal String userIdStr) {
        return patientService.getPatientByUserId(UUID.fromString(userIdStr))
                .flatMap(patient -> carnetService.getCarnetByPatientId(patient.getId()))
                .map(carnet -> ResponseEntity.ok(ApiResponse.success(carnet)));
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('MEDECIN', 'ADMIN')")
    @Operation(summary = "Carnet par ID – médecin approuvé ou admin")
    Mono<ResponseEntity<ApiResponse<?>>> getCarnetById(@PathVariable UUID id) {
        return carnetService.getCarnetById(id)
                .map(carnet -> ResponseEntity.ok(ApiResponse.success(carnet)));
    }

    @GetMapping("/{id}/summary")
    @Operation(summary = "Résumé complet: dernières consult + allergies actives")
    Mono<ResponseEntity<ApiResponse<Map<String, Object>>>> getSummary(@PathVariable UUID id) {
        return Mono.zip(
                carnetService.getCarnetById(id),
                consultationService.getDernieresConsultations(id).take(5).collectList(),
                allergieService.getActivesByCarnet(id).collectList()
        ).map(tuple -> ResponseEntity.ok(ApiResponse.success(Map.of(
                "carnet", tuple.getT1(),
                "dernieresConsultations", tuple.getT2(),
                "allergiesActives", tuple.getT3()
        ))));
    }

    @PutMapping("/{id}/notes")
    @PreAuthorize("hasAnyRole('MEDECIN', 'PATIENT')")
    @Operation(summary = "Mettre à jour les notes générales")
    Mono<ResponseEntity<ApiResponse<?>>> updateNotes(
            @PathVariable UUID id,
            @RequestBody NotesRequest req) {
        return carnetService.updateNotes(id, req.getNotes())
                .map(c -> ResponseEntity.ok(ApiResponse.success(c, "Notes mises à jour")));
    }

    @PutMapping("/{id}/archiver")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Archiver un carnet (admin)")
    Mono<ResponseEntity<ApiResponse<?>>> archiver(@PathVariable UUID id) {
        return carnetService.archiverCarnet(id)
                .map(c -> ResponseEntity.ok(ApiResponse.success(c, "Carnet archivé")));
    }
}

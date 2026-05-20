package com.cscm.backend.controller;

import com.cscm.backend.service.NotificationService;
import com.cscm.backend.util.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.codec.ServerSentEvent;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

@RestController
@RequestMapping("/notifications")
@RequiredArgsConstructor
@Tag(name = "Notifications", description = "Flux SSE temps réel + lecture")
public class NotificationController {

    private final NotificationService notificationService;

    @GetMapping(value = "/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(summary = "SSE – Flux de notifications en temps réel")
    Flux<ServerSentEvent<String>> stream(@AuthenticationPrincipal String userIdStr) {
        return notificationService.streamPourUtilisateur(UUID.fromString(userIdStr));
    }

    @GetMapping
    @Operation(summary = "Toutes les notifications de l'utilisateur connecté")
    Mono<ResponseEntity<ApiResponse<?>>> getAll(@AuthenticationPrincipal String userIdStr) {
        return notificationService.getNotificationsUtilisateur(UUID.fromString(userIdStr))
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/non-lues")
    @Operation(summary = "Notifications non lues")
    Mono<ResponseEntity<ApiResponse<?>>> getNonLues(@AuthenticationPrincipal String userIdStr) {
        return notificationService.getNotificationsNonLues(UUID.fromString(userIdStr))
                .collectList()
                .map(list -> ResponseEntity.ok(ApiResponse.success(list)));
    }

    @GetMapping("/count")
    @Operation(summary = "Nombre de notifications non lues")
    Mono<ResponseEntity<ApiResponse<Long>>> countNonLues(@AuthenticationPrincipal String userIdStr) {
        return notificationService.compterNonLues(UUID.fromString(userIdStr))
                .map(count -> ResponseEntity.ok(ApiResponse.success(count)));
    }

    @PutMapping("/{id}/lue")
    @Operation(summary = "Marquer une notification comme lue")
    Mono<ResponseEntity<ApiResponse<Void>>> marquerLue(@PathVariable UUID id) {
        return notificationService.marquerCommeLue(id)
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Notification marquée comme lue")));
    }

    @PutMapping("/lues/toutes")
    @Operation(summary = "Marquer toutes les notifications comme lues")
    Mono<ResponseEntity<ApiResponse<Void>>> marquerToutesLues(@AuthenticationPrincipal String userIdStr) {
        return notificationService.marquerToutesCommeLues(UUID.fromString(userIdStr))
                .thenReturn(ResponseEntity.ok(ApiResponse.ok("Toutes les notifications marquées comme lues")));
    }
}

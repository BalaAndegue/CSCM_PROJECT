package com.cscm.backend.exception;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.reactive.error.ErrorWebExceptionHandler;
import org.springframework.core.annotation.Order;
import org.springframework.core.io.buffer.DataBufferFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Map;

@Component
@Order(-2)
@RequiredArgsConstructor
@Slf4j
public class GlobalErrorWebExceptionHandler implements ErrorWebExceptionHandler {

    private final ObjectMapper objectMapper;

    @Override
    public Mono<Void> handle(ServerWebExchange exchange, Throwable ex) {
        HttpStatus status;
        String message;

        if (ex instanceof BusinessException) {
            status = HttpStatus.BAD_REQUEST;
            message = ex.getMessage();
        } else if (ex instanceof ResourceNotFoundException) {
            status = HttpStatus.NOT_FOUND;
            message = ex.getMessage();
        } else if (ex instanceof BadCredentialsException) {
            status = HttpStatus.UNAUTHORIZED;
            message = "Email ou mot de passe incorrect";
        } else if (ex instanceof AuthenticationException) {
            status = HttpStatus.UNAUTHORIZED;
            message = "Authentification requise";
        } else if (ex instanceof AccessDeniedException) {
            status = HttpStatus.FORBIDDEN;
            message = "Accès refusé";
        } else if (ex instanceof ResponseStatusException rse) {
            status = HttpStatus.valueOf(rse.getStatusCode().value());
            message = rse.getReason() != null ? rse.getReason() : rse.getMessage();
        } else {
            status = HttpStatus.INTERNAL_SERVER_ERROR;
            message = "Une erreur interne est survenue";
            log.error("Erreur non gérée: {}", ex.getMessage(), ex);
        }

        exchange.getResponse().setStatusCode(status);
        exchange.getResponse().getHeaders().setContentType(MediaType.APPLICATION_JSON);

        Map<String, Object> errorBody = Map.of(
                "success", false,
                "message", message,
                "status", status.value(),
                "path", exchange.getRequest().getPath().value()
        );

        DataBufferFactory bufferFactory = exchange.getResponse().bufferFactory();
        try {
            byte[] bytes = objectMapper.writeValueAsBytes(errorBody);
            return exchange.getResponse().writeWith(
                    Mono.just(bufferFactory.wrap(bytes))
            );
        } catch (JsonProcessingException e) {
            return exchange.getResponse().writeWith(
                    Mono.just(bufferFactory.wrap("{\"success\":false,\"message\":\"Erreur interne\"}".getBytes()))
            );
        }
    }
}

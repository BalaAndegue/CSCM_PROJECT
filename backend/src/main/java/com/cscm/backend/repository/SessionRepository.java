package com.cscm.backend.repository;

import com.cscm.backend.entity.Session;
import org.springframework.data.r2dbc.repository.Modifying;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.UUID;

public interface SessionRepository extends R2dbcRepository<Session, UUID> {

    Mono<Session> findByTokenHash(String tokenHash);
    Mono<Session> findByRefreshTokenHash(String refreshTokenHash);

    @Modifying
    @Query("UPDATE sessions SET invalide = TRUE WHERE user_id = :userId AND invalide = FALSE")
    Mono<Integer> invalidateAllUserSessions(UUID userId);

    @Modifying
    @Query("DELETE FROM sessions WHERE expire_at < :now OR invalide = TRUE")
    Mono<Integer> deleteExpiredSessions(LocalDateTime now);
}

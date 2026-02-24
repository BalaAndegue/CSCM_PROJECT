package com.cscm.backend.repository;

import com.cscm.backend.entity.Session;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface SessionRepository extends JpaRepository<Session, UUID> {
    Optional<Session> findByTokenHash(String tokenHash);
    Optional<Session> findByRefreshTokenHash(String refreshTokenHash);

    @Modifying
    @Query("UPDATE Session s SET s.invalide = true WHERE s.user.id = :userId")
    void invalidateAllUserSessions(UUID userId);

    @Modifying
    @Query("DELETE FROM Session s WHERE s.expireAt < :now OR s.invalide = true")
    void deleteExpiredSessions(LocalDateTime now);
}

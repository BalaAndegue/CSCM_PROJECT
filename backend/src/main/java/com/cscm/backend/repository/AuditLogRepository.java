package com.cscm.backend.repository;

import com.cscm.backend.entity.AuditLog;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

import java.util.UUID;

public interface AuditLogRepository extends R2dbcRepository<AuditLog, Long> {

    @Query("SELECT * FROM audit_logs ORDER BY created_at DESC LIMIT :size OFFSET :offset")
    Flux<AuditLog> findAllPaged(int size, long offset);

    @Query("SELECT * FROM audit_logs WHERE user_id = :userId ORDER BY created_at DESC LIMIT :size OFFSET :offset")
    Flux<AuditLog> findByUserId(UUID userId, int size, long offset);

    @Query("SELECT * FROM audit_logs WHERE entite_type = :entiteType AND entite_id = :entiteId ORDER BY created_at DESC LIMIT :size OFFSET :offset")
    Flux<AuditLog> findByEntiteTypAndEntiteId(String entiteType, UUID entiteId, int size, long offset);

    @Query("SELECT * FROM audit_logs WHERE action = :action ORDER BY created_at DESC LIMIT :size OFFSET :offset")
    Flux<AuditLog> findByAction(String action, int size, long offset);
}

package com.cscm.backend.repository;

import com.cscm.backend.entity.AuditLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface AuditLogRepository extends JpaRepository<AuditLog, Long> {
    Page<AuditLog> findByUserId(UUID userId, Pageable pageable);
    Page<AuditLog> findByEntiteTypeAndEntiteId(String entiteType, UUID entiteId, Pageable pageable);
    Page<AuditLog> findByAction(String action, Pageable pageable);
}

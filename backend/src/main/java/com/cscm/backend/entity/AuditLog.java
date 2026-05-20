package com.cscm.backend.entity;

import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

@Table("audit_logs")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class AuditLog {

    @Id
    private Long id;

    @Column("user_id")
    private UUID userId;

    @Column("user_email")
    private String userEmail;

    @Column("user_role")
    private String userRole;

    @Column("action")
    private String action;

    @Column("entite_type")
    private String entiteType;

    @Column("entite_id")
    private UUID entiteId;

    /** Valeur avant modification (JSON texte) */
    @Column("ancien_valeur")
    private String ancienValeurJson;

    /** Valeur après modification (JSON texte) */
    @Column("nouvelle_valeur")
    private String nouvelleValeurJson;

    @Column("ip_address")
    private String ipAddress;

    @Column("user_agent")
    private String userAgent;

    @Column("description")
    private String description;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

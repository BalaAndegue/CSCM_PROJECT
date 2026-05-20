package com.cscm.backend.entity;

import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

@Table("sessions")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Session {

    @Id
    private UUID id;

    /** FK → users.id */
    @Column("user_id")
    private UUID userId;

    @Column("token_hash")
    private String tokenHash;

    @Column("refresh_token_hash")
    private String refreshTokenHash;

    @Column("expire_at")
    private LocalDateTime expireAt;

    @Column("refresh_expire_at")
    private LocalDateTime refreshExpireAt;

    @Column("derniere_activite")
    private LocalDateTime derniereActivite;

    @Column("appareil")
    private String appareil;

    @Column("ip_address")
    private String ipAddress;

    @Builder.Default
    @Column("invalide")
    private Boolean invalide = false;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;
}

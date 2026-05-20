package com.cscm.backend.entity;

import com.cscm.backend.enums.UserRole;
import lombok.*;
import org.springframework.data.annotation.*;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;
import java.util.UUID;

@Table("users")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class User {

    @Id
    private UUID id;

    @Column("email")
    private String email;

    @Column("mot_de_passe_hash")
    private String motDePasseHash;

    @Column("role")
    private UserRole role;

    @Column("nom_complet")
    private String nomComplet;

    @Column("telephone")
    private String telephone;

    /** Matricule unique CSCM (ex: CSCM-PAT-2024-000001) */
    @Column("matricule")
    private String matricule;

    @Column("email_verifie")
    @Builder.Default
    private Boolean emailVerifie = false;

    @Column("telephone_verifie")
    @Builder.Default
    private Boolean telephoneVerifie = false;

    @Column("deux_facteurs")
    @Builder.Default
    private Boolean deuxFacteurs = false;

    @Column("deux_facteurs_secret")
    private String deuxFacteursSecret;

    @Column("compte_actif")
    @Builder.Default
    private Boolean compteActif = true;

    @Column("derniere_connexion")
    private LocalDateTime derniereConnexion;

    @Column("token_reinitialisation")
    private String tokenReinitialisation;

    @Column("token_reinit_expire_at")
    private LocalDateTime tokenReinitExpireAt;

    @Column("token_verification_email")
    private String tokenVerificationEmail;

    /** Token FCM (Firebase Cloud Messaging) pour push notifications Android */
    @Column("fcm_token")
    private String fcmToken;

    @CreatedDate
    @Column("created_at")
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column("updated_at")
    private LocalDateTime updatedAt;
}

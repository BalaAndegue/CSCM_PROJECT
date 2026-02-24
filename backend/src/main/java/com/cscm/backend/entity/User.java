package com.cscm.backend.entity;

import com.cscm.backend.enums.UserRole;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "users")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(unique = true, nullable = false, length = 255)
    private String email;

    @Column(name = "mot_de_passe_hash", nullable = false)
    private String motDePasseHash;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private UserRole role;

    @Column(name = "nom_complet", nullable = false, length = 255)
    private String nomComplet;

    @Column(length = 20)
    private String telephone;

    @Column(name = "email_verifie")
    @Builder.Default
    private Boolean emailVerifie = false;

    @Column(name = "telephone_verifie")
    @Builder.Default
    private Boolean telephoneVerifie = false;

    @Column(name = "deux_facteurs")
    @Builder.Default
    private Boolean deuxFacteurs = false;

    @Column(name = "deux_facteurs_secret")
    private String deuxFacteursSecret;

    @Column(name = "compte_actif")
    @Builder.Default
    private Boolean compteActif = true;

    @Column(name = "derniere_connexion")
    private LocalDateTime derniereConnexion;

    @Column(name = "token_reinitialisation")
    private String tokenReinitialisation;

    @Column(name = "token_reinit_expire_at")
    private LocalDateTime tokenReinitExpireAt;

    @Column(name = "token_verification_email")
    private String tokenVerificationEmail;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}

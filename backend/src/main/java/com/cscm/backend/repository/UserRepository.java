package com.cscm.backend.repository;

import com.cscm.backend.entity.User;
import com.cscm.backend.enums.UserRole;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface UserRepository extends R2dbcRepository<User, UUID> {

    Mono<User> findByEmail(String email);
    Mono<Boolean> existsByEmail(String email);
    Mono<User> findByMatricule(String matricule);
    Mono<User> findByTokenReinitialisation(String token);
    Mono<User> findByTokenVerificationEmail(String token);
    Flux<User> findByRole(UserRole role);
    Mono<Long> countByRole(UserRole role);

    @Query("SELECT * FROM users WHERE role = :role AND compte_actif = TRUE ORDER BY created_at DESC LIMIT :size OFFSET :offset")
    Flux<User> findActiveByRolePaged(String role, int size, long offset);

    @Query("SELECT nextval('seq_matricule_admin')")
    Mono<Long> nextMatriculeSequence();
}

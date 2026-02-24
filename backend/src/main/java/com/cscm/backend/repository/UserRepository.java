package com.cscm.backend.repository;

import com.cscm.backend.entity.User;
import com.cscm.backend.enums.UserRole;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {
    Optional<User> findByEmail(String email);
    boolean existsByEmail(String email);
    Optional<User> findByTokenReinitialisation(String token);
    Optional<User> findByTokenVerificationEmail(String token);
    Page<User> findByRole(UserRole role, Pageable pageable);
    long countByRole(UserRole role);
}

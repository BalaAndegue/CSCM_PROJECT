package com.cscm.backend.security;

import com.cscm.backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.ReactiveUserDetailsService;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements ReactiveUserDetailsService {

    private final UserRepository userRepository;

    @Override
    public Mono<UserDetails> findByUsername(String email) {
        return userRepository.findByEmail(email)
                .map(user -> (UserDetails) User.builder()
                        .username(user.getEmail())
                        .password(user.getMotDePasseHash())
                        .authorities(List.of(new SimpleGrantedAuthority("ROLE_" + user.getRole().name())))
                        .accountLocked(!user.getCompteActif())
                        .disabled(!user.getCompteActif())
                        .build())
                .switchIfEmpty(Mono.error(new UsernameNotFoundException("Utilisateur introuvable: " + email)));
    }
}

package com.cscm.backend.aspect;

import com.cscm.backend.entity.AuditLog;
import com.cscm.backend.repository.AuditLogRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.security.core.context.ReactiveSecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Mono;

import java.util.Set;
import java.util.UUID;

@Component
@RequiredArgsConstructor
@Slf4j
public class AuditAspect implements WebFilter {

    private static final Set<HttpMethod> MUTABLE_METHODS = Set.of(
            HttpMethod.POST, HttpMethod.PUT, HttpMethod.DELETE, HttpMethod.PATCH);

    private final AuditLogRepository auditLogRepository;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, WebFilterChain chain) {
        HttpMethod method = exchange.getRequest().getMethod();
        if (!MUTABLE_METHODS.contains(method)) {
            return chain.filter(exchange);
        }

        String path = exchange.getRequest().getPath().value();
        String ipAddress = exchange.getRequest().getRemoteAddress() != null
                ? exchange.getRequest().getRemoteAddress().getAddress().getHostAddress() : "unknown";
        String userAgent = exchange.getRequest().getHeaders().getFirst("User-Agent");

        return chain.filter(exchange)
                .then(ReactiveSecurityContextHolder.getContext()
                        .filter(ctx -> ctx.getAuthentication() != null
                                && ctx.getAuthentication().isAuthenticated()
                                && !ctx.getAuthentication().getPrincipal().equals("anonymousUser"))
                        .flatMap(ctx -> {
                            var auth = ctx.getAuthentication();
                            String principal = auth.getPrincipal().toString();
                            UUID userId = null;
                            try { userId = UUID.fromString(principal); } catch (Exception ignored) {}

                            String role = auth.getAuthorities().stream()
                                    .findFirst()
                                    .map(a -> a.getAuthority().replace("ROLE_", ""))
                                    .orElse("UNKNOWN");

                            AuditLog auditLog = AuditLog.builder()
                                    .userId(userId)
                                    .userEmail(principal)
                                    .userRole(role)
                                    .action(method.name() + " " + path)
                                    .description("Reactive request")
                                    .ipAddress(ipAddress)
                                    .userAgent(userAgent)
                                    .build();

                            return auditLogRepository.save(auditLog)
                                    .doOnSuccess(s -> log.debug("Audit: {} {} by {}", method, path, principal))
                                    .doOnError(e -> log.error("Audit save failed: {}", e.getMessage()))
                                    .onErrorResume(e -> Mono.empty());
                        })
                        .onErrorResume(e -> Mono.empty())
                        .then());
    }
}

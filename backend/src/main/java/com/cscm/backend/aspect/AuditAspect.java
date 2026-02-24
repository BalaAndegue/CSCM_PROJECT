package com.cscm.backend.aspect;

import com.cscm.backend.entity.AuditLog;
import com.cscm.backend.entity.User;
import com.cscm.backend.repository.AuditLogRepository;
import com.cscm.backend.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Aspect
@Component
@RequiredArgsConstructor
@Slf4j
public class AuditAspect {

    private final AuditLogRepository auditLogRepository;
    private final UserRepository userRepository;

    @Pointcut("@annotation(org.springframework.web.bind.annotation.PostMapping) || " +
              "@annotation(org.springframework.web.bind.annotation.PutMapping) || " +
              "@annotation(org.springframework.web.bind.annotation.DeleteMapping)")
    public void mutableEndpoint() {}

    @AfterReturning(pointcut = "mutableEndpoint()", returning = "result")
    public void logAuditActivity(JoinPoint joinPoint, Object result) {
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth == null || !auth.isAuthenticated() || auth.getPrincipal().equals("anonymousUser")) {
                return; // Ne pas auditer les actions non authentifiées via cet aspect (ex: login/register)
            }

            String email = ((UserDetails) auth.getPrincipal()).getUsername();
            User user = userRepository.findByEmail(email).orElse(null);

            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

            String methodName = joinPoint.getSignature().getName();
            String className = joinPoint.getTarget().getClass().getSimpleName();
            String action = request.getMethod() + " " + request.getRequestURI();

            AuditLog auditLog = AuditLog.builder()
                    .userId(user != null ? user.getId() : null)
                    .userEmail(email)
                    .userRole(user != null ? user.getRole().name() : "UNKNOWN")
                    .action(action)
                    .description("Method: " + className + "." + methodName)
                    .ipAddress(request.getRemoteAddr())
                    .userAgent(request.getHeader("User-Agent"))
                    .build();

            auditLogRepository.save(auditLog);
            log.debug("Audit record created for user: {} action: {}", email, action);

        } catch (Exception e) {
            log.error("Failed to save audit log: {}", e.getMessage());
        }
    }
}

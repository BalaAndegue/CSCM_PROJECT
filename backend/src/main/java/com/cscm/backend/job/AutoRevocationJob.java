package com.cscm.backend.job;

import com.cscm.backend.repository.ApprobationMedecinRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
@Slf4j
public class AutoRevocationJob {

    private final ApprobationMedecinRepository approbationRepository;

    /**
     * Runs every hour to check for expired approbations and revoke them.
     */
    @Scheduled(cron = "0 0 * * * *")
    @Transactional
    public void revokeExpiredApprobations() {
        log.info("Running AutoRevocationJob to check for expired doctor access approvals...");
        
        LocalDateTime now = LocalDateTime.now();
        int revokedCount = approbationRepository.revokeExpiredApprobations(now);
        
        if (revokedCount > 0) {
            log.info("AutoRevocationJob successfully revoked {} expired doctor approvals.", revokedCount);
        } else {
            log.debug("No expired approbations found at this time.");
        }
    }
}

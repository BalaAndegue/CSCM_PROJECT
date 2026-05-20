package com.cscm.backend.job;

import com.cscm.backend.repository.ApprobationMedecinRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
@Slf4j
public class AutoRevocationJob {

    private final ApprobationMedecinRepository approbationRepository;

    @Scheduled(cron = "0 0 * * * *")
    public void revokeExpiredApprobations() {
        log.info("AutoRevocationJob: checking for expired doctor access approvals...");
        approbationRepository.revokeExpiredApprobations(LocalDateTime.now())
                .subscribe(
                        count -> {
                            if (count > 0) log.info("AutoRevocationJob: revoked {} expired approvals.", count);
                            else log.debug("AutoRevocationJob: no expired approvals found.");
                        },
                        err -> log.error("AutoRevocationJob failed: {}", err.getMessage())
                );
    }
}

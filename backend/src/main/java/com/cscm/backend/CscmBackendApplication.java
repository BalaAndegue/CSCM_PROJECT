package com.cscm.backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.r2dbc.config.EnableR2dbcAuditing;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
@EnableR2dbcAuditing
public class CscmBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(CscmBackendApplication.class, args);
    }
}

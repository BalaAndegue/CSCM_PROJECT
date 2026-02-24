package com.cscm.backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class CscmBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(CscmBackendApplication.class, args);
    }
}

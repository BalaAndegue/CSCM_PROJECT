package com.cscm.backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;
import com.fasterxml.jackson.datatype.hibernate6.Hibernate6Module;

@SpringBootApplication
@EnableScheduling
public class CscmBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(CscmBackendApplication.class, args);
    }

    @Bean
    public Hibernate6Module hibernate6Module() {
        return new Hibernate6Module();
    }
}

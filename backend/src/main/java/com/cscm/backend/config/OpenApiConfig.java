package com.cscm.backend.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("CSCM API – Carnet de Santé Connecté et Mobile")
                        .version("1.0.0")
                        .description("""
                                API REST complète pour la gestion des carnets de santé numériques.
                                
                                **Rôles disponibles:**
                                - `PATIENT` – Accès à son carnet, allergies, ordonnances
                                - `MEDECIN` – Consultations, examens, ordonnances (après approbation patient)
                                - `MANAGER_HOPITAL` – Gestion de l'hôpital et validation consents
                                - `ADMIN` – Accès complet à la plateforme
                                
                                **Authentification:** JWT Bearer Token
                                """)
                        .contact(new Contact().name("CSCM Team").email("contact@cscm.app"))
                        .license(new License().name("Proprietary")))
                .addSecurityItem(new SecurityRequirement().addList("Bearer Authentication"))
                .components(new Components()
                        .addSecuritySchemes("Bearer Authentication",
                                new SecurityScheme()
                                        .type(SecurityScheme.Type.HTTP)
                                        .scheme("bearer")
                                        .bearerFormat("JWT")
                                        .description("Entrez votre token JWT – obtenu via POST /api/auth/login")));
    }
}

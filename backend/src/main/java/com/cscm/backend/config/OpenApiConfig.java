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
                        .version("2.0.0")
                        .description("""
                                API réactive (Spring WebFlux + R2DBC) pour la gestion des carnets de santé numériques au Cameroun.

                                **Rôles disponibles :**
                                - `PATIENT` – Accès à son carnet, allergies, ordonnances, examens
                                - `MEDECIN` – Consultations, ordonnances, examens (après approbation QR/code patient)
                                - `MANAGER_HOPITAL` – Gestion hôpital, validation des consentements diagnostics
                                - `ADMIN` – Validation CNOM médecins, accès complet à la plateforme

                                **Authentification :** JWT Bearer Token — obtenu via `POST /api/auth/login`

                                **Accès au carnet :** QR code ou code à 6 chiffres généré par le patient
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

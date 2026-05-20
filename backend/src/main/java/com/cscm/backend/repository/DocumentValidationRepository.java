package com.cscm.backend.repository;

import com.cscm.backend.entity.DocumentValidation;
import com.cscm.backend.enums.StatutDocument;
import com.cscm.backend.enums.TypeDocumentValidation;
import org.springframework.data.r2dbc.repository.Modifying;
import org.springframework.data.r2dbc.repository.Query;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

public interface DocumentValidationRepository extends R2dbcRepository<DocumentValidation, UUID> {

    Flux<DocumentValidation> findByProprietaireIdAndProprietaireType(UUID proprietaireId, String proprietaireType);
    Mono<DocumentValidation> findByProprietaireIdAndTypeDocument(UUID proprietaireId, TypeDocumentValidation typeDocument);
    Flux<DocumentValidation> findByStatut(StatutDocument statut);

    @Query("SELECT COUNT(*) FROM documents_validation WHERE proprietaire_id = :id AND proprietaire_type = :type AND statut = 'VALIDE'")
    Mono<Long> countValidesForProprietaire(UUID id, String type);

    @Query("SELECT COUNT(*) FROM documents_validation WHERE proprietaire_id = :id AND proprietaire_type = :type AND statut NOT IN ('VALIDE','EXPIRE')")
    Mono<Long> countNonValidesForProprietaire(UUID id, String type);

    @Query("SELECT * FROM documents_validation WHERE statut = 'UPLOADE' ORDER BY created_at ASC LIMIT :size OFFSET :offset")
    Flux<DocumentValidation> findEnAttenteVerification(int size, long offset);

    @Query("SELECT * FROM documents_validation WHERE date_expiration_document < CURRENT_DATE + INTERVAL '30 days' AND statut = 'VALIDE'")
    Flux<DocumentValidation> findExpirantBientot();
}

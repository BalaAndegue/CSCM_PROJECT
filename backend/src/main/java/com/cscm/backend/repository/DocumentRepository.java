package com.cscm.backend.repository;

import com.cscm.backend.entity.Document;
import org.springframework.data.r2dbc.repository.R2dbcRepository;
import reactor.core.publisher.Flux;

import java.util.UUID;

/** @deprecated Utiliser MediaFichierRepository à la place */
@Deprecated
public interface DocumentRepository extends R2dbcRepository<Document, UUID> {

    Flux<Document> findByCarnetIdAndActifTrue(UUID carnetId);
    Flux<Document> findByEntiteTypeAndEntiteId(String entiteType, UUID entiteId);
    Flux<Document> findByUploadedByAndActifTrue(UUID uploadedBy);
}

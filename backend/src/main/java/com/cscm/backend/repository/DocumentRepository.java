package com.cscm.backend.repository;

import com.cscm.backend.entity.Document;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface DocumentRepository extends JpaRepository<Document, UUID> {
    Page<Document> findByCarnetIdAndActifTrue(UUID carnetId, Pageable pageable);
    List<Document> findByEntiteTypeAndEntiteId(String entiteType, UUID entiteId);
    List<Document> findByUploadedByAndActifTrue(UUID uploadedBy);
}

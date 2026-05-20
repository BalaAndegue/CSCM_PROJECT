package com.cscm.backend.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.codec.multipart.FilePart;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.util.HexFormat;
import java.util.UUID;

@Service
@Slf4j
public class FileStorageService {

    private final Path storageRoot;

    public FileStorageService(@Value("${app.storage.root-path:./uploads}") String rootPath) {
        this.storageRoot = Paths.get(rootPath).toAbsolutePath().normalize();
        try {
            Files.createDirectories(storageRoot);
        } catch (IOException e) {
            throw new IllegalStateException("Impossible de créer le répertoire de stockage: " + rootPath, e);
        }
    }

    public Mono<StorageResult> store(FilePart filePart, String subDirectory) {
        String originalName = filePart.filename();
        String extension = extractExtension(originalName);
        String nomStockage = UUID.randomUUID() + (extension.isEmpty() ? "" : "." + extension);

        Path targetDir = storageRoot.resolve(subDirectory);
        Path targetPath = targetDir.resolve(nomStockage);

        return Mono.fromCallable(() -> Files.createDirectories(targetDir))
                .subscribeOn(Schedulers.boundedElastic())
                .then(filePart.transferTo(targetPath))
                .then(Mono.fromCallable(() -> {
                    long taille = Files.size(targetPath);
                    String checksum = sha256(targetPath);
                    String chemin = subDirectory + "/" + nomStockage;
                    return new StorageResult(nomStockage, chemin, taille, checksum);
                }).subscribeOn(Schedulers.boundedElastic()));
    }

    public Mono<Resource> load(String cheminStockage) {
        return Mono.fromCallable(() -> {
            Path filePath = storageRoot.resolve(cheminStockage).normalize();
            Resource resource = new UrlResource(filePath.toUri());
            if (!resource.exists() || !resource.isReadable()) {
                throw new IllegalArgumentException("Fichier introuvable ou illisible: " + cheminStockage);
            }
            return resource;
        }).subscribeOn(Schedulers.boundedElastic());
    }

    public Mono<Void> delete(String cheminStockage) {
        return Mono.fromRunnable(() -> {
            try {
                Path filePath = storageRoot.resolve(cheminStockage).normalize();
                Files.deleteIfExists(filePath);
            } catch (IOException e) {
                log.warn("Impossible de supprimer le fichier: {}", cheminStockage, e);
            }
        }).subscribeOn(Schedulers.boundedElastic()).then();
    }

    private String extractExtension(String filename) {
        if (filename == null || !filename.contains(".")) return "";
        return filename.substring(filename.lastIndexOf('.') + 1).toLowerCase();
    }

    private String sha256(Path path) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        try (InputStream is = Files.newInputStream(path)) {
            byte[] buffer = new byte[8192];
            int read;
            while ((read = is.read(buffer)) != -1) {
                digest.update(buffer, 0, read);
            }
        }
        return HexFormat.of().formatHex(digest.digest());
    }

    public record StorageResult(String nomStockage, String cheminStockage, long tailleFichier, String checksum) {}
}

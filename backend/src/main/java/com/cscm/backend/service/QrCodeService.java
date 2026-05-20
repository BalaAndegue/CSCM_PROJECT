package com.cscm.backend.service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

import javax.crypto.SecretKey;
import java.io.ByteArrayOutputStream;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Service
@Slf4j
public class QrCodeService {

    @Value("${app.qrcode.secret}")
    private String qrSecret;

    @Value("${app.qrcode.expiry-minutes:15}")
    private int expiryMinutes;

    private static final int QR_SIZE = 300;

    private SecretKey getQrKey() {
        byte[] keyBytes = Decoders.BASE64.decode(
                java.util.Base64.getEncoder().encodeToString(qrSecret.getBytes())
        );
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public String genererPayloadJwt(UUID carnetId, UUID patientId, UUID tokenAccesId) {
        return Jwts.builder()
                .subject(carnetId.toString())
                .claim("patientId", patientId.toString())
                .claim("tokenId", tokenAccesId.toString())
                .claim("type", "QR_ACCES_CARNET")
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + (long) expiryMinutes * 60 * 1000))
                .signWith(getQrKey())
                .compact();
    }

    public Mono<byte[]> genererQrCodePng(String payload) {
        return Mono.fromCallable(() -> {
            QRCodeWriter writer = new QRCodeWriter();
            Map<EncodeHintType, Object> hints = Map.of(
                    EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M,
                    EncodeHintType.CHARACTER_SET, "UTF-8",
                    EncodeHintType.MARGIN, 1
            );
            BitMatrix matrix = writer.encode(payload, BarcodeFormat.QR_CODE, QR_SIZE, QR_SIZE, hints);
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(matrix, "PNG", out);
            return out.toByteArray();
        }).subscribeOn(Schedulers.boundedElastic())
                .doOnError(e -> log.error("Erreur génération QR code: {}", e.getMessage()));
    }

    public Claims validerEtExtrairePayload(String jwt) {
        return Jwts.parser()
                .verifyWith(getQrKey())
                .build()
                .parseSignedClaims(jwt)
                .getPayload();
    }

    public boolean estValide(String jwt) {
        try {
            Claims claims = validerEtExtrairePayload(jwt);
            return claims.getExpiration().after(new Date())
                    && "QR_ACCES_CARNET".equals(claims.get("type", String.class));
        } catch (Exception e) {
            return false;
        }
    }

    public UUID extraireCarnetId(String jwt) {
        return UUID.fromString(validerEtExtrairePayload(jwt).getSubject());
    }

    public UUID extraireTokenId(String jwt) {
        return UUID.fromString(validerEtExtrairePayload(jwt).get("tokenId", String.class));
    }
}

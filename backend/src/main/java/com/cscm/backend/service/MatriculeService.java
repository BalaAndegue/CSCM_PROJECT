package com.cscm.backend.service;

import com.cscm.backend.repository.HopitalRepository;
import com.cscm.backend.repository.MedecinRepository;
import com.cscm.backend.repository.PatientRepository;
import com.cscm.backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.time.Year;

@Service
@RequiredArgsConstructor
public class MatriculeService {

    private final PatientRepository patientRepository;
    private final MedecinRepository medecinRepository;
    private final HopitalRepository hopitalRepository;
    private final UserRepository userRepository;

    private static final String COUNTRY_CODE = "CM";
    private static final int YEAR = Year.now().getValue() % 100;

    public Mono<String> genererMatriculePatient() {
        return patientRepository.nextMatriculeSequence()
                .map(seq -> String.format("%s-PAT-%02d-%06d", COUNTRY_CODE, YEAR, seq));
    }

    public Mono<String> genererMatriculeMedecin() {
        return medecinRepository.nextMatriculeSequence()
                .map(seq -> String.format("%s-MED-%02d-%06d", COUNTRY_CODE, YEAR, seq));
    }

    public Mono<String> genererMatriculeHopital() {
        return hopitalRepository.nextMatriculeSequence()
                .map(seq -> String.format("%s-HOP-%02d-%06d", COUNTRY_CODE, YEAR, seq));
    }

    public Mono<String> genererMatriculeAdmin() {
        return userRepository.nextMatriculeSequence()
                .map(seq -> String.format("%s-ADM-%02d-%06d", COUNTRY_CODE, YEAR, seq));
    }
}

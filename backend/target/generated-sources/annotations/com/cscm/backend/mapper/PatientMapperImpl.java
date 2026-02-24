package com.cscm.backend.mapper;

import com.cscm.backend.dto.response.PatientDto;
import com.cscm.backend.entity.Patient;
import com.cscm.backend.entity.User;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2026-02-24T01:29:56+0100",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 23 (Oracle Corporation)"
)
@Component
public class PatientMapperImpl implements PatientMapper {

    @Override
    public PatientDto toDto(Patient patient) {
        if ( patient == null ) {
            return null;
        }

        PatientDto.PatientDtoBuilder patientDto = PatientDto.builder();

        patientDto.nomComplet( patientUserNomComplet( patient ) );
        patientDto.email( patientUserEmail( patient ) );
        patientDto.id( patient.getId() );
        patientDto.numeroCarnet( patient.getNumeroCarnet() );
        patientDto.dateNaissance( patient.getDateNaissance() );
        patientDto.genre( patient.getGenre() );
        patientDto.adresse( patient.getAdresse() );
        patientDto.telephone( patient.getTelephone() );
        patientDto.situationFamiliale( patient.getSituationFamiliale() );
        patientDto.profession( patient.getProfession() );
        patientDto.groupeSanguin( patient.getGroupeSanguin() );
        patientDto.dateVerificationAboRh( patient.getDateVerificationAboRh() );
        patientDto.createdAt( patient.getCreatedAt() );
        patientDto.updatedAt( patient.getUpdatedAt() );

        return patientDto.build();
    }

    @Override
    public Patient toEntity(PatientDto patientDto) {
        if ( patientDto == null ) {
            return null;
        }

        Patient.PatientBuilder patient = Patient.builder();

        patient.id( patientDto.getId() );
        patient.numeroCarnet( patientDto.getNumeroCarnet() );
        patient.dateNaissance( patientDto.getDateNaissance() );
        patient.genre( patientDto.getGenre() );
        patient.adresse( patientDto.getAdresse() );
        patient.telephone( patientDto.getTelephone() );
        patient.situationFamiliale( patientDto.getSituationFamiliale() );
        patient.profession( patientDto.getProfession() );
        patient.groupeSanguin( patientDto.getGroupeSanguin() );
        patient.dateVerificationAboRh( patientDto.getDateVerificationAboRh() );
        patient.createdAt( patientDto.getCreatedAt() );
        patient.updatedAt( patientDto.getUpdatedAt() );

        return patient.build();
    }

    private String patientUserNomComplet(Patient patient) {
        if ( patient == null ) {
            return null;
        }
        User user = patient.getUser();
        if ( user == null ) {
            return null;
        }
        String nomComplet = user.getNomComplet();
        if ( nomComplet == null ) {
            return null;
        }
        return nomComplet;
    }

    private String patientUserEmail(Patient patient) {
        if ( patient == null ) {
            return null;
        }
        User user = patient.getUser();
        if ( user == null ) {
            return null;
        }
        String email = user.getEmail();
        if ( email == null ) {
            return null;
        }
        return email;
    }
}

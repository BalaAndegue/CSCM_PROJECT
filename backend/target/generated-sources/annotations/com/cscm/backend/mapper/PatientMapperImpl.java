package com.cscm.backend.mapper;

import com.cscm.backend.dto.response.PatientDto;
import com.cscm.backend.entity.Patient;
import com.cscm.backend.entity.User;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2026-03-03T12:44:12+0100",
    comments = "version: 1.5.5.Final, compiler: Eclipse JDT (IDE) 3.45.0.v20260128-0750, environment: Java 21.0.9 (Eclipse Adoptium)"
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
        patientDto.adresse( patient.getAdresse() );
        patientDto.createdAt( patient.getCreatedAt() );
        patientDto.dateNaissance( patient.getDateNaissance() );
        patientDto.dateVerificationAboRh( patient.getDateVerificationAboRh() );
        patientDto.genre( patient.getGenre() );
        patientDto.groupeSanguin( patient.getGroupeSanguin() );
        patientDto.id( patient.getId() );
        patientDto.numeroCarnet( patient.getNumeroCarnet() );
        patientDto.profession( patient.getProfession() );
        patientDto.situationFamiliale( patient.getSituationFamiliale() );
        patientDto.telephone( patient.getTelephone() );
        patientDto.updatedAt( patient.getUpdatedAt() );

        return patientDto.build();
    }

    @Override
    public Patient toEntity(PatientDto patientDto) {
        if ( patientDto == null ) {
            return null;
        }

        Patient.PatientBuilder patient = Patient.builder();

        patient.adresse( patientDto.getAdresse() );
        patient.createdAt( patientDto.getCreatedAt() );
        patient.dateNaissance( patientDto.getDateNaissance() );
        patient.dateVerificationAboRh( patientDto.getDateVerificationAboRh() );
        patient.genre( patientDto.getGenre() );
        patient.groupeSanguin( patientDto.getGroupeSanguin() );
        patient.id( patientDto.getId() );
        patient.numeroCarnet( patientDto.getNumeroCarnet() );
        patient.profession( patientDto.getProfession() );
        patient.situationFamiliale( patientDto.getSituationFamiliale() );
        patient.telephone( patientDto.getTelephone() );
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

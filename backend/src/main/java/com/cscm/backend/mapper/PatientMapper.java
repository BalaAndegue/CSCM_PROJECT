package com.cscm.backend.mapper;

import com.cscm.backend.dto.response.PatientDto;
import com.cscm.backend.entity.Patient;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface PatientMapper {

    @Mapping(target = "nomComplet", source = "user.nomComplet")
    @Mapping(target = "email", source = "user.email")
    PatientDto toDto(Patient patient);

    @Mapping(target = "user", ignore = true)
    Patient toEntity(PatientDto patientDto);
}

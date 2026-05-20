package com.cscm.backend.mapper;

import com.cscm.backend.dto.response.PatientDto;
import com.cscm.backend.entity.Patient;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface PatientMapper {

    PatientDto toDto(Patient patient);

    Patient toEntity(PatientDto patientDto);
}

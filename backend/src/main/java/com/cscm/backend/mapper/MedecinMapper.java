package com.cscm.backend.mapper;

import com.cscm.backend.dto.response.MedecinDto;
import com.cscm.backend.entity.Medecin;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface MedecinMapper {

    MedecinDto toDto(Medecin medecin);

    Medecin toEntity(MedecinDto medecinDto);
}

package com.cscm.backend.mapper;

import com.cscm.backend.dto.response.MedecinDto;
import com.cscm.backend.entity.Medecin;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface MedecinMapper {

    @Mapping(target = "nomComplet", source = "user.nomComplet")
    @Mapping(target = "email", source = "user.email")
    MedecinDto toDto(Medecin medecin);

    @Mapping(target = "user", ignore = true)
    Medecin toEntity(MedecinDto medecinDto);
}

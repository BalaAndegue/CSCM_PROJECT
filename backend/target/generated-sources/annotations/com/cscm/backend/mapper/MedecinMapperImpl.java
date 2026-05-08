package com.cscm.backend.mapper;

import com.cscm.backend.dto.response.MedecinDto;
import com.cscm.backend.entity.Medecin;
import com.cscm.backend.entity.User;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2026-05-05T11:08:36+0100",
    comments = "version: 1.5.5.Final, compiler: Eclipse JDT (IDE) 3.46.0.v20260407-0427, environment: Java 21.0.10 (Eclipse Adoptium)"
)
@Component
public class MedecinMapperImpl implements MedecinMapper {

    @Override
    public MedecinDto toDto(Medecin medecin) {
        if ( medecin == null ) {
            return null;
        }

        MedecinDto.MedecinDtoBuilder medecinDto = MedecinDto.builder();

        medecinDto.nomComplet( medecinUserNomComplet( medecin ) );
        medecinDto.email( medecinUserEmail( medecin ) );
        medecinDto.anneesExperience( medecin.getAnneesExperience() );
        medecinDto.biographie( medecin.getBiographie() );
        medecinDto.consultationFee( medecin.getConsultationFee() );
        List<String> list = medecin.getDiplomes();
        if ( list != null ) {
            medecinDto.diplomes( new ArrayList<String>( list ) );
        }
        medecinDto.disponible( medecin.getDisponible() );
        medecinDto.id( medecin.getId() );
        medecinDto.numeroCarteProfessionnelle( medecin.getNumeroCarteProfessionnelle() );
        medecinDto.numeroOrdre( medecin.getNumeroOrdre() );
        medecinDto.sousSpecialite( medecin.getSousSpecialite() );
        medecinDto.specialite( medecin.getSpecialite() );
        medecinDto.status( medecin.getStatus() );

        return medecinDto.build();
    }

    @Override
    public Medecin toEntity(MedecinDto medecinDto) {
        if ( medecinDto == null ) {
            return null;
        }

        Medecin.MedecinBuilder medecin = Medecin.builder();

        medecin.anneesExperience( medecinDto.getAnneesExperience() );
        medecin.biographie( medecinDto.getBiographie() );
        medecin.consultationFee( medecinDto.getConsultationFee() );
        List<String> list = medecinDto.getDiplomes();
        if ( list != null ) {
            medecin.diplomes( new ArrayList<String>( list ) );
        }
        medecin.disponible( medecinDto.getDisponible() );
        medecin.id( medecinDto.getId() );
        medecin.numeroCarteProfessionnelle( medecinDto.getNumeroCarteProfessionnelle() );
        medecin.numeroOrdre( medecinDto.getNumeroOrdre() );
        medecin.sousSpecialite( medecinDto.getSousSpecialite() );
        medecin.specialite( medecinDto.getSpecialite() );
        medecin.status( medecinDto.getStatus() );

        return medecin.build();
    }

    private String medecinUserNomComplet(Medecin medecin) {
        if ( medecin == null ) {
            return null;
        }
        User user = medecin.getUser();
        if ( user == null ) {
            return null;
        }
        String nomComplet = user.getNomComplet();
        if ( nomComplet == null ) {
            return null;
        }
        return nomComplet;
    }

    private String medecinUserEmail(Medecin medecin) {
        if ( medecin == null ) {
            return null;
        }
        User user = medecin.getUser();
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

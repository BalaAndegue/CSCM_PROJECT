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
    date = "2026-02-24T01:29:55+0100",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 23 (Oracle Corporation)"
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
        medecinDto.id( medecin.getId() );
        medecinDto.numeroOrdre( medecin.getNumeroOrdre() );
        medecinDto.specialite( medecin.getSpecialite() );
        medecinDto.sousSpecialite( medecin.getSousSpecialite() );
        medecinDto.numeroCarteProfessionnelle( medecin.getNumeroCarteProfessionnelle() );
        medecinDto.anneesExperience( medecin.getAnneesExperience() );
        medecinDto.biographie( medecin.getBiographie() );
        medecinDto.status( medecin.getStatus() );
        medecinDto.consultationFee( medecin.getConsultationFee() );
        medecinDto.disponible( medecin.getDisponible() );
        List<String> list = medecin.getDiplomes();
        if ( list != null ) {
            medecinDto.diplomes( new ArrayList<String>( list ) );
        }

        return medecinDto.build();
    }

    @Override
    public Medecin toEntity(MedecinDto medecinDto) {
        if ( medecinDto == null ) {
            return null;
        }

        Medecin.MedecinBuilder medecin = Medecin.builder();

        medecin.id( medecinDto.getId() );
        medecin.numeroOrdre( medecinDto.getNumeroOrdre() );
        medecin.specialite( medecinDto.getSpecialite() );
        medecin.sousSpecialite( medecinDto.getSousSpecialite() );
        medecin.numeroCarteProfessionnelle( medecinDto.getNumeroCarteProfessionnelle() );
        medecin.anneesExperience( medecinDto.getAnneesExperience() );
        List<String> list = medecinDto.getDiplomes();
        if ( list != null ) {
            medecin.diplomes( new ArrayList<String>( list ) );
        }
        medecin.biographie( medecinDto.getBiographie() );
        medecin.status( medecinDto.getStatus() );
        medecin.consultationFee( medecinDto.getConsultationFee() );
        medecin.disponible( medecinDto.getDisponible() );

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

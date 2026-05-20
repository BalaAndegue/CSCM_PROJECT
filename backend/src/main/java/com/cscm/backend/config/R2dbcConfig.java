package com.cscm.backend.config;

import com.cscm.backend.enums.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.convert.ReadingConverter;
import org.springframework.data.convert.WritingConverter;
import org.springframework.data.r2dbc.convert.R2dbcCustomConversions;
import org.springframework.data.r2dbc.dialect.PostgresDialect;
import org.springframework.lang.NonNull;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class R2dbcConfig {

    @Bean
    R2dbcCustomConversions r2dbcCustomConversions() {
        List<Object> converters = new ArrayList<>();

        // UserRole
        converters.add(new StringToUserRoleConverter());
        converters.add(new UserRoleToStringConverter());

        // Genre
        converters.add(new StringToGenreConverter());
        converters.add(new GenreToStringConverter());

        // GroupeSanguin
        converters.add(new StringToGroupeSanguinConverter());
        converters.add(new GroupeSanguinToStringConverter());

        // SituationFamiliale
        converters.add(new StringToSituationFamilialeConverter());
        converters.add(new SituationFamilialeToStringConverter());

        // LienParente
        converters.add(new StringToLienParenteConverter());
        converters.add(new LienParenteToStringConverter());

        // RegionCameroun
        converters.add(new StringToRegionCamerounConverter());
        converters.add(new RegionCamerounToStringConverter());

        // MedecinStatus
        converters.add(new StringToMedecinStatusConverter());
        converters.add(new MedecinStatusToStringConverter());

        // HopitalStatus
        converters.add(new StringToHopitalStatusConverter());
        converters.add(new HopitalStatusToStringConverter());

        // TypeAccesCarnet
        converters.add(new StringToTypeAccesCarnetConverter());
        converters.add(new TypeAccesCarnetToStringConverter());

        // StatutTokenAcces
        converters.add(new StringToStatutTokenAccesConverter());
        converters.add(new StatutTokenAccesToStringConverter());

        // TypeMedia
        converters.add(new StringToTypeMediaConverter());
        converters.add(new TypeMediaToStringConverter());

        // TypeDocumentValidation
        converters.add(new StringToTypeDocumentValidationConverter());
        converters.add(new TypeDocumentValidationToStringConverter());

        // StatutDocument
        converters.add(new StringToStatutDocumentConverter());
        converters.add(new StatutDocumentToStringConverter());

        // TypeExamenCameroun
        converters.add(new StringToTypeExamenCamerounConverter());
        converters.add(new TypeExamenCamerounToStringConverter());

        // TypeNotification
        converters.add(new StringToTypeNotificationConverter());
        converters.add(new TypeNotificationToStringConverter());

        // GraviteAllergie
        converters.add(new StringToGraviteAllergieConverter());
        converters.add(new GraviteAllergieToStringConverter());

        // TypeReactionAllergie
        converters.add(new StringToTypeReactionAllergieConverter());
        converters.add(new TypeReactionAllergieToStringConverter());

        // GraviteConsultation
        converters.add(new StringToGraviteConsultationConverter());
        converters.add(new GraviteConsultationToStringConverter());

        // OrdonnanceStatus
        converters.add(new StringToOrdonnanceStatusConverter());
        converters.add(new OrdonnanceStatusToStringConverter());

        // AbonnementPlan
        converters.add(new StringToAbonnementPlanConverter());
        converters.add(new AbonnementPlanToStringConverter());

        // AbonnementStatut
        converters.add(new StringToAbonnementStatutConverter());
        converters.add(new AbonnementStatutToStringConverter());

        // AbonnementPeriode
        converters.add(new StringToAbonnementPeriodeConverter());
        converters.add(new AbonnementPeriodeToStringConverter());

        return R2dbcCustomConversions.of(PostgresDialect.INSTANCE, converters);
    }

    // ─── UserRole ────────────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToUserRoleConverter implements Converter<String, UserRole> {
        @Override public UserRole convert(@NonNull String s) { return UserRole.valueOf(s); }
    }
    @WritingConverter
    static class UserRoleToStringConverter implements Converter<UserRole, String> {
        @Override public String convert(@NonNull UserRole e) { return e.name(); }
    }

    // ─── Genre ───────────────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToGenreConverter implements Converter<String, Genre> {
        @Override public Genre convert(@NonNull String s) { return Genre.valueOf(s); }
    }
    @WritingConverter
    static class GenreToStringConverter implements Converter<Genre, String> {
        @Override public String convert(@NonNull Genre e) { return e.name(); }
    }

    // ─── GroupeSanguin ───────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToGroupeSanguinConverter implements Converter<String, GroupeSanguin> {
        @Override public GroupeSanguin convert(@NonNull String s) { return GroupeSanguin.valueOf(s); }
    }
    @WritingConverter
    static class GroupeSanguinToStringConverter implements Converter<GroupeSanguin, String> {
        @Override public String convert(@NonNull GroupeSanguin e) { return e.name(); }
    }

    // ─── SituationFamiliale ──────────────────────────────────────────────────

    @ReadingConverter
    static class StringToSituationFamilialeConverter implements Converter<String, SituationFamiliale> {
        @Override public SituationFamiliale convert(@NonNull String s) { return SituationFamiliale.valueOf(s); }
    }
    @WritingConverter
    static class SituationFamilialeToStringConverter implements Converter<SituationFamiliale, String> {
        @Override public String convert(@NonNull SituationFamiliale e) { return e.name(); }
    }

    // ─── LienParente ─────────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToLienParenteConverter implements Converter<String, LienParente> {
        @Override public LienParente convert(@NonNull String s) { return LienParente.valueOf(s); }
    }
    @WritingConverter
    static class LienParenteToStringConverter implements Converter<LienParente, String> {
        @Override public String convert(@NonNull LienParente e) { return e.name(); }
    }

    // ─── RegionCameroun ──────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToRegionCamerounConverter implements Converter<String, RegionCameroun> {
        @Override public RegionCameroun convert(@NonNull String s) { return RegionCameroun.valueOf(s); }
    }
    @WritingConverter
    static class RegionCamerounToStringConverter implements Converter<RegionCameroun, String> {
        @Override public String convert(@NonNull RegionCameroun e) { return e.name(); }
    }

    // ─── MedecinStatus ───────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToMedecinStatusConverter implements Converter<String, MedecinStatus> {
        @Override public MedecinStatus convert(@NonNull String s) { return MedecinStatus.valueOf(s); }
    }
    @WritingConverter
    static class MedecinStatusToStringConverter implements Converter<MedecinStatus, String> {
        @Override public String convert(@NonNull MedecinStatus e) { return e.name(); }
    }

    // ─── HopitalStatus ───────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToHopitalStatusConverter implements Converter<String, HopitalStatus> {
        @Override public HopitalStatus convert(@NonNull String s) { return HopitalStatus.valueOf(s); }
    }
    @WritingConverter
    static class HopitalStatusToStringConverter implements Converter<HopitalStatus, String> {
        @Override public String convert(@NonNull HopitalStatus e) { return e.name(); }
    }

    // ─── TypeAccesCarnet ─────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToTypeAccesCarnetConverter implements Converter<String, TypeAccesCarnet> {
        @Override public TypeAccesCarnet convert(@NonNull String s) { return TypeAccesCarnet.valueOf(s); }
    }
    @WritingConverter
    static class TypeAccesCarnetToStringConverter implements Converter<TypeAccesCarnet, String> {
        @Override public String convert(@NonNull TypeAccesCarnet e) { return e.name(); }
    }

    // ─── StatutTokenAcces ────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToStatutTokenAccesConverter implements Converter<String, StatutTokenAcces> {
        @Override public StatutTokenAcces convert(@NonNull String s) { return StatutTokenAcces.valueOf(s); }
    }
    @WritingConverter
    static class StatutTokenAccesToStringConverter implements Converter<StatutTokenAcces, String> {
        @Override public String convert(@NonNull StatutTokenAcces e) { return e.name(); }
    }

    // ─── TypeMedia ───────────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToTypeMediaConverter implements Converter<String, TypeMedia> {
        @Override public TypeMedia convert(@NonNull String s) { return TypeMedia.valueOf(s); }
    }
    @WritingConverter
    static class TypeMediaToStringConverter implements Converter<TypeMedia, String> {
        @Override public String convert(@NonNull TypeMedia e) { return e.name(); }
    }

    // ─── TypeDocumentValidation ──────────────────────────────────────────────

    @ReadingConverter
    static class StringToTypeDocumentValidationConverter implements Converter<String, TypeDocumentValidation> {
        @Override public TypeDocumentValidation convert(@NonNull String s) { return TypeDocumentValidation.valueOf(s); }
    }
    @WritingConverter
    static class TypeDocumentValidationToStringConverter implements Converter<TypeDocumentValidation, String> {
        @Override public String convert(@NonNull TypeDocumentValidation e) { return e.name(); }
    }

    // ─── StatutDocument ──────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToStatutDocumentConverter implements Converter<String, StatutDocument> {
        @Override public StatutDocument convert(@NonNull String s) { return StatutDocument.valueOf(s); }
    }
    @WritingConverter
    static class StatutDocumentToStringConverter implements Converter<StatutDocument, String> {
        @Override public String convert(@NonNull StatutDocument e) { return e.name(); }
    }

    // ─── TypeExamenCameroun ──────────────────────────────────────────────────

    @ReadingConverter
    static class StringToTypeExamenCamerounConverter implements Converter<String, TypeExamenCameroun> {
        @Override public TypeExamenCameroun convert(@NonNull String s) { return TypeExamenCameroun.valueOf(s); }
    }
    @WritingConverter
    static class TypeExamenCamerounToStringConverter implements Converter<TypeExamenCameroun, String> {
        @Override public String convert(@NonNull TypeExamenCameroun e) { return e.name(); }
    }

    // ─── TypeNotification ────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToTypeNotificationConverter implements Converter<String, TypeNotification> {
        @Override public TypeNotification convert(@NonNull String s) { return TypeNotification.valueOf(s); }
    }
    @WritingConverter
    static class TypeNotificationToStringConverter implements Converter<TypeNotification, String> {
        @Override public String convert(@NonNull TypeNotification e) { return e.name(); }
    }

    // ─── GraviteAllergie ─────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToGraviteAllergieConverter implements Converter<String, GraviteAllergie> {
        @Override public GraviteAllergie convert(@NonNull String s) { return GraviteAllergie.valueOf(s); }
    }
    @WritingConverter
    static class GraviteAllergieToStringConverter implements Converter<GraviteAllergie, String> {
        @Override public String convert(@NonNull GraviteAllergie e) { return e.name(); }
    }

    // ─── TypeReactionAllergie ────────────────────────────────────────────────

    @ReadingConverter
    static class StringToTypeReactionAllergieConverter implements Converter<String, TypeReactionAllergie> {
        @Override public TypeReactionAllergie convert(@NonNull String s) { return TypeReactionAllergie.valueOf(s); }
    }
    @WritingConverter
    static class TypeReactionAllergieToStringConverter implements Converter<TypeReactionAllergie, String> {
        @Override public String convert(@NonNull TypeReactionAllergie e) { return e.name(); }
    }

    // ─── GraviteConsultation ─────────────────────────────────────────────────

    @ReadingConverter
    static class StringToGraviteConsultationConverter implements Converter<String, GraviteConsultation> {
        @Override public GraviteConsultation convert(@NonNull String s) { return GraviteConsultation.valueOf(s); }
    }
    @WritingConverter
    static class GraviteConsultationToStringConverter implements Converter<GraviteConsultation, String> {
        @Override public String convert(@NonNull GraviteConsultation e) { return e.name(); }
    }

    // ─── OrdonnanceStatus ────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToOrdonnanceStatusConverter implements Converter<String, OrdonnanceStatus> {
        @Override public OrdonnanceStatus convert(@NonNull String s) { return OrdonnanceStatus.valueOf(s); }
    }
    @WritingConverter
    static class OrdonnanceStatusToStringConverter implements Converter<OrdonnanceStatus, String> {
        @Override public String convert(@NonNull OrdonnanceStatus e) { return e.name(); }
    }

    // ─── AbonnementPlan ──────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToAbonnementPlanConverter implements Converter<String, AbonnementPlan> {
        @Override public AbonnementPlan convert(@NonNull String s) { return AbonnementPlan.valueOf(s); }
    }
    @WritingConverter
    static class AbonnementPlanToStringConverter implements Converter<AbonnementPlan, String> {
        @Override public String convert(@NonNull AbonnementPlan e) { return e.name(); }
    }

    // ─── AbonnementStatut ────────────────────────────────────────────────────

    @ReadingConverter
    static class StringToAbonnementStatutConverter implements Converter<String, AbonnementStatut> {
        @Override public AbonnementStatut convert(@NonNull String s) { return AbonnementStatut.valueOf(s); }
    }
    @WritingConverter
    static class AbonnementStatutToStringConverter implements Converter<AbonnementStatut, String> {
        @Override public String convert(@NonNull AbonnementStatut e) { return e.name(); }
    }

    // ─── AbonnementPeriode ───────────────────────────────────────────────────

    @ReadingConverter
    static class StringToAbonnementPeriodeConverter implements Converter<String, AbonnementPeriode> {
        @Override public AbonnementPeriode convert(@NonNull String s) { return AbonnementPeriode.valueOf(s); }
    }
    @WritingConverter
    static class AbonnementPeriodeToStringConverter implements Converter<AbonnementPeriode, String> {
        @Override public String convert(@NonNull AbonnementPeriode e) { return e.name(); }
    }
}

//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Medecin {
  /// Returns a new [Medecin] instance.
  Medecin({
    this.id,
    this.user,
    this.numeroOrdre,
    this.specialite,
    this.sousSpecialite,
    this.numeroCarteProfessionnelle,
    this.anneesExperience,
    this.diplomes = const [],
    this.biographie,
    this.photoIdentite,
    this.status,
    this.raisonRejet,
    this.validePar,
    this.dateValidation,
    this.consultationFee,
    this.disponible,
    this.createdAt,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  User? user;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? numeroOrdre;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? specialite;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sousSpecialite;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? numeroCarteProfessionnelle;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? anneesExperience;

  List<String> diplomes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? biographie;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? photoIdentite;

  MedecinStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? raisonRejet;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? validePar;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateValidation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? consultationFee;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? disponible;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Medecin &&
    other.id == id &&
    other.user == user &&
    other.numeroOrdre == numeroOrdre &&
    other.specialite == specialite &&
    other.sousSpecialite == sousSpecialite &&
    other.numeroCarteProfessionnelle == numeroCarteProfessionnelle &&
    other.anneesExperience == anneesExperience &&
    _deepEquality.equals(other.diplomes, diplomes) &&
    other.biographie == biographie &&
    other.photoIdentite == photoIdentite &&
    other.status == status &&
    other.raisonRejet == raisonRejet &&
    other.validePar == validePar &&
    other.dateValidation == dateValidation &&
    other.consultationFee == consultationFee &&
    other.disponible == disponible &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (user == null ? 0 : user!.hashCode) +
    (numeroOrdre == null ? 0 : numeroOrdre!.hashCode) +
    (specialite == null ? 0 : specialite!.hashCode) +
    (sousSpecialite == null ? 0 : sousSpecialite!.hashCode) +
    (numeroCarteProfessionnelle == null ? 0 : numeroCarteProfessionnelle!.hashCode) +
    (anneesExperience == null ? 0 : anneesExperience!.hashCode) +
    (diplomes.hashCode) +
    (biographie == null ? 0 : biographie!.hashCode) +
    (photoIdentite == null ? 0 : photoIdentite!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (raisonRejet == null ? 0 : raisonRejet!.hashCode) +
    (validePar == null ? 0 : validePar!.hashCode) +
    (dateValidation == null ? 0 : dateValidation!.hashCode) +
    (consultationFee == null ? 0 : consultationFee!.hashCode) +
    (disponible == null ? 0 : disponible!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'Medecin[id=$id, user=$user, numeroOrdre=$numeroOrdre, specialite=$specialite, sousSpecialite=$sousSpecialite, numeroCarteProfessionnelle=$numeroCarteProfessionnelle, anneesExperience=$anneesExperience, diplomes=$diplomes, biographie=$biographie, photoIdentite=$photoIdentite, status=$status, raisonRejet=$raisonRejet, validePar=$validePar, dateValidation=$dateValidation, consultationFee=$consultationFee, disponible=$disponible, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.user != null) {
      json[r'user'] = this.user;
    } else {
      json[r'user'] = null;
    }
    if (this.numeroOrdre != null) {
      json[r'numeroOrdre'] = this.numeroOrdre;
    } else {
      json[r'numeroOrdre'] = null;
    }
    if (this.specialite != null) {
      json[r'specialite'] = this.specialite;
    } else {
      json[r'specialite'] = null;
    }
    if (this.sousSpecialite != null) {
      json[r'sousSpecialite'] = this.sousSpecialite;
    } else {
      json[r'sousSpecialite'] = null;
    }
    if (this.numeroCarteProfessionnelle != null) {
      json[r'numeroCarteProfessionnelle'] = this.numeroCarteProfessionnelle;
    } else {
      json[r'numeroCarteProfessionnelle'] = null;
    }
    if (this.anneesExperience != null) {
      json[r'anneesExperience'] = this.anneesExperience;
    } else {
      json[r'anneesExperience'] = null;
    }
      json[r'diplomes'] = this.diplomes;
    if (this.biographie != null) {
      json[r'biographie'] = this.biographie;
    } else {
      json[r'biographie'] = null;
    }
    if (this.photoIdentite != null) {
      json[r'photoIdentite'] = this.photoIdentite;
    } else {
      json[r'photoIdentite'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.raisonRejet != null) {
      json[r'raisonRejet'] = this.raisonRejet;
    } else {
      json[r'raisonRejet'] = null;
    }
    if (this.validePar != null) {
      json[r'validePar'] = this.validePar;
    } else {
      json[r'validePar'] = null;
    }
    if (this.dateValidation != null) {
      json[r'dateValidation'] = this.dateValidation!.toUtc().toIso8601String();
    } else {
      json[r'dateValidation'] = null;
    }
    if (this.consultationFee != null) {
      json[r'consultationFee'] = this.consultationFee;
    } else {
      json[r'consultationFee'] = null;
    }
    if (this.disponible != null) {
      json[r'disponible'] = this.disponible;
    } else {
      json[r'disponible'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [Medecin] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Medecin? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Medecin[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Medecin[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Medecin(
        id: mapValueOfType<String>(json, r'id'),
        user: User.fromJson(json[r'user']),
        numeroOrdre: mapValueOfType<String>(json, r'numeroOrdre'),
        specialite: mapValueOfType<String>(json, r'specialite'),
        sousSpecialite: mapValueOfType<String>(json, r'sousSpecialite'),
        numeroCarteProfessionnelle: mapValueOfType<String>(json, r'numeroCarteProfessionnelle'),
        anneesExperience: mapValueOfType<int>(json, r'anneesExperience'),
        diplomes: json[r'diplomes'] is Iterable
            ? (json[r'diplomes'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        biographie: mapValueOfType<String>(json, r'biographie'),
        photoIdentite: mapValueOfType<String>(json, r'photoIdentite'),
        status: MedecinStatusEnum.fromJson(json[r'status']),
        raisonRejet: mapValueOfType<String>(json, r'raisonRejet'),
        validePar: mapValueOfType<String>(json, r'validePar'),
        dateValidation: mapDateTime(json, r'dateValidation', r''),
        consultationFee: mapValueOfType<double>(json, r'consultationFee'),
        disponible: mapValueOfType<bool>(json, r'disponible'),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<Medecin> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Medecin>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Medecin.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Medecin> mapFromJson(dynamic json) {
    final map = <String, Medecin>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Medecin.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Medecin-objects as value to a dart map
  static Map<String, List<Medecin>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Medecin>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Medecin.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class MedecinStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const MedecinStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const EN_ATTENTE = MedecinStatusEnum._(r'EN_ATTENTE');
  static const VALIDE = MedecinStatusEnum._(r'VALIDE');
  static const SUSPENDU = MedecinStatusEnum._(r'SUSPENDU');
  static const REJETE = MedecinStatusEnum._(r'REJETE');

  /// List of all possible values in this [enum][MedecinStatusEnum].
  static const values = <MedecinStatusEnum>[
    EN_ATTENTE,
    VALIDE,
    SUSPENDU,
    REJETE,
  ];

  static MedecinStatusEnum? fromJson(dynamic value) => MedecinStatusEnumTypeTransformer().decode(value);

  static List<MedecinStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MedecinStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MedecinStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MedecinStatusEnum] to String,
/// and [decode] dynamic data back to [MedecinStatusEnum].
class MedecinStatusEnumTypeTransformer {
  factory MedecinStatusEnumTypeTransformer() => _instance ??= const MedecinStatusEnumTypeTransformer._();

  const MedecinStatusEnumTypeTransformer._();

  String encode(MedecinStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a MedecinStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MedecinStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'EN_ATTENTE': return MedecinStatusEnum.EN_ATTENTE;
        case r'VALIDE': return MedecinStatusEnum.VALIDE;
        case r'SUSPENDU': return MedecinStatusEnum.SUSPENDU;
        case r'REJETE': return MedecinStatusEnum.REJETE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MedecinStatusEnumTypeTransformer] instance.
  static MedecinStatusEnumTypeTransformer? _instance;
}



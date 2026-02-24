//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Allergie {
  /// Returns a new [Allergie] instance.
  Allergie({
    this.id,
    this.carnet,
    this.nomAllergene,
    this.typeAllergene,
    this.typeReaction,
    this.gravite,
    this.datePremierReaction,
    this.description,
    this.traitementUrgence,
    this.medecinNotificateur,
    this.visibleTousMedecins,
    this.active,
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
  CarnetMedical? carnet;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nomAllergene;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? typeAllergene;

  AllergieTypeReactionEnum? typeReaction;

  AllergieGraviteEnum? gravite;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? datePremierReaction;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? traitementUrgence;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Medecin? medecinNotificateur;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? visibleTousMedecins;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? active;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Allergie &&
    other.id == id &&
    other.carnet == carnet &&
    other.nomAllergene == nomAllergene &&
    other.typeAllergene == typeAllergene &&
    other.typeReaction == typeReaction &&
    other.gravite == gravite &&
    other.datePremierReaction == datePremierReaction &&
    other.description == description &&
    other.traitementUrgence == traitementUrgence &&
    other.medecinNotificateur == medecinNotificateur &&
    other.visibleTousMedecins == visibleTousMedecins &&
    other.active == active &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (carnet == null ? 0 : carnet!.hashCode) +
    (nomAllergene == null ? 0 : nomAllergene!.hashCode) +
    (typeAllergene == null ? 0 : typeAllergene!.hashCode) +
    (typeReaction == null ? 0 : typeReaction!.hashCode) +
    (gravite == null ? 0 : gravite!.hashCode) +
    (datePremierReaction == null ? 0 : datePremierReaction!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (traitementUrgence == null ? 0 : traitementUrgence!.hashCode) +
    (medecinNotificateur == null ? 0 : medecinNotificateur!.hashCode) +
    (visibleTousMedecins == null ? 0 : visibleTousMedecins!.hashCode) +
    (active == null ? 0 : active!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'Allergie[id=$id, carnet=$carnet, nomAllergene=$nomAllergene, typeAllergene=$typeAllergene, typeReaction=$typeReaction, gravite=$gravite, datePremierReaction=$datePremierReaction, description=$description, traitementUrgence=$traitementUrgence, medecinNotificateur=$medecinNotificateur, visibleTousMedecins=$visibleTousMedecins, active=$active, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.carnet != null) {
      json[r'carnet'] = this.carnet;
    } else {
      json[r'carnet'] = null;
    }
    if (this.nomAllergene != null) {
      json[r'nomAllergene'] = this.nomAllergene;
    } else {
      json[r'nomAllergene'] = null;
    }
    if (this.typeAllergene != null) {
      json[r'typeAllergene'] = this.typeAllergene;
    } else {
      json[r'typeAllergene'] = null;
    }
    if (this.typeReaction != null) {
      json[r'typeReaction'] = this.typeReaction;
    } else {
      json[r'typeReaction'] = null;
    }
    if (this.gravite != null) {
      json[r'gravite'] = this.gravite;
    } else {
      json[r'gravite'] = null;
    }
    if (this.datePremierReaction != null) {
      json[r'datePremierReaction'] = _dateFormatter.format(this.datePremierReaction!.toUtc());
    } else {
      json[r'datePremierReaction'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.traitementUrgence != null) {
      json[r'traitementUrgence'] = this.traitementUrgence;
    } else {
      json[r'traitementUrgence'] = null;
    }
    if (this.medecinNotificateur != null) {
      json[r'medecinNotificateur'] = this.medecinNotificateur;
    } else {
      json[r'medecinNotificateur'] = null;
    }
    if (this.visibleTousMedecins != null) {
      json[r'visibleTousMedecins'] = this.visibleTousMedecins;
    } else {
      json[r'visibleTousMedecins'] = null;
    }
    if (this.active != null) {
      json[r'active'] = this.active;
    } else {
      json[r'active'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [Allergie] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Allergie? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Allergie[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Allergie[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Allergie(
        id: mapValueOfType<String>(json, r'id'),
        carnet: CarnetMedical.fromJson(json[r'carnet']),
        nomAllergene: mapValueOfType<String>(json, r'nomAllergene'),
        typeAllergene: mapValueOfType<String>(json, r'typeAllergene'),
        typeReaction: AllergieTypeReactionEnum.fromJson(json[r'typeReaction']),
        gravite: AllergieGraviteEnum.fromJson(json[r'gravite']),
        datePremierReaction: mapDateTime(json, r'datePremierReaction', r''),
        description: mapValueOfType<String>(json, r'description'),
        traitementUrgence: mapValueOfType<String>(json, r'traitementUrgence'),
        medecinNotificateur: Medecin.fromJson(json[r'medecinNotificateur']),
        visibleTousMedecins: mapValueOfType<bool>(json, r'visibleTousMedecins'),
        active: mapValueOfType<bool>(json, r'active'),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<Allergie> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Allergie>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Allergie.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Allergie> mapFromJson(dynamic json) {
    final map = <String, Allergie>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Allergie.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Allergie-objects as value to a dart map
  static Map<String, List<Allergie>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Allergie>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Allergie.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class AllergieTypeReactionEnum {
  /// Instantiate a new enum with the provided [value].
  const AllergieTypeReactionEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ERUPTION = AllergieTypeReactionEnum._(r'ERUPTION');
  static const ANAPHYLAXIE = AllergieTypeReactionEnum._(r'ANAPHYLAXIE');
  static const NAUSEE = AllergieTypeReactionEnum._(r'NAUSEE');
  static const AUTRE = AllergieTypeReactionEnum._(r'AUTRE');

  /// List of all possible values in this [enum][AllergieTypeReactionEnum].
  static const values = <AllergieTypeReactionEnum>[
    ERUPTION,
    ANAPHYLAXIE,
    NAUSEE,
    AUTRE,
  ];

  static AllergieTypeReactionEnum? fromJson(dynamic value) => AllergieTypeReactionEnumTypeTransformer().decode(value);

  static List<AllergieTypeReactionEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AllergieTypeReactionEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AllergieTypeReactionEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AllergieTypeReactionEnum] to String,
/// and [decode] dynamic data back to [AllergieTypeReactionEnum].
class AllergieTypeReactionEnumTypeTransformer {
  factory AllergieTypeReactionEnumTypeTransformer() => _instance ??= const AllergieTypeReactionEnumTypeTransformer._();

  const AllergieTypeReactionEnumTypeTransformer._();

  String encode(AllergieTypeReactionEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AllergieTypeReactionEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AllergieTypeReactionEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ERUPTION': return AllergieTypeReactionEnum.ERUPTION;
        case r'ANAPHYLAXIE': return AllergieTypeReactionEnum.ANAPHYLAXIE;
        case r'NAUSEE': return AllergieTypeReactionEnum.NAUSEE;
        case r'AUTRE': return AllergieTypeReactionEnum.AUTRE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AllergieTypeReactionEnumTypeTransformer] instance.
  static AllergieTypeReactionEnumTypeTransformer? _instance;
}



class AllergieGraviteEnum {
  /// Instantiate a new enum with the provided [value].
  const AllergieGraviteEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const LEGERE = AllergieGraviteEnum._(r'LEGERE');
  static const MODEREE = AllergieGraviteEnum._(r'MODEREE');
  static const SEVERE = AllergieGraviteEnum._(r'SEVERE');
  static const MORTELLE = AllergieGraviteEnum._(r'MORTELLE');

  /// List of all possible values in this [enum][AllergieGraviteEnum].
  static const values = <AllergieGraviteEnum>[
    LEGERE,
    MODEREE,
    SEVERE,
    MORTELLE,
  ];

  static AllergieGraviteEnum? fromJson(dynamic value) => AllergieGraviteEnumTypeTransformer().decode(value);

  static List<AllergieGraviteEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AllergieGraviteEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AllergieGraviteEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AllergieGraviteEnum] to String,
/// and [decode] dynamic data back to [AllergieGraviteEnum].
class AllergieGraviteEnumTypeTransformer {
  factory AllergieGraviteEnumTypeTransformer() => _instance ??= const AllergieGraviteEnumTypeTransformer._();

  const AllergieGraviteEnumTypeTransformer._();

  String encode(AllergieGraviteEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AllergieGraviteEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AllergieGraviteEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'LEGERE': return AllergieGraviteEnum.LEGERE;
        case r'MODEREE': return AllergieGraviteEnum.MODEREE;
        case r'SEVERE': return AllergieGraviteEnum.SEVERE;
        case r'MORTELLE': return AllergieGraviteEnum.MORTELLE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AllergieGraviteEnumTypeTransformer] instance.
  static AllergieGraviteEnumTypeTransformer? _instance;
}



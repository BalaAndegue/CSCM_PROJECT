//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Hopital {
  /// Returns a new [Hopital] instance.
  Hopital({
    this.id,
    this.nom,
    this.adresse,
    this.telephone,
    this.email,
    this.siteWeb,
    this.numeroAgrement,
    this.description,
    this.nombreLits,
    this.status,
    this.manager,
    this.logo,
    this.localisationGps,
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
  String? nom;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? adresse;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? telephone;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? siteWeb;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? numeroAgrement;

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
  int? nombreLits;

  HopitalStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  User? manager;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? logo;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? localisationGps;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Hopital &&
    other.id == id &&
    other.nom == nom &&
    other.adresse == adresse &&
    other.telephone == telephone &&
    other.email == email &&
    other.siteWeb == siteWeb &&
    other.numeroAgrement == numeroAgrement &&
    other.description == description &&
    other.nombreLits == nombreLits &&
    other.status == status &&
    other.manager == manager &&
    other.logo == logo &&
    other.localisationGps == localisationGps &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (nom == null ? 0 : nom!.hashCode) +
    (adresse == null ? 0 : adresse!.hashCode) +
    (telephone == null ? 0 : telephone!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (siteWeb == null ? 0 : siteWeb!.hashCode) +
    (numeroAgrement == null ? 0 : numeroAgrement!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (nombreLits == null ? 0 : nombreLits!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (manager == null ? 0 : manager!.hashCode) +
    (logo == null ? 0 : logo!.hashCode) +
    (localisationGps == null ? 0 : localisationGps!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'Hopital[id=$id, nom=$nom, adresse=$adresse, telephone=$telephone, email=$email, siteWeb=$siteWeb, numeroAgrement=$numeroAgrement, description=$description, nombreLits=$nombreLits, status=$status, manager=$manager, logo=$logo, localisationGps=$localisationGps, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.nom != null) {
      json[r'nom'] = this.nom;
    } else {
      json[r'nom'] = null;
    }
    if (this.adresse != null) {
      json[r'adresse'] = this.adresse;
    } else {
      json[r'adresse'] = null;
    }
    if (this.telephone != null) {
      json[r'telephone'] = this.telephone;
    } else {
      json[r'telephone'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.siteWeb != null) {
      json[r'siteWeb'] = this.siteWeb;
    } else {
      json[r'siteWeb'] = null;
    }
    if (this.numeroAgrement != null) {
      json[r'numeroAgrement'] = this.numeroAgrement;
    } else {
      json[r'numeroAgrement'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.nombreLits != null) {
      json[r'nombreLits'] = this.nombreLits;
    } else {
      json[r'nombreLits'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.manager != null) {
      json[r'manager'] = this.manager;
    } else {
      json[r'manager'] = null;
    }
    if (this.logo != null) {
      json[r'logo'] = this.logo;
    } else {
      json[r'logo'] = null;
    }
    if (this.localisationGps != null) {
      json[r'localisationGps'] = this.localisationGps;
    } else {
      json[r'localisationGps'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [Hopital] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Hopital? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Hopital[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Hopital[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Hopital(
        id: mapValueOfType<String>(json, r'id'),
        nom: mapValueOfType<String>(json, r'nom'),
        adresse: mapValueOfType<String>(json, r'adresse'),
        telephone: mapValueOfType<String>(json, r'telephone'),
        email: mapValueOfType<String>(json, r'email'),
        siteWeb: mapValueOfType<String>(json, r'siteWeb'),
        numeroAgrement: mapValueOfType<String>(json, r'numeroAgrement'),
        description: mapValueOfType<String>(json, r'description'),
        nombreLits: mapValueOfType<int>(json, r'nombreLits'),
        status: HopitalStatusEnum.fromJson(json[r'status']),
        manager: User.fromJson(json[r'manager']),
        logo: mapValueOfType<String>(json, r'logo'),
        localisationGps: mapValueOfType<String>(json, r'localisationGps'),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<Hopital> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Hopital>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Hopital.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Hopital> mapFromJson(dynamic json) {
    final map = <String, Hopital>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Hopital.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Hopital-objects as value to a dart map
  static Map<String, List<Hopital>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Hopital>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Hopital.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class HopitalStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const HopitalStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ACTIF = HopitalStatusEnum._(r'ACTIF');
  static const SUSPENDU = HopitalStatusEnum._(r'SUSPENDU');

  /// List of all possible values in this [enum][HopitalStatusEnum].
  static const values = <HopitalStatusEnum>[
    ACTIF,
    SUSPENDU,
  ];

  static HopitalStatusEnum? fromJson(dynamic value) => HopitalStatusEnumTypeTransformer().decode(value);

  static List<HopitalStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <HopitalStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = HopitalStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [HopitalStatusEnum] to String,
/// and [decode] dynamic data back to [HopitalStatusEnum].
class HopitalStatusEnumTypeTransformer {
  factory HopitalStatusEnumTypeTransformer() => _instance ??= const HopitalStatusEnumTypeTransformer._();

  const HopitalStatusEnumTypeTransformer._();

  String encode(HopitalStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a HopitalStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  HopitalStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ACTIF': return HopitalStatusEnum.ACTIF;
        case r'SUSPENDU': return HopitalStatusEnum.SUSPENDU;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [HopitalStatusEnumTypeTransformer] instance.
  static HopitalStatusEnumTypeTransformer? _instance;
}



//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Ordonnance {
  /// Returns a new [Ordonnance] instance.
  Ordonnance({
    this.id,
    this.consultation,
    this.carnet,
    this.medecin,
    this.hopital,
    this.datePrescription,
    this.dateExpiration,
    this.renouvelable,
    this.nombreRenouvellements,
    this.numeroOrdonnance,
    this.medicaments = const [],
    this.instructions,
    this.posologieDetaillee,
    this.notePharmacien,
    this.status,
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
  Consultation? consultation;

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
  Medecin? medecin;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Hopital? hopital;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? datePrescription;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateExpiration;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? renouvelable;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? nombreRenouvellements;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? numeroOrdonnance;

  List<Map<String, Object>> medicaments;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? instructions;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? posologieDetaillee;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? notePharmacien;

  OrdonnanceStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Ordonnance &&
    other.id == id &&
    other.consultation == consultation &&
    other.carnet == carnet &&
    other.medecin == medecin &&
    other.hopital == hopital &&
    other.datePrescription == datePrescription &&
    other.dateExpiration == dateExpiration &&
    other.renouvelable == renouvelable &&
    other.nombreRenouvellements == nombreRenouvellements &&
    other.numeroOrdonnance == numeroOrdonnance &&
    _deepEquality.equals(other.medicaments, medicaments) &&
    other.instructions == instructions &&
    other.posologieDetaillee == posologieDetaillee &&
    other.notePharmacien == notePharmacien &&
    other.status == status &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (consultation == null ? 0 : consultation!.hashCode) +
    (carnet == null ? 0 : carnet!.hashCode) +
    (medecin == null ? 0 : medecin!.hashCode) +
    (hopital == null ? 0 : hopital!.hashCode) +
    (datePrescription == null ? 0 : datePrescription!.hashCode) +
    (dateExpiration == null ? 0 : dateExpiration!.hashCode) +
    (renouvelable == null ? 0 : renouvelable!.hashCode) +
    (nombreRenouvellements == null ? 0 : nombreRenouvellements!.hashCode) +
    (numeroOrdonnance == null ? 0 : numeroOrdonnance!.hashCode) +
    (medicaments.hashCode) +
    (instructions == null ? 0 : instructions!.hashCode) +
    (posologieDetaillee == null ? 0 : posologieDetaillee!.hashCode) +
    (notePharmacien == null ? 0 : notePharmacien!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'Ordonnance[id=$id, consultation=$consultation, carnet=$carnet, medecin=$medecin, hopital=$hopital, datePrescription=$datePrescription, dateExpiration=$dateExpiration, renouvelable=$renouvelable, nombreRenouvellements=$nombreRenouvellements, numeroOrdonnance=$numeroOrdonnance, medicaments=$medicaments, instructions=$instructions, posologieDetaillee=$posologieDetaillee, notePharmacien=$notePharmacien, status=$status, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.consultation != null) {
      json[r'consultation'] = this.consultation;
    } else {
      json[r'consultation'] = null;
    }
    if (this.carnet != null) {
      json[r'carnet'] = this.carnet;
    } else {
      json[r'carnet'] = null;
    }
    if (this.medecin != null) {
      json[r'medecin'] = this.medecin;
    } else {
      json[r'medecin'] = null;
    }
    if (this.hopital != null) {
      json[r'hopital'] = this.hopital;
    } else {
      json[r'hopital'] = null;
    }
    if (this.datePrescription != null) {
      json[r'datePrescription'] = this.datePrescription!.toUtc().toIso8601String();
    } else {
      json[r'datePrescription'] = null;
    }
    if (this.dateExpiration != null) {
      json[r'dateExpiration'] = this.dateExpiration!.toUtc().toIso8601String();
    } else {
      json[r'dateExpiration'] = null;
    }
    if (this.renouvelable != null) {
      json[r'renouvelable'] = this.renouvelable;
    } else {
      json[r'renouvelable'] = null;
    }
    if (this.nombreRenouvellements != null) {
      json[r'nombreRenouvellements'] = this.nombreRenouvellements;
    } else {
      json[r'nombreRenouvellements'] = null;
    }
    if (this.numeroOrdonnance != null) {
      json[r'numeroOrdonnance'] = this.numeroOrdonnance;
    } else {
      json[r'numeroOrdonnance'] = null;
    }
      json[r'medicaments'] = this.medicaments;
    if (this.instructions != null) {
      json[r'instructions'] = this.instructions;
    } else {
      json[r'instructions'] = null;
    }
    if (this.posologieDetaillee != null) {
      json[r'posologieDetaillee'] = this.posologieDetaillee;
    } else {
      json[r'posologieDetaillee'] = null;
    }
    if (this.notePharmacien != null) {
      json[r'notePharmacien'] = this.notePharmacien;
    } else {
      json[r'notePharmacien'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [Ordonnance] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Ordonnance? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Ordonnance[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Ordonnance[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Ordonnance(
        id: mapValueOfType<String>(json, r'id'),
        consultation: Consultation.fromJson(json[r'consultation']),
        carnet: CarnetMedical.fromJson(json[r'carnet']),
        medecin: Medecin.fromJson(json[r'medecin']),
        hopital: Hopital.fromJson(json[r'hopital']),
        datePrescription: mapDateTime(json, r'datePrescription', r''),
        dateExpiration: mapDateTime(json, r'dateExpiration', r''),
        renouvelable: mapValueOfType<bool>(json, r'renouvelable'),
        nombreRenouvellements: mapValueOfType<int>(json, r'nombreRenouvellements'),
        numeroOrdonnance: mapValueOfType<String>(json, r'numeroOrdonnance'),
        medicaments: json[r'medicaments'] == null
            ? []
            : (json[r'medicaments'] as List)
            .map((item) => Map<String, Object>.from(item as Map))
            .toList(),
        instructions: mapValueOfType<String>(json, r'instructions'),
        posologieDetaillee: mapValueOfType<String>(json, r'posologieDetaillee'),
        notePharmacien: mapValueOfType<String>(json, r'notePharmacien'),
        status: OrdonnanceStatusEnum.fromJson(json[r'status']),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<Ordonnance> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Ordonnance>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Ordonnance.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Ordonnance> mapFromJson(dynamic json) {
    final map = <String, Ordonnance>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Ordonnance.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Ordonnance-objects as value to a dart map
  static Map<String, List<Ordonnance>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Ordonnance>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Ordonnance.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class OrdonnanceStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const OrdonnanceStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const ACTIVE = OrdonnanceStatusEnum._(r'ACTIVE');
  static const EXPIREE = OrdonnanceStatusEnum._(r'EXPIREE');
  static const ANNULEE = OrdonnanceStatusEnum._(r'ANNULEE');

  /// List of all possible values in this [enum][OrdonnanceStatusEnum].
  static const values = <OrdonnanceStatusEnum>[
    ACTIVE,
    EXPIREE,
    ANNULEE,
  ];

  static OrdonnanceStatusEnum? fromJson(dynamic value) => OrdonnanceStatusEnumTypeTransformer().decode(value);

  static List<OrdonnanceStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <OrdonnanceStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = OrdonnanceStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [OrdonnanceStatusEnum] to String,
/// and [decode] dynamic data back to [OrdonnanceStatusEnum].
class OrdonnanceStatusEnumTypeTransformer {
  factory OrdonnanceStatusEnumTypeTransformer() => _instance ??= const OrdonnanceStatusEnumTypeTransformer._();

  const OrdonnanceStatusEnumTypeTransformer._();

  String encode(OrdonnanceStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a OrdonnanceStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  OrdonnanceStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ACTIVE': return OrdonnanceStatusEnum.ACTIVE;
        case r'EXPIREE': return OrdonnanceStatusEnum.EXPIREE;
        case r'ANNULEE': return OrdonnanceStatusEnum.ANNULEE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [OrdonnanceStatusEnumTypeTransformer] instance.
  static OrdonnanceStatusEnumTypeTransformer? _instance;
}



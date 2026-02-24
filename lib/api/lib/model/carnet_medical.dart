//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CarnetMedical {
  /// Returns a new [CarnetMedical] instance.
  CarnetMedical({
    this.id,
    this.patient,
    this.version,
    this.statut,
    this.abonnementActif,
    this.dateExpirationAbonnement,
    this.notesGenerales,
    this.createdAt,
    this.updatedAt,
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
  Patient? patient;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? version;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? statut;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? abonnementActif;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateExpirationAbonnement;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? notesGenerales;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CarnetMedical &&
    other.id == id &&
    other.patient == patient &&
    other.version == version &&
    other.statut == statut &&
    other.abonnementActif == abonnementActif &&
    other.dateExpirationAbonnement == dateExpirationAbonnement &&
    other.notesGenerales == notesGenerales &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (patient == null ? 0 : patient!.hashCode) +
    (version == null ? 0 : version!.hashCode) +
    (statut == null ? 0 : statut!.hashCode) +
    (abonnementActif == null ? 0 : abonnementActif!.hashCode) +
    (dateExpirationAbonnement == null ? 0 : dateExpirationAbonnement!.hashCode) +
    (notesGenerales == null ? 0 : notesGenerales!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'CarnetMedical[id=$id, patient=$patient, version=$version, statut=$statut, abonnementActif=$abonnementActif, dateExpirationAbonnement=$dateExpirationAbonnement, notesGenerales=$notesGenerales, createdAt=$createdAt, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.patient != null) {
      json[r'patient'] = this.patient;
    } else {
      json[r'patient'] = null;
    }
    if (this.version != null) {
      json[r'version'] = this.version;
    } else {
      json[r'version'] = null;
    }
    if (this.statut != null) {
      json[r'statut'] = this.statut;
    } else {
      json[r'statut'] = null;
    }
    if (this.abonnementActif != null) {
      json[r'abonnementActif'] = this.abonnementActif;
    } else {
      json[r'abonnementActif'] = null;
    }
    if (this.dateExpirationAbonnement != null) {
      json[r'dateExpirationAbonnement'] = _dateFormatter.format(this.dateExpirationAbonnement!.toUtc());
    } else {
      json[r'dateExpirationAbonnement'] = null;
    }
    if (this.notesGenerales != null) {
      json[r'notesGenerales'] = this.notesGenerales;
    } else {
      json[r'notesGenerales'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    if (this.updatedAt != null) {
      json[r'updatedAt'] = this.updatedAt!.toUtc().toIso8601String();
    } else {
      json[r'updatedAt'] = null;
    }
    return json;
  }

  /// Returns a new [CarnetMedical] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CarnetMedical? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CarnetMedical[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CarnetMedical[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CarnetMedical(
        id: mapValueOfType<String>(json, r'id'),
        patient: Patient.fromJson(json[r'patient']),
        version: mapValueOfType<int>(json, r'version'),
        statut: mapValueOfType<String>(json, r'statut'),
        abonnementActif: mapValueOfType<bool>(json, r'abonnementActif'),
        dateExpirationAbonnement: mapDateTime(json, r'dateExpirationAbonnement', r''),
        notesGenerales: mapValueOfType<String>(json, r'notesGenerales'),
        createdAt: mapDateTime(json, r'createdAt', r''),
        updatedAt: mapDateTime(json, r'updatedAt', r''),
      );
    }
    return null;
  }

  static List<CarnetMedical> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CarnetMedical>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CarnetMedical.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CarnetMedical> mapFromJson(dynamic json) {
    final map = <String, CarnetMedical>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CarnetMedical.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CarnetMedical-objects as value to a dart map
  static Map<String, List<CarnetMedical>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CarnetMedical>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CarnetMedical.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


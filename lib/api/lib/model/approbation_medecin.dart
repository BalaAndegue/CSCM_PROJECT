//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApprobationMedecin {
  /// Returns a new [ApprobationMedecin] instance.
  ApprobationMedecin({
    this.id,
    this.carnet,
    this.medecin,
    this.approuveParPatient,
    this.dateSignaturePatient,
    this.signaturePatient,
    this.actif,
    this.dateRevocation,
    this.dateExpiration,
    this.approuveParGarant,
    this.dateSignatureGarant,
    this.signatureGarant,
    this.motifRevocation,
    this.accesHistorique,
    this.accesOrdonnances,
    this.acesExamens,
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
  Medecin? medecin;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? approuveParPatient;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateSignaturePatient;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? signaturePatient;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? actif;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateRevocation;

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
  bool? approuveParGarant;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateSignatureGarant;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? signatureGarant;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? motifRevocation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? accesHistorique;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? accesOrdonnances;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? acesExamens;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApprobationMedecin &&
    other.id == id &&
    other.carnet == carnet &&
    other.medecin == medecin &&
    other.approuveParPatient == approuveParPatient &&
    other.dateSignaturePatient == dateSignaturePatient &&
    other.signaturePatient == signaturePatient &&
    other.actif == actif &&
    other.dateRevocation == dateRevocation &&
    other.dateExpiration == dateExpiration &&
    other.approuveParGarant == approuveParGarant &&
    other.dateSignatureGarant == dateSignatureGarant &&
    other.signatureGarant == signatureGarant &&
    other.motifRevocation == motifRevocation &&
    other.accesHistorique == accesHistorique &&
    other.accesOrdonnances == accesOrdonnances &&
    other.acesExamens == acesExamens &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (carnet == null ? 0 : carnet!.hashCode) +
    (medecin == null ? 0 : medecin!.hashCode) +
    (approuveParPatient == null ? 0 : approuveParPatient!.hashCode) +
    (dateSignaturePatient == null ? 0 : dateSignaturePatient!.hashCode) +
    (signaturePatient == null ? 0 : signaturePatient!.hashCode) +
    (actif == null ? 0 : actif!.hashCode) +
    (dateRevocation == null ? 0 : dateRevocation!.hashCode) +
    (dateExpiration == null ? 0 : dateExpiration!.hashCode) +
    (approuveParGarant == null ? 0 : approuveParGarant!.hashCode) +
    (dateSignatureGarant == null ? 0 : dateSignatureGarant!.hashCode) +
    (signatureGarant == null ? 0 : signatureGarant!.hashCode) +
    (motifRevocation == null ? 0 : motifRevocation!.hashCode) +
    (accesHistorique == null ? 0 : accesHistorique!.hashCode) +
    (accesOrdonnances == null ? 0 : accesOrdonnances!.hashCode) +
    (acesExamens == null ? 0 : acesExamens!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'ApprobationMedecin[id=$id, carnet=$carnet, medecin=$medecin, approuveParPatient=$approuveParPatient, dateSignaturePatient=$dateSignaturePatient, signaturePatient=$signaturePatient, actif=$actif, dateRevocation=$dateRevocation, dateExpiration=$dateExpiration, approuveParGarant=$approuveParGarant, dateSignatureGarant=$dateSignatureGarant, signatureGarant=$signatureGarant, motifRevocation=$motifRevocation, accesHistorique=$accesHistorique, accesOrdonnances=$accesOrdonnances, acesExamens=$acesExamens, createdAt=$createdAt]';

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
    if (this.medecin != null) {
      json[r'medecin'] = this.medecin;
    } else {
      json[r'medecin'] = null;
    }
    if (this.approuveParPatient != null) {
      json[r'approuveParPatient'] = this.approuveParPatient;
    } else {
      json[r'approuveParPatient'] = null;
    }
    if (this.dateSignaturePatient != null) {
      json[r'dateSignaturePatient'] = this.dateSignaturePatient!.toUtc().toIso8601String();
    } else {
      json[r'dateSignaturePatient'] = null;
    }
    if (this.signaturePatient != null) {
      json[r'signaturePatient'] = this.signaturePatient;
    } else {
      json[r'signaturePatient'] = null;
    }
    if (this.actif != null) {
      json[r'actif'] = this.actif;
    } else {
      json[r'actif'] = null;
    }
    if (this.dateRevocation != null) {
      json[r'dateRevocation'] = this.dateRevocation!.toUtc().toIso8601String();
    } else {
      json[r'dateRevocation'] = null;
    }
    if (this.dateExpiration != null) {
      json[r'dateExpiration'] = this.dateExpiration!.toUtc().toIso8601String();
    } else {
      json[r'dateExpiration'] = null;
    }
    if (this.approuveParGarant != null) {
      json[r'approuveParGarant'] = this.approuveParGarant;
    } else {
      json[r'approuveParGarant'] = null;
    }
    if (this.dateSignatureGarant != null) {
      json[r'dateSignatureGarant'] = this.dateSignatureGarant!.toUtc().toIso8601String();
    } else {
      json[r'dateSignatureGarant'] = null;
    }
    if (this.signatureGarant != null) {
      json[r'signatureGarant'] = this.signatureGarant;
    } else {
      json[r'signatureGarant'] = null;
    }
    if (this.motifRevocation != null) {
      json[r'motifRevocation'] = this.motifRevocation;
    } else {
      json[r'motifRevocation'] = null;
    }
    if (this.accesHistorique != null) {
      json[r'accesHistorique'] = this.accesHistorique;
    } else {
      json[r'accesHistorique'] = null;
    }
    if (this.accesOrdonnances != null) {
      json[r'accesOrdonnances'] = this.accesOrdonnances;
    } else {
      json[r'accesOrdonnances'] = null;
    }
    if (this.acesExamens != null) {
      json[r'acesExamens'] = this.acesExamens;
    } else {
      json[r'acesExamens'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [ApprobationMedecin] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApprobationMedecin? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ApprobationMedecin[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ApprobationMedecin[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ApprobationMedecin(
        id: mapValueOfType<String>(json, r'id'),
        carnet: CarnetMedical.fromJson(json[r'carnet']),
        medecin: Medecin.fromJson(json[r'medecin']),
        approuveParPatient: mapValueOfType<bool>(json, r'approuveParPatient'),
        dateSignaturePatient: mapDateTime(json, r'dateSignaturePatient', r''),
        signaturePatient: mapValueOfType<String>(json, r'signaturePatient'),
        actif: mapValueOfType<bool>(json, r'actif'),
        dateRevocation: mapDateTime(json, r'dateRevocation', r''),
        dateExpiration: mapDateTime(json, r'dateExpiration', r''),
        approuveParGarant: mapValueOfType<bool>(json, r'approuveParGarant'),
        dateSignatureGarant: mapDateTime(json, r'dateSignatureGarant', r''),
        signatureGarant: mapValueOfType<String>(json, r'signatureGarant'),
        motifRevocation: mapValueOfType<String>(json, r'motifRevocation'),
        accesHistorique: mapValueOfType<bool>(json, r'accesHistorique'),
        accesOrdonnances: mapValueOfType<bool>(json, r'accesOrdonnances'),
        acesExamens: mapValueOfType<bool>(json, r'acesExamens'),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<ApprobationMedecin> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApprobationMedecin>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApprobationMedecin.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApprobationMedecin> mapFromJson(dynamic json) {
    final map = <String, ApprobationMedecin>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApprobationMedecin.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApprobationMedecin-objects as value to a dart map
  static Map<String, List<ApprobationMedecin>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApprobationMedecin>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApprobationMedecin.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


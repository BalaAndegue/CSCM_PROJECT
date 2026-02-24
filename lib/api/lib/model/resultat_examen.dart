//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResultatExamen {
  /// Returns a new [ResultatExamen] instance.
  ResultatExamen({
    this.id,
    this.examen,
    this.fichierResultat,
    this.valeursCles = const {},
    this.interpretation,
    this.conclusion,
    this.medecinLecteur,
    this.dateLecture,
    this.normale,
    this.valeursReference,
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
  Examen? examen;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Document? fichierResultat;

  Map<String, Object> valeursCles;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? interpretation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? conclusion;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Medecin? medecinLecteur;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateLecture;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? normale;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? valeursReference;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResultatExamen &&
    other.id == id &&
    other.examen == examen &&
    other.fichierResultat == fichierResultat &&
    _deepEquality.equals(other.valeursCles, valeursCles) &&
    other.interpretation == interpretation &&
    other.conclusion == conclusion &&
    other.medecinLecteur == medecinLecteur &&
    other.dateLecture == dateLecture &&
    other.normale == normale &&
    other.valeursReference == valeursReference &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (examen == null ? 0 : examen!.hashCode) +
    (fichierResultat == null ? 0 : fichierResultat!.hashCode) +
    (valeursCles.hashCode) +
    (interpretation == null ? 0 : interpretation!.hashCode) +
    (conclusion == null ? 0 : conclusion!.hashCode) +
    (medecinLecteur == null ? 0 : medecinLecteur!.hashCode) +
    (dateLecture == null ? 0 : dateLecture!.hashCode) +
    (normale == null ? 0 : normale!.hashCode) +
    (valeursReference == null ? 0 : valeursReference!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'ResultatExamen[id=$id, examen=$examen, fichierResultat=$fichierResultat, valeursCles=$valeursCles, interpretation=$interpretation, conclusion=$conclusion, medecinLecteur=$medecinLecteur, dateLecture=$dateLecture, normale=$normale, valeursReference=$valeursReference, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.examen != null) {
      json[r'examen'] = this.examen;
    } else {
      json[r'examen'] = null;
    }
    if (this.fichierResultat != null) {
      json[r'fichierResultat'] = this.fichierResultat;
    } else {
      json[r'fichierResultat'] = null;
    }
      json[r'valeursCles'] = this.valeursCles;
    if (this.interpretation != null) {
      json[r'interpretation'] = this.interpretation;
    } else {
      json[r'interpretation'] = null;
    }
    if (this.conclusion != null) {
      json[r'conclusion'] = this.conclusion;
    } else {
      json[r'conclusion'] = null;
    }
    if (this.medecinLecteur != null) {
      json[r'medecinLecteur'] = this.medecinLecteur;
    } else {
      json[r'medecinLecteur'] = null;
    }
    if (this.dateLecture != null) {
      json[r'dateLecture'] = this.dateLecture!.toUtc().toIso8601String();
    } else {
      json[r'dateLecture'] = null;
    }
    if (this.normale != null) {
      json[r'normale'] = this.normale;
    } else {
      json[r'normale'] = null;
    }
    if (this.valeursReference != null) {
      json[r'valeursReference'] = this.valeursReference;
    } else {
      json[r'valeursReference'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [ResultatExamen] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResultatExamen? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ResultatExamen[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ResultatExamen[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ResultatExamen(
        id: mapValueOfType<String>(json, r'id'),
        examen: Examen.fromJson(json[r'examen']),
        fichierResultat: Document.fromJson(json[r'fichierResultat']),
        valeursCles: mapCastOfType<String, Object>(json, r'valeursCles') ?? const {},
        interpretation: mapValueOfType<String>(json, r'interpretation'),
        conclusion: mapValueOfType<String>(json, r'conclusion'),
        medecinLecteur: Medecin.fromJson(json[r'medecinLecteur']),
        dateLecture: mapDateTime(json, r'dateLecture', r''),
        normale: mapValueOfType<bool>(json, r'normale'),
        valeursReference: mapValueOfType<String>(json, r'valeursReference'),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<ResultatExamen> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResultatExamen>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResultatExamen.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResultatExamen> mapFromJson(dynamic json) {
    final map = <String, ResultatExamen>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResultatExamen.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResultatExamen-objects as value to a dart map
  static Map<String, List<ResultatExamen>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResultatExamen>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ResultatExamen.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


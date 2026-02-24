//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Examen {
  /// Returns a new [Examen] instance.
  Examen({
    this.id,
    this.carnet,
    this.medecinPrescripteur,
    this.consultation,
    this.typeExamen,
    this.categorieExamen,
    this.instructions,
    this.datePrescription,
    this.dateRealisation,
    this.etablissementRealisation,
    this.resultatPrisEnCompte,
    this.urgent,
    this.notes,
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
  Medecin? medecinPrescripteur;

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
  String? typeExamen;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? categorieExamen;

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
  DateTime? datePrescription;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateRealisation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? etablissementRealisation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? resultatPrisEnCompte;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? urgent;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? notes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Examen &&
    other.id == id &&
    other.carnet == carnet &&
    other.medecinPrescripteur == medecinPrescripteur &&
    other.consultation == consultation &&
    other.typeExamen == typeExamen &&
    other.categorieExamen == categorieExamen &&
    other.instructions == instructions &&
    other.datePrescription == datePrescription &&
    other.dateRealisation == dateRealisation &&
    other.etablissementRealisation == etablissementRealisation &&
    other.resultatPrisEnCompte == resultatPrisEnCompte &&
    other.urgent == urgent &&
    other.notes == notes &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (carnet == null ? 0 : carnet!.hashCode) +
    (medecinPrescripteur == null ? 0 : medecinPrescripteur!.hashCode) +
    (consultation == null ? 0 : consultation!.hashCode) +
    (typeExamen == null ? 0 : typeExamen!.hashCode) +
    (categorieExamen == null ? 0 : categorieExamen!.hashCode) +
    (instructions == null ? 0 : instructions!.hashCode) +
    (datePrescription == null ? 0 : datePrescription!.hashCode) +
    (dateRealisation == null ? 0 : dateRealisation!.hashCode) +
    (etablissementRealisation == null ? 0 : etablissementRealisation!.hashCode) +
    (resultatPrisEnCompte == null ? 0 : resultatPrisEnCompte!.hashCode) +
    (urgent == null ? 0 : urgent!.hashCode) +
    (notes == null ? 0 : notes!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'Examen[id=$id, carnet=$carnet, medecinPrescripteur=$medecinPrescripteur, consultation=$consultation, typeExamen=$typeExamen, categorieExamen=$categorieExamen, instructions=$instructions, datePrescription=$datePrescription, dateRealisation=$dateRealisation, etablissementRealisation=$etablissementRealisation, resultatPrisEnCompte=$resultatPrisEnCompte, urgent=$urgent, notes=$notes, createdAt=$createdAt]';

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
    if (this.medecinPrescripteur != null) {
      json[r'medecinPrescripteur'] = this.medecinPrescripteur;
    } else {
      json[r'medecinPrescripteur'] = null;
    }
    if (this.consultation != null) {
      json[r'consultation'] = this.consultation;
    } else {
      json[r'consultation'] = null;
    }
    if (this.typeExamen != null) {
      json[r'typeExamen'] = this.typeExamen;
    } else {
      json[r'typeExamen'] = null;
    }
    if (this.categorieExamen != null) {
      json[r'categorieExamen'] = this.categorieExamen;
    } else {
      json[r'categorieExamen'] = null;
    }
    if (this.instructions != null) {
      json[r'instructions'] = this.instructions;
    } else {
      json[r'instructions'] = null;
    }
    if (this.datePrescription != null) {
      json[r'datePrescription'] = this.datePrescription!.toUtc().toIso8601String();
    } else {
      json[r'datePrescription'] = null;
    }
    if (this.dateRealisation != null) {
      json[r'dateRealisation'] = this.dateRealisation!.toUtc().toIso8601String();
    } else {
      json[r'dateRealisation'] = null;
    }
    if (this.etablissementRealisation != null) {
      json[r'etablissementRealisation'] = this.etablissementRealisation;
    } else {
      json[r'etablissementRealisation'] = null;
    }
    if (this.resultatPrisEnCompte != null) {
      json[r'resultatPrisEnCompte'] = this.resultatPrisEnCompte;
    } else {
      json[r'resultatPrisEnCompte'] = null;
    }
    if (this.urgent != null) {
      json[r'urgent'] = this.urgent;
    } else {
      json[r'urgent'] = null;
    }
    if (this.notes != null) {
      json[r'notes'] = this.notes;
    } else {
      json[r'notes'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [Examen] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Examen? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Examen[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Examen[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Examen(
        id: mapValueOfType<String>(json, r'id'),
        carnet: CarnetMedical.fromJson(json[r'carnet']),
        medecinPrescripteur: Medecin.fromJson(json[r'medecinPrescripteur']),
        consultation: Consultation.fromJson(json[r'consultation']),
        typeExamen: mapValueOfType<String>(json, r'typeExamen'),
        categorieExamen: mapValueOfType<String>(json, r'categorieExamen'),
        instructions: mapValueOfType<String>(json, r'instructions'),
        datePrescription: mapDateTime(json, r'datePrescription', r''),
        dateRealisation: mapDateTime(json, r'dateRealisation', r''),
        etablissementRealisation: mapValueOfType<String>(json, r'etablissementRealisation'),
        resultatPrisEnCompte: mapValueOfType<bool>(json, r'resultatPrisEnCompte'),
        urgent: mapValueOfType<bool>(json, r'urgent'),
        notes: mapValueOfType<String>(json, r'notes'),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<Examen> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Examen>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Examen.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Examen> mapFromJson(dynamic json) {
    final map = <String, Examen>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Examen.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Examen-objects as value to a dart map
  static Map<String, List<Examen>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Examen>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Examen.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


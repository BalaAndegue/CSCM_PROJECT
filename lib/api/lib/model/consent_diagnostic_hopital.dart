//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ConsentDiagnosticHopital {
  /// Returns a new [ConsentDiagnosticHopital] instance.
  ConsentDiagnosticHopital({
    this.id,
    this.consultation,
    this.medecin,
    this.hopital,
    this.motifDemande,
    this.demandeParMedecin,
    this.approuveParManager,
    this.manager,
    this.dateApprouvation,
    this.motifRefus,
    this.dateExpiration,
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
  String? motifDemande;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? demandeParMedecin;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? approuveParManager;

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
  DateTime? dateApprouvation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? motifRefus;

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
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ConsentDiagnosticHopital &&
    other.id == id &&
    other.consultation == consultation &&
    other.medecin == medecin &&
    other.hopital == hopital &&
    other.motifDemande == motifDemande &&
    other.demandeParMedecin == demandeParMedecin &&
    other.approuveParManager == approuveParManager &&
    other.manager == manager &&
    other.dateApprouvation == dateApprouvation &&
    other.motifRefus == motifRefus &&
    other.dateExpiration == dateExpiration &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (consultation == null ? 0 : consultation!.hashCode) +
    (medecin == null ? 0 : medecin!.hashCode) +
    (hopital == null ? 0 : hopital!.hashCode) +
    (motifDemande == null ? 0 : motifDemande!.hashCode) +
    (demandeParMedecin == null ? 0 : demandeParMedecin!.hashCode) +
    (approuveParManager == null ? 0 : approuveParManager!.hashCode) +
    (manager == null ? 0 : manager!.hashCode) +
    (dateApprouvation == null ? 0 : dateApprouvation!.hashCode) +
    (motifRefus == null ? 0 : motifRefus!.hashCode) +
    (dateExpiration == null ? 0 : dateExpiration!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'ConsentDiagnosticHopital[id=$id, consultation=$consultation, medecin=$medecin, hopital=$hopital, motifDemande=$motifDemande, demandeParMedecin=$demandeParMedecin, approuveParManager=$approuveParManager, manager=$manager, dateApprouvation=$dateApprouvation, motifRefus=$motifRefus, dateExpiration=$dateExpiration, createdAt=$createdAt]';

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
    if (this.motifDemande != null) {
      json[r'motifDemande'] = this.motifDemande;
    } else {
      json[r'motifDemande'] = null;
    }
    if (this.demandeParMedecin != null) {
      json[r'demandeParMedecin'] = this.demandeParMedecin!.toUtc().toIso8601String();
    } else {
      json[r'demandeParMedecin'] = null;
    }
    if (this.approuveParManager != null) {
      json[r'approuveParManager'] = this.approuveParManager;
    } else {
      json[r'approuveParManager'] = null;
    }
    if (this.manager != null) {
      json[r'manager'] = this.manager;
    } else {
      json[r'manager'] = null;
    }
    if (this.dateApprouvation != null) {
      json[r'dateApprouvation'] = this.dateApprouvation!.toUtc().toIso8601String();
    } else {
      json[r'dateApprouvation'] = null;
    }
    if (this.motifRefus != null) {
      json[r'motifRefus'] = this.motifRefus;
    } else {
      json[r'motifRefus'] = null;
    }
    if (this.dateExpiration != null) {
      json[r'dateExpiration'] = this.dateExpiration!.toUtc().toIso8601String();
    } else {
      json[r'dateExpiration'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [ConsentDiagnosticHopital] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConsentDiagnosticHopital? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ConsentDiagnosticHopital[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ConsentDiagnosticHopital[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ConsentDiagnosticHopital(
        id: mapValueOfType<String>(json, r'id'),
        consultation: Consultation.fromJson(json[r'consultation']),
        medecin: Medecin.fromJson(json[r'medecin']),
        hopital: Hopital.fromJson(json[r'hopital']),
        motifDemande: mapValueOfType<String>(json, r'motifDemande'),
        demandeParMedecin: mapDateTime(json, r'demandeParMedecin', r''),
        approuveParManager: mapValueOfType<bool>(json, r'approuveParManager'),
        manager: User.fromJson(json[r'manager']),
        dateApprouvation: mapDateTime(json, r'dateApprouvation', r''),
        motifRefus: mapValueOfType<String>(json, r'motifRefus'),
        dateExpiration: mapDateTime(json, r'dateExpiration', r''),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<ConsentDiagnosticHopital> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConsentDiagnosticHopital>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConsentDiagnosticHopital.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConsentDiagnosticHopital> mapFromJson(dynamic json) {
    final map = <String, ConsentDiagnosticHopital>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConsentDiagnosticHopital.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConsentDiagnosticHopital-objects as value to a dart map
  static Map<String, List<ConsentDiagnosticHopital>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ConsentDiagnosticHopital>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConsentDiagnosticHopital.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


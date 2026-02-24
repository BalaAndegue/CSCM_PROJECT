//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MedecinHopital {
  /// Returns a new [MedecinHopital] instance.
  MedecinHopital({
    this.id,
    this.medecin,
    this.hopital,
    this.actif,
    this.service,
    this.poste,
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
  bool? actif;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? service;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? poste;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MedecinHopital &&
    other.id == id &&
    other.medecin == medecin &&
    other.hopital == hopital &&
    other.actif == actif &&
    other.service == service &&
    other.poste == poste &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (medecin == null ? 0 : medecin!.hashCode) +
    (hopital == null ? 0 : hopital!.hashCode) +
    (actif == null ? 0 : actif!.hashCode) +
    (service == null ? 0 : service!.hashCode) +
    (poste == null ? 0 : poste!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'MedecinHopital[id=$id, medecin=$medecin, hopital=$hopital, actif=$actif, service=$service, poste=$poste, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
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
    if (this.actif != null) {
      json[r'actif'] = this.actif;
    } else {
      json[r'actif'] = null;
    }
    if (this.service != null) {
      json[r'service'] = this.service;
    } else {
      json[r'service'] = null;
    }
    if (this.poste != null) {
      json[r'poste'] = this.poste;
    } else {
      json[r'poste'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [MedecinHopital] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MedecinHopital? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MedecinHopital[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MedecinHopital[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MedecinHopital(
        id: mapValueOfType<String>(json, r'id'),
        medecin: Medecin.fromJson(json[r'medecin']),
        hopital: Hopital.fromJson(json[r'hopital']),
        actif: mapValueOfType<bool>(json, r'actif'),
        service: mapValueOfType<String>(json, r'service'),
        poste: mapValueOfType<String>(json, r'poste'),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<MedecinHopital> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MedecinHopital>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MedecinHopital.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MedecinHopital> mapFromJson(dynamic json) {
    final map = <String, MedecinHopital>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MedecinHopital.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MedecinHopital-objects as value to a dart map
  static Map<String, List<MedecinHopital>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MedecinHopital>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MedecinHopital.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


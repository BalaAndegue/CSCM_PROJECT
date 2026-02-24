//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateMedecinRequest {
  /// Returns a new [UpdateMedecinRequest] instance.
  UpdateMedecinRequest({
    this.specialite,
    this.sousSpecialite,
    this.biographie,
    this.anneesExperience,
    this.consultationFee,
    this.diplomes = const [],
  });

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
  String? biographie;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? anneesExperience;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? consultationFee;

  List<String> diplomes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateMedecinRequest &&
    other.specialite == specialite &&
    other.sousSpecialite == sousSpecialite &&
    other.biographie == biographie &&
    other.anneesExperience == anneesExperience &&
    other.consultationFee == consultationFee &&
    _deepEquality.equals(other.diplomes, diplomes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (specialite == null ? 0 : specialite!.hashCode) +
    (sousSpecialite == null ? 0 : sousSpecialite!.hashCode) +
    (biographie == null ? 0 : biographie!.hashCode) +
    (anneesExperience == null ? 0 : anneesExperience!.hashCode) +
    (consultationFee == null ? 0 : consultationFee!.hashCode) +
    (diplomes.hashCode);

  @override
  String toString() => 'UpdateMedecinRequest[specialite=$specialite, sousSpecialite=$sousSpecialite, biographie=$biographie, anneesExperience=$anneesExperience, consultationFee=$consultationFee, diplomes=$diplomes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
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
    if (this.biographie != null) {
      json[r'biographie'] = this.biographie;
    } else {
      json[r'biographie'] = null;
    }
    if (this.anneesExperience != null) {
      json[r'anneesExperience'] = this.anneesExperience;
    } else {
      json[r'anneesExperience'] = null;
    }
    if (this.consultationFee != null) {
      json[r'consultationFee'] = this.consultationFee;
    } else {
      json[r'consultationFee'] = null;
    }
      json[r'diplomes'] = this.diplomes;
    return json;
  }

  /// Returns a new [UpdateMedecinRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateMedecinRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateMedecinRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateMedecinRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateMedecinRequest(
        specialite: mapValueOfType<String>(json, r'specialite'),
        sousSpecialite: mapValueOfType<String>(json, r'sousSpecialite'),
        biographie: mapValueOfType<String>(json, r'biographie'),
        anneesExperience: mapValueOfType<int>(json, r'anneesExperience'),
        consultationFee: mapValueOfType<double>(json, r'consultationFee'),
        diplomes: json[r'diplomes'] is Iterable
            ? (json[r'diplomes'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<UpdateMedecinRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateMedecinRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateMedecinRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateMedecinRequest> mapFromJson(dynamic json) {
    final map = <String, UpdateMedecinRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateMedecinRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateMedecinRequest-objects as value to a dart map
  static Map<String, List<UpdateMedecinRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateMedecinRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateMedecinRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


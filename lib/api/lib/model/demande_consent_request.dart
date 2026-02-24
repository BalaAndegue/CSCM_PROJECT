//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DemandeConsentRequest {
  /// Returns a new [DemandeConsentRequest] instance.
  DemandeConsentRequest({
    this.consultationId,
    this.hopitalId,
    this.motif,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? consultationId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? hopitalId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? motif;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DemandeConsentRequest &&
    other.consultationId == consultationId &&
    other.hopitalId == hopitalId &&
    other.motif == motif;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (consultationId == null ? 0 : consultationId!.hashCode) +
    (hopitalId == null ? 0 : hopitalId!.hashCode) +
    (motif == null ? 0 : motif!.hashCode);

  @override
  String toString() => 'DemandeConsentRequest[consultationId=$consultationId, hopitalId=$hopitalId, motif=$motif]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.consultationId != null) {
      json[r'consultationId'] = this.consultationId;
    } else {
      json[r'consultationId'] = null;
    }
    if (this.hopitalId != null) {
      json[r'hopitalId'] = this.hopitalId;
    } else {
      json[r'hopitalId'] = null;
    }
    if (this.motif != null) {
      json[r'motif'] = this.motif;
    } else {
      json[r'motif'] = null;
    }
    return json;
  }

  /// Returns a new [DemandeConsentRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DemandeConsentRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DemandeConsentRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DemandeConsentRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DemandeConsentRequest(
        consultationId: mapValueOfType<String>(json, r'consultationId'),
        hopitalId: mapValueOfType<String>(json, r'hopitalId'),
        motif: mapValueOfType<String>(json, r'motif'),
      );
    }
    return null;
  }

  static List<DemandeConsentRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DemandeConsentRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DemandeConsentRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DemandeConsentRequest> mapFromJson(dynamic json) {
    final map = <String, DemandeConsentRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DemandeConsentRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DemandeConsentRequest-objects as value to a dart map
  static Map<String, List<DemandeConsentRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DemandeConsentRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DemandeConsentRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


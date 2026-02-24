//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RegisterMedecinRequest {
  /// Returns a new [RegisterMedecinRequest] instance.
  RegisterMedecinRequest({
    required this.email,
    required this.motDePasse,
    required this.nomComplet,
    this.telephone,
    required this.specialite,
    required this.numeroOrdre,
    this.numeroCarteProfessionnelle,
  });

  String email;

  String motDePasse;

  String nomComplet;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? telephone;

  String specialite;

  String numeroOrdre;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? numeroCarteProfessionnelle;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RegisterMedecinRequest &&
    other.email == email &&
    other.motDePasse == motDePasse &&
    other.nomComplet == nomComplet &&
    other.telephone == telephone &&
    other.specialite == specialite &&
    other.numeroOrdre == numeroOrdre &&
    other.numeroCarteProfessionnelle == numeroCarteProfessionnelle;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email.hashCode) +
    (motDePasse.hashCode) +
    (nomComplet.hashCode) +
    (telephone == null ? 0 : telephone!.hashCode) +
    (specialite.hashCode) +
    (numeroOrdre.hashCode) +
    (numeroCarteProfessionnelle == null ? 0 : numeroCarteProfessionnelle!.hashCode);

  @override
  String toString() => 'RegisterMedecinRequest[email=$email, motDePasse=$motDePasse, nomComplet=$nomComplet, telephone=$telephone, specialite=$specialite, numeroOrdre=$numeroOrdre, numeroCarteProfessionnelle=$numeroCarteProfessionnelle]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'email'] = this.email;
      json[r'motDePasse'] = this.motDePasse;
      json[r'nomComplet'] = this.nomComplet;
    if (this.telephone != null) {
      json[r'telephone'] = this.telephone;
    } else {
      json[r'telephone'] = null;
    }
      json[r'specialite'] = this.specialite;
      json[r'numeroOrdre'] = this.numeroOrdre;
    if (this.numeroCarteProfessionnelle != null) {
      json[r'numeroCarteProfessionnelle'] = this.numeroCarteProfessionnelle;
    } else {
      json[r'numeroCarteProfessionnelle'] = null;
    }
    return json;
  }

  /// Returns a new [RegisterMedecinRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RegisterMedecinRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RegisterMedecinRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RegisterMedecinRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RegisterMedecinRequest(
        email: mapValueOfType<String>(json, r'email')!,
        motDePasse: mapValueOfType<String>(json, r'motDePasse')!,
        nomComplet: mapValueOfType<String>(json, r'nomComplet')!,
        telephone: mapValueOfType<String>(json, r'telephone'),
        specialite: mapValueOfType<String>(json, r'specialite')!,
        numeroOrdre: mapValueOfType<String>(json, r'numeroOrdre')!,
        numeroCarteProfessionnelle: mapValueOfType<String>(json, r'numeroCarteProfessionnelle'),
      );
    }
    return null;
  }

  static List<RegisterMedecinRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RegisterMedecinRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RegisterMedecinRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RegisterMedecinRequest> mapFromJson(dynamic json) {
    final map = <String, RegisterMedecinRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RegisterMedecinRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RegisterMedecinRequest-objects as value to a dart map
  static Map<String, List<RegisterMedecinRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RegisterMedecinRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RegisterMedecinRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'email',
    'motDePasse',
    'nomComplet',
    'specialite',
    'numeroOrdre',
  };
}


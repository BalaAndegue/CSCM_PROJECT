//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RegisterPatientRequest {
  /// Returns a new [RegisterPatientRequest] instance.
  RegisterPatientRequest({
    required this.email,
    required this.motDePasse,
    required this.nomComplet,
    this.telephone,
    required this.dateNaissance,
    required this.genre,
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

  DateTime dateNaissance;

  RegisterPatientRequestGenreEnum genre;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RegisterPatientRequest &&
    other.email == email &&
    other.motDePasse == motDePasse &&
    other.nomComplet == nomComplet &&
    other.telephone == telephone &&
    other.dateNaissance == dateNaissance &&
    other.genre == genre;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email.hashCode) +
    (motDePasse.hashCode) +
    (nomComplet.hashCode) +
    (telephone == null ? 0 : telephone!.hashCode) +
    (dateNaissance.hashCode) +
    (genre.hashCode);

  @override
  String toString() => 'RegisterPatientRequest[email=$email, motDePasse=$motDePasse, nomComplet=$nomComplet, telephone=$telephone, dateNaissance=$dateNaissance, genre=$genre]';

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
      json[r'dateNaissance'] = _dateFormatter.format(this.dateNaissance.toUtc());
      json[r'genre'] = this.genre;
    return json;
  }

  /// Returns a new [RegisterPatientRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RegisterPatientRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RegisterPatientRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RegisterPatientRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RegisterPatientRequest(
        email: mapValueOfType<String>(json, r'email')!,
        motDePasse: mapValueOfType<String>(json, r'motDePasse')!,
        nomComplet: mapValueOfType<String>(json, r'nomComplet')!,
        telephone: mapValueOfType<String>(json, r'telephone'),
        dateNaissance: mapDateTime(json, r'dateNaissance', r'')!,
        genre: RegisterPatientRequestGenreEnum.fromJson(json[r'genre'])!,
      );
    }
    return null;
  }

  static List<RegisterPatientRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RegisterPatientRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RegisterPatientRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RegisterPatientRequest> mapFromJson(dynamic json) {
    final map = <String, RegisterPatientRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RegisterPatientRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RegisterPatientRequest-objects as value to a dart map
  static Map<String, List<RegisterPatientRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RegisterPatientRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RegisterPatientRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'email',
    'motDePasse',
    'nomComplet',
    'dateNaissance',
    'genre',
  };
}


class RegisterPatientRequestGenreEnum {
  /// Instantiate a new enum with the provided [value].
  const RegisterPatientRequestGenreEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const M = RegisterPatientRequestGenreEnum._(r'M');
  static const F = RegisterPatientRequestGenreEnum._(r'F');
  static const AUTRE = RegisterPatientRequestGenreEnum._(r'AUTRE');

  /// List of all possible values in this [enum][RegisterPatientRequestGenreEnum].
  static const values = <RegisterPatientRequestGenreEnum>[
    M,
    F,
    AUTRE,
  ];

  static RegisterPatientRequestGenreEnum? fromJson(dynamic value) => RegisterPatientRequestGenreEnumTypeTransformer().decode(value);

  static List<RegisterPatientRequestGenreEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RegisterPatientRequestGenreEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RegisterPatientRequestGenreEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [RegisterPatientRequestGenreEnum] to String,
/// and [decode] dynamic data back to [RegisterPatientRequestGenreEnum].
class RegisterPatientRequestGenreEnumTypeTransformer {
  factory RegisterPatientRequestGenreEnumTypeTransformer() => _instance ??= const RegisterPatientRequestGenreEnumTypeTransformer._();

  const RegisterPatientRequestGenreEnumTypeTransformer._();

  String encode(RegisterPatientRequestGenreEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a RegisterPatientRequestGenreEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RegisterPatientRequestGenreEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'M': return RegisterPatientRequestGenreEnum.M;
        case r'F': return RegisterPatientRequestGenreEnum.F;
        case r'AUTRE': return RegisterPatientRequestGenreEnum.AUTRE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [RegisterPatientRequestGenreEnumTypeTransformer] instance.
  static RegisterPatientRequestGenreEnumTypeTransformer? _instance;
}



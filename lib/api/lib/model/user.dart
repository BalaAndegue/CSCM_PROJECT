//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class User {
  /// Returns a new [User] instance.
  User({
    this.id,
    this.email,
    this.motDePasseHash,
    this.role,
    this.nomComplet,
    this.telephone,
    this.emailVerifie,
    this.telephoneVerifie,
    this.deuxFacteurs,
    this.deuxFacteursSecret,
    this.compteActif,
    this.derniereConnexion,
    this.tokenReinitialisation,
    this.tokenReinitExpireAt,
    this.tokenVerificationEmail,
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
  String? email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? motDePasseHash;

  UserRoleEnum? role;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nomComplet;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? telephone;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? emailVerifie;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? telephoneVerifie;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? deuxFacteurs;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? deuxFacteursSecret;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? compteActif;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? derniereConnexion;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tokenReinitialisation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? tokenReinitExpireAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tokenVerificationEmail;

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
  bool operator ==(Object other) => identical(this, other) || other is User &&
    other.id == id &&
    other.email == email &&
    other.motDePasseHash == motDePasseHash &&
    other.role == role &&
    other.nomComplet == nomComplet &&
    other.telephone == telephone &&
    other.emailVerifie == emailVerifie &&
    other.telephoneVerifie == telephoneVerifie &&
    other.deuxFacteurs == deuxFacteurs &&
    other.deuxFacteursSecret == deuxFacteursSecret &&
    other.compteActif == compteActif &&
    other.derniereConnexion == derniereConnexion &&
    other.tokenReinitialisation == tokenReinitialisation &&
    other.tokenReinitExpireAt == tokenReinitExpireAt &&
    other.tokenVerificationEmail == tokenVerificationEmail &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (motDePasseHash == null ? 0 : motDePasseHash!.hashCode) +
    (role == null ? 0 : role!.hashCode) +
    (nomComplet == null ? 0 : nomComplet!.hashCode) +
    (telephone == null ? 0 : telephone!.hashCode) +
    (emailVerifie == null ? 0 : emailVerifie!.hashCode) +
    (telephoneVerifie == null ? 0 : telephoneVerifie!.hashCode) +
    (deuxFacteurs == null ? 0 : deuxFacteurs!.hashCode) +
    (deuxFacteursSecret == null ? 0 : deuxFacteursSecret!.hashCode) +
    (compteActif == null ? 0 : compteActif!.hashCode) +
    (derniereConnexion == null ? 0 : derniereConnexion!.hashCode) +
    (tokenReinitialisation == null ? 0 : tokenReinitialisation!.hashCode) +
    (tokenReinitExpireAt == null ? 0 : tokenReinitExpireAt!.hashCode) +
    (tokenVerificationEmail == null ? 0 : tokenVerificationEmail!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'User[id=$id, email=$email, motDePasseHash=$motDePasseHash, role=$role, nomComplet=$nomComplet, telephone=$telephone, emailVerifie=$emailVerifie, telephoneVerifie=$telephoneVerifie, deuxFacteurs=$deuxFacteurs, deuxFacteursSecret=$deuxFacteursSecret, compteActif=$compteActif, derniereConnexion=$derniereConnexion, tokenReinitialisation=$tokenReinitialisation, tokenReinitExpireAt=$tokenReinitExpireAt, tokenVerificationEmail=$tokenVerificationEmail, createdAt=$createdAt, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.motDePasseHash != null) {
      json[r'motDePasseHash'] = this.motDePasseHash;
    } else {
      json[r'motDePasseHash'] = null;
    }
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
    if (this.nomComplet != null) {
      json[r'nomComplet'] = this.nomComplet;
    } else {
      json[r'nomComplet'] = null;
    }
    if (this.telephone != null) {
      json[r'telephone'] = this.telephone;
    } else {
      json[r'telephone'] = null;
    }
    if (this.emailVerifie != null) {
      json[r'emailVerifie'] = this.emailVerifie;
    } else {
      json[r'emailVerifie'] = null;
    }
    if (this.telephoneVerifie != null) {
      json[r'telephoneVerifie'] = this.telephoneVerifie;
    } else {
      json[r'telephoneVerifie'] = null;
    }
    if (this.deuxFacteurs != null) {
      json[r'deuxFacteurs'] = this.deuxFacteurs;
    } else {
      json[r'deuxFacteurs'] = null;
    }
    if (this.deuxFacteursSecret != null) {
      json[r'deuxFacteursSecret'] = this.deuxFacteursSecret;
    } else {
      json[r'deuxFacteursSecret'] = null;
    }
    if (this.compteActif != null) {
      json[r'compteActif'] = this.compteActif;
    } else {
      json[r'compteActif'] = null;
    }
    if (this.derniereConnexion != null) {
      json[r'derniereConnexion'] = this.derniereConnexion!.toUtc().toIso8601String();
    } else {
      json[r'derniereConnexion'] = null;
    }
    if (this.tokenReinitialisation != null) {
      json[r'tokenReinitialisation'] = this.tokenReinitialisation;
    } else {
      json[r'tokenReinitialisation'] = null;
    }
    if (this.tokenReinitExpireAt != null) {
      json[r'tokenReinitExpireAt'] = this.tokenReinitExpireAt!.toUtc().toIso8601String();
    } else {
      json[r'tokenReinitExpireAt'] = null;
    }
    if (this.tokenVerificationEmail != null) {
      json[r'tokenVerificationEmail'] = this.tokenVerificationEmail;
    } else {
      json[r'tokenVerificationEmail'] = null;
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

  /// Returns a new [User] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static User? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "User[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "User[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return User(
        id: mapValueOfType<String>(json, r'id'),
        email: mapValueOfType<String>(json, r'email'),
        motDePasseHash: mapValueOfType<String>(json, r'motDePasseHash'),
        role: UserRoleEnum.fromJson(json[r'role']),
        nomComplet: mapValueOfType<String>(json, r'nomComplet'),
        telephone: mapValueOfType<String>(json, r'telephone'),
        emailVerifie: mapValueOfType<bool>(json, r'emailVerifie'),
        telephoneVerifie: mapValueOfType<bool>(json, r'telephoneVerifie'),
        deuxFacteurs: mapValueOfType<bool>(json, r'deuxFacteurs'),
        deuxFacteursSecret: mapValueOfType<String>(json, r'deuxFacteursSecret'),
        compteActif: mapValueOfType<bool>(json, r'compteActif'),
        derniereConnexion: mapDateTime(json, r'derniereConnexion', r''),
        tokenReinitialisation: mapValueOfType<String>(json, r'tokenReinitialisation'),
        tokenReinitExpireAt: mapDateTime(json, r'tokenReinitExpireAt', r''),
        tokenVerificationEmail: mapValueOfType<String>(json, r'tokenVerificationEmail'),
        createdAt: mapDateTime(json, r'createdAt', r''),
        updatedAt: mapDateTime(json, r'updatedAt', r''),
      );
    }
    return null;
  }

  static List<User> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <User>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = User.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, User> mapFromJson(dynamic json) {
    final map = <String, User>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = User.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of User-objects as value to a dart map
  static Map<String, List<User>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<User>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = User.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class UserRoleEnum {
  /// Instantiate a new enum with the provided [value].
  const UserRoleEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const PATIENT = UserRoleEnum._(r'PATIENT');
  static const MEDECIN = UserRoleEnum._(r'MEDECIN');
  static const ADMIN = UserRoleEnum._(r'ADMIN');
  static const MANAGER_HOPITAL = UserRoleEnum._(r'MANAGER_HOPITAL');

  /// List of all possible values in this [enum][UserRoleEnum].
  static const values = <UserRoleEnum>[
    PATIENT,
    MEDECIN,
    ADMIN,
    MANAGER_HOPITAL,
  ];

  static UserRoleEnum? fromJson(dynamic value) => UserRoleEnumTypeTransformer().decode(value);

  static List<UserRoleEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserRoleEnum] to String,
/// and [decode] dynamic data back to [UserRoleEnum].
class UserRoleEnumTypeTransformer {
  factory UserRoleEnumTypeTransformer() => _instance ??= const UserRoleEnumTypeTransformer._();

  const UserRoleEnumTypeTransformer._();

  String encode(UserRoleEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UserRoleEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'PATIENT': return UserRoleEnum.PATIENT;
        case r'MEDECIN': return UserRoleEnum.MEDECIN;
        case r'ADMIN': return UserRoleEnum.ADMIN;
        case r'MANAGER_HOPITAL': return UserRoleEnum.MANAGER_HOPITAL;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserRoleEnumTypeTransformer] instance.
  static UserRoleEnumTypeTransformer? _instance;
}



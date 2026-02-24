//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Patient {
  /// Returns a new [Patient] instance.
  Patient({
    this.id,
    this.user,
    this.numeroCarnet,
    this.dateNaissance,
    this.genre,
    this.adresse,
    this.telephone,
    this.situationFamiliale,
    this.profession,
    this.antecedentsChirurgicaux,
    this.antecedentsFamiliaux,
    this.antecedentsMedicaux,
    this.groupeSanguin,
    this.dateVerificationAboRh,
    this.medecinTraitantId,
    this.contactUrgenceNom,
    this.contactUrgenceTelephone,
    this.garantNomComplet,
    this.garantTelephone,
    this.garantEmail,
    this.garantLienParente,
    this.garantUserId,
    this.photoProfil,
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
  User? user;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? numeroCarnet;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateNaissance;

  PatientGenreEnum? genre;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? adresse;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? telephone;

  PatientSituationFamilialeEnum? situationFamiliale;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? profession;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? antecedentsChirurgicaux;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? antecedentsFamiliaux;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? antecedentsMedicaux;

  PatientGroupeSanguinEnum? groupeSanguin;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? dateVerificationAboRh;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? medecinTraitantId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? contactUrgenceNom;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? contactUrgenceTelephone;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? garantNomComplet;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? garantTelephone;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? garantEmail;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? garantLienParente;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? garantUserId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? photoProfil;

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
  bool operator ==(Object other) => identical(this, other) || other is Patient &&
    other.id == id &&
    other.user == user &&
    other.numeroCarnet == numeroCarnet &&
    other.dateNaissance == dateNaissance &&
    other.genre == genre &&
    other.adresse == adresse &&
    other.telephone == telephone &&
    other.situationFamiliale == situationFamiliale &&
    other.profession == profession &&
    other.antecedentsChirurgicaux == antecedentsChirurgicaux &&
    other.antecedentsFamiliaux == antecedentsFamiliaux &&
    other.antecedentsMedicaux == antecedentsMedicaux &&
    other.groupeSanguin == groupeSanguin &&
    other.dateVerificationAboRh == dateVerificationAboRh &&
    other.medecinTraitantId == medecinTraitantId &&
    other.contactUrgenceNom == contactUrgenceNom &&
    other.contactUrgenceTelephone == contactUrgenceTelephone &&
    other.garantNomComplet == garantNomComplet &&
    other.garantTelephone == garantTelephone &&
    other.garantEmail == garantEmail &&
    other.garantLienParente == garantLienParente &&
    other.garantUserId == garantUserId &&
    other.photoProfil == photoProfil &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (user == null ? 0 : user!.hashCode) +
    (numeroCarnet == null ? 0 : numeroCarnet!.hashCode) +
    (dateNaissance == null ? 0 : dateNaissance!.hashCode) +
    (genre == null ? 0 : genre!.hashCode) +
    (adresse == null ? 0 : adresse!.hashCode) +
    (telephone == null ? 0 : telephone!.hashCode) +
    (situationFamiliale == null ? 0 : situationFamiliale!.hashCode) +
    (profession == null ? 0 : profession!.hashCode) +
    (antecedentsChirurgicaux == null ? 0 : antecedentsChirurgicaux!.hashCode) +
    (antecedentsFamiliaux == null ? 0 : antecedentsFamiliaux!.hashCode) +
    (antecedentsMedicaux == null ? 0 : antecedentsMedicaux!.hashCode) +
    (groupeSanguin == null ? 0 : groupeSanguin!.hashCode) +
    (dateVerificationAboRh == null ? 0 : dateVerificationAboRh!.hashCode) +
    (medecinTraitantId == null ? 0 : medecinTraitantId!.hashCode) +
    (contactUrgenceNom == null ? 0 : contactUrgenceNom!.hashCode) +
    (contactUrgenceTelephone == null ? 0 : contactUrgenceTelephone!.hashCode) +
    (garantNomComplet == null ? 0 : garantNomComplet!.hashCode) +
    (garantTelephone == null ? 0 : garantTelephone!.hashCode) +
    (garantEmail == null ? 0 : garantEmail!.hashCode) +
    (garantLienParente == null ? 0 : garantLienParente!.hashCode) +
    (garantUserId == null ? 0 : garantUserId!.hashCode) +
    (photoProfil == null ? 0 : photoProfil!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'Patient[id=$id, user=$user, numeroCarnet=$numeroCarnet, dateNaissance=$dateNaissance, genre=$genre, adresse=$adresse, telephone=$telephone, situationFamiliale=$situationFamiliale, profession=$profession, antecedentsChirurgicaux=$antecedentsChirurgicaux, antecedentsFamiliaux=$antecedentsFamiliaux, antecedentsMedicaux=$antecedentsMedicaux, groupeSanguin=$groupeSanguin, dateVerificationAboRh=$dateVerificationAboRh, medecinTraitantId=$medecinTraitantId, contactUrgenceNom=$contactUrgenceNom, contactUrgenceTelephone=$contactUrgenceTelephone, garantNomComplet=$garantNomComplet, garantTelephone=$garantTelephone, garantEmail=$garantEmail, garantLienParente=$garantLienParente, garantUserId=$garantUserId, photoProfil=$photoProfil, createdAt=$createdAt, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.user != null) {
      json[r'user'] = this.user;
    } else {
      json[r'user'] = null;
    }
    if (this.numeroCarnet != null) {
      json[r'numeroCarnet'] = this.numeroCarnet;
    } else {
      json[r'numeroCarnet'] = null;
    }
    if (this.dateNaissance != null) {
      json[r'dateNaissance'] = _dateFormatter.format(this.dateNaissance!.toUtc());
    } else {
      json[r'dateNaissance'] = null;
    }
    if (this.genre != null) {
      json[r'genre'] = this.genre;
    } else {
      json[r'genre'] = null;
    }
    if (this.adresse != null) {
      json[r'adresse'] = this.adresse;
    } else {
      json[r'adresse'] = null;
    }
    if (this.telephone != null) {
      json[r'telephone'] = this.telephone;
    } else {
      json[r'telephone'] = null;
    }
    if (this.situationFamiliale != null) {
      json[r'situationFamiliale'] = this.situationFamiliale;
    } else {
      json[r'situationFamiliale'] = null;
    }
    if (this.profession != null) {
      json[r'profession'] = this.profession;
    } else {
      json[r'profession'] = null;
    }
    if (this.antecedentsChirurgicaux != null) {
      json[r'antecedentsChirurgicaux'] = this.antecedentsChirurgicaux;
    } else {
      json[r'antecedentsChirurgicaux'] = null;
    }
    if (this.antecedentsFamiliaux != null) {
      json[r'antecedentsFamiliaux'] = this.antecedentsFamiliaux;
    } else {
      json[r'antecedentsFamiliaux'] = null;
    }
    if (this.antecedentsMedicaux != null) {
      json[r'antecedentsMedicaux'] = this.antecedentsMedicaux;
    } else {
      json[r'antecedentsMedicaux'] = null;
    }
    if (this.groupeSanguin != null) {
      json[r'groupeSanguin'] = this.groupeSanguin;
    } else {
      json[r'groupeSanguin'] = null;
    }
    if (this.dateVerificationAboRh != null) {
      json[r'dateVerificationAboRh'] = _dateFormatter.format(this.dateVerificationAboRh!.toUtc());
    } else {
      json[r'dateVerificationAboRh'] = null;
    }
    if (this.medecinTraitantId != null) {
      json[r'medecinTraitantId'] = this.medecinTraitantId;
    } else {
      json[r'medecinTraitantId'] = null;
    }
    if (this.contactUrgenceNom != null) {
      json[r'contactUrgenceNom'] = this.contactUrgenceNom;
    } else {
      json[r'contactUrgenceNom'] = null;
    }
    if (this.contactUrgenceTelephone != null) {
      json[r'contactUrgenceTelephone'] = this.contactUrgenceTelephone;
    } else {
      json[r'contactUrgenceTelephone'] = null;
    }
    if (this.garantNomComplet != null) {
      json[r'garantNomComplet'] = this.garantNomComplet;
    } else {
      json[r'garantNomComplet'] = null;
    }
    if (this.garantTelephone != null) {
      json[r'garantTelephone'] = this.garantTelephone;
    } else {
      json[r'garantTelephone'] = null;
    }
    if (this.garantEmail != null) {
      json[r'garantEmail'] = this.garantEmail;
    } else {
      json[r'garantEmail'] = null;
    }
    if (this.garantLienParente != null) {
      json[r'garantLienParente'] = this.garantLienParente;
    } else {
      json[r'garantLienParente'] = null;
    }
    if (this.garantUserId != null) {
      json[r'garantUserId'] = this.garantUserId;
    } else {
      json[r'garantUserId'] = null;
    }
    if (this.photoProfil != null) {
      json[r'photoProfil'] = this.photoProfil;
    } else {
      json[r'photoProfil'] = null;
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

  /// Returns a new [Patient] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Patient? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Patient[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Patient[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Patient(
        id: mapValueOfType<String>(json, r'id'),
        user: User.fromJson(json[r'user']),
        numeroCarnet: mapValueOfType<String>(json, r'numeroCarnet'),
        dateNaissance: mapDateTime(json, r'dateNaissance', r''),
        genre: PatientGenreEnum.fromJson(json[r'genre']),
        adresse: mapValueOfType<String>(json, r'adresse'),
        telephone: mapValueOfType<String>(json, r'telephone'),
        situationFamiliale: PatientSituationFamilialeEnum.fromJson(json[r'situationFamiliale']),
        profession: mapValueOfType<String>(json, r'profession'),
        antecedentsChirurgicaux: mapValueOfType<String>(json, r'antecedentsChirurgicaux'),
        antecedentsFamiliaux: mapValueOfType<String>(json, r'antecedentsFamiliaux'),
        antecedentsMedicaux: mapValueOfType<String>(json, r'antecedentsMedicaux'),
        groupeSanguin: PatientGroupeSanguinEnum.fromJson(json[r'groupeSanguin']),
        dateVerificationAboRh: mapDateTime(json, r'dateVerificationAboRh', r''),
        medecinTraitantId: mapValueOfType<String>(json, r'medecinTraitantId'),
        contactUrgenceNom: mapValueOfType<String>(json, r'contactUrgenceNom'),
        contactUrgenceTelephone: mapValueOfType<String>(json, r'contactUrgenceTelephone'),
        garantNomComplet: mapValueOfType<String>(json, r'garantNomComplet'),
        garantTelephone: mapValueOfType<String>(json, r'garantTelephone'),
        garantEmail: mapValueOfType<String>(json, r'garantEmail'),
        garantLienParente: mapValueOfType<String>(json, r'garantLienParente'),
        garantUserId: mapValueOfType<String>(json, r'garantUserId'),
        photoProfil: mapValueOfType<String>(json, r'photoProfil'),
        createdAt: mapDateTime(json, r'createdAt', r''),
        updatedAt: mapDateTime(json, r'updatedAt', r''),
      );
    }
    return null;
  }

  static List<Patient> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Patient>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Patient.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Patient> mapFromJson(dynamic json) {
    final map = <String, Patient>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Patient.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Patient-objects as value to a dart map
  static Map<String, List<Patient>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Patient>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Patient.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class PatientGenreEnum {
  /// Instantiate a new enum with the provided [value].
  const PatientGenreEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const M = PatientGenreEnum._(r'M');
  static const F = PatientGenreEnum._(r'F');
  static const AUTRE = PatientGenreEnum._(r'AUTRE');

  /// List of all possible values in this [enum][PatientGenreEnum].
  static const values = <PatientGenreEnum>[
    M,
    F,
    AUTRE,
  ];

  static PatientGenreEnum? fromJson(dynamic value) => PatientGenreEnumTypeTransformer().decode(value);

  static List<PatientGenreEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PatientGenreEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatientGenreEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PatientGenreEnum] to String,
/// and [decode] dynamic data back to [PatientGenreEnum].
class PatientGenreEnumTypeTransformer {
  factory PatientGenreEnumTypeTransformer() => _instance ??= const PatientGenreEnumTypeTransformer._();

  const PatientGenreEnumTypeTransformer._();

  String encode(PatientGenreEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a PatientGenreEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PatientGenreEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'M': return PatientGenreEnum.M;
        case r'F': return PatientGenreEnum.F;
        case r'AUTRE': return PatientGenreEnum.AUTRE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PatientGenreEnumTypeTransformer] instance.
  static PatientGenreEnumTypeTransformer? _instance;
}



class PatientSituationFamilialeEnum {
  /// Instantiate a new enum with the provided [value].
  const PatientSituationFamilialeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CELIBATAIRE = PatientSituationFamilialeEnum._(r'CELIBATAIRE');
  static const MARIE = PatientSituationFamilialeEnum._(r'MARIE');
  static const DIVORCE = PatientSituationFamilialeEnum._(r'DIVORCE');
  static const VEUF = PatientSituationFamilialeEnum._(r'VEUF');

  /// List of all possible values in this [enum][PatientSituationFamilialeEnum].
  static const values = <PatientSituationFamilialeEnum>[
    CELIBATAIRE,
    MARIE,
    DIVORCE,
    VEUF,
  ];

  static PatientSituationFamilialeEnum? fromJson(dynamic value) => PatientSituationFamilialeEnumTypeTransformer().decode(value);

  static List<PatientSituationFamilialeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PatientSituationFamilialeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatientSituationFamilialeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PatientSituationFamilialeEnum] to String,
/// and [decode] dynamic data back to [PatientSituationFamilialeEnum].
class PatientSituationFamilialeEnumTypeTransformer {
  factory PatientSituationFamilialeEnumTypeTransformer() => _instance ??= const PatientSituationFamilialeEnumTypeTransformer._();

  const PatientSituationFamilialeEnumTypeTransformer._();

  String encode(PatientSituationFamilialeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a PatientSituationFamilialeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PatientSituationFamilialeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'CELIBATAIRE': return PatientSituationFamilialeEnum.CELIBATAIRE;
        case r'MARIE': return PatientSituationFamilialeEnum.MARIE;
        case r'DIVORCE': return PatientSituationFamilialeEnum.DIVORCE;
        case r'VEUF': return PatientSituationFamilialeEnum.VEUF;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PatientSituationFamilialeEnumTypeTransformer] instance.
  static PatientSituationFamilialeEnumTypeTransformer? _instance;
}



class PatientGroupeSanguinEnum {
  /// Instantiate a new enum with the provided [value].
  const PatientGroupeSanguinEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const A_PLUS = PatientGroupeSanguinEnum._(r'A_PLUS');
  static const A_MINUS = PatientGroupeSanguinEnum._(r'A_MINUS');
  static const B_PLUS = PatientGroupeSanguinEnum._(r'B_PLUS');
  static const B_MINUS = PatientGroupeSanguinEnum._(r'B_MINUS');
  static const AB_PLUS = PatientGroupeSanguinEnum._(r'AB_PLUS');
  static const AB_MINUS = PatientGroupeSanguinEnum._(r'AB_MINUS');
  static const O_PLUS = PatientGroupeSanguinEnum._(r'O_PLUS');
  static const O_MINUS = PatientGroupeSanguinEnum._(r'O_MINUS');

  /// List of all possible values in this [enum][PatientGroupeSanguinEnum].
  static const values = <PatientGroupeSanguinEnum>[
    A_PLUS,
    A_MINUS,
    B_PLUS,
    B_MINUS,
    AB_PLUS,
    AB_MINUS,
    O_PLUS,
    O_MINUS,
  ];

  static PatientGroupeSanguinEnum? fromJson(dynamic value) => PatientGroupeSanguinEnumTypeTransformer().decode(value);

  static List<PatientGroupeSanguinEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PatientGroupeSanguinEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PatientGroupeSanguinEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PatientGroupeSanguinEnum] to String,
/// and [decode] dynamic data back to [PatientGroupeSanguinEnum].
class PatientGroupeSanguinEnumTypeTransformer {
  factory PatientGroupeSanguinEnumTypeTransformer() => _instance ??= const PatientGroupeSanguinEnumTypeTransformer._();

  const PatientGroupeSanguinEnumTypeTransformer._();

  String encode(PatientGroupeSanguinEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a PatientGroupeSanguinEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PatientGroupeSanguinEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'A_PLUS': return PatientGroupeSanguinEnum.A_PLUS;
        case r'A_MINUS': return PatientGroupeSanguinEnum.A_MINUS;
        case r'B_PLUS': return PatientGroupeSanguinEnum.B_PLUS;
        case r'B_MINUS': return PatientGroupeSanguinEnum.B_MINUS;
        case r'AB_PLUS': return PatientGroupeSanguinEnum.AB_PLUS;
        case r'AB_MINUS': return PatientGroupeSanguinEnum.AB_MINUS;
        case r'O_PLUS': return PatientGroupeSanguinEnum.O_PLUS;
        case r'O_MINUS': return PatientGroupeSanguinEnum.O_MINUS;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PatientGroupeSanguinEnumTypeTransformer] instance.
  static PatientGroupeSanguinEnumTypeTransformer? _instance;
}



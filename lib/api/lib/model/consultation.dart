//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Consultation {
  /// Returns a new [Consultation] instance.
  Consultation({
    this.id,
    this.carnet,
    this.medecin,
    this.hopital,
    this.dateConsultation,
    this.motif,
    this.symptomes,
    this.diagnostic,
    this.traitementRecommande,
    this.suiviRecommande,
    this.dureeConsultationMinutes,
    this.gravite,
    this.prochaineConsultation,
    this.pressionArterielle,
    this.poids,
    this.taille,
    this.temperature,
    this.frequenceCardiaque,
    this.notesComplementaires,
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
  DateTime? dateConsultation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? motif;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? symptomes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? diagnostic;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? traitementRecommande;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? suiviRecommande;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? dureeConsultationMinutes;

  ConsultationGraviteEnum? gravite;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? prochaineConsultation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? pressionArterielle;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? poids;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? taille;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? temperature;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? frequenceCardiaque;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? notesComplementaires;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Consultation &&
    other.id == id &&
    other.carnet == carnet &&
    other.medecin == medecin &&
    other.hopital == hopital &&
    other.dateConsultation == dateConsultation &&
    other.motif == motif &&
    other.symptomes == symptomes &&
    other.diagnostic == diagnostic &&
    other.traitementRecommande == traitementRecommande &&
    other.suiviRecommande == suiviRecommande &&
    other.dureeConsultationMinutes == dureeConsultationMinutes &&
    other.gravite == gravite &&
    other.prochaineConsultation == prochaineConsultation &&
    other.pressionArterielle == pressionArterielle &&
    other.poids == poids &&
    other.taille == taille &&
    other.temperature == temperature &&
    other.frequenceCardiaque == frequenceCardiaque &&
    other.notesComplementaires == notesComplementaires &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (carnet == null ? 0 : carnet!.hashCode) +
    (medecin == null ? 0 : medecin!.hashCode) +
    (hopital == null ? 0 : hopital!.hashCode) +
    (dateConsultation == null ? 0 : dateConsultation!.hashCode) +
    (motif == null ? 0 : motif!.hashCode) +
    (symptomes == null ? 0 : symptomes!.hashCode) +
    (diagnostic == null ? 0 : diagnostic!.hashCode) +
    (traitementRecommande == null ? 0 : traitementRecommande!.hashCode) +
    (suiviRecommande == null ? 0 : suiviRecommande!.hashCode) +
    (dureeConsultationMinutes == null ? 0 : dureeConsultationMinutes!.hashCode) +
    (gravite == null ? 0 : gravite!.hashCode) +
    (prochaineConsultation == null ? 0 : prochaineConsultation!.hashCode) +
    (pressionArterielle == null ? 0 : pressionArterielle!.hashCode) +
    (poids == null ? 0 : poids!.hashCode) +
    (taille == null ? 0 : taille!.hashCode) +
    (temperature == null ? 0 : temperature!.hashCode) +
    (frequenceCardiaque == null ? 0 : frequenceCardiaque!.hashCode) +
    (notesComplementaires == null ? 0 : notesComplementaires!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'Consultation[id=$id, carnet=$carnet, medecin=$medecin, hopital=$hopital, dateConsultation=$dateConsultation, motif=$motif, symptomes=$symptomes, diagnostic=$diagnostic, traitementRecommande=$traitementRecommande, suiviRecommande=$suiviRecommande, dureeConsultationMinutes=$dureeConsultationMinutes, gravite=$gravite, prochaineConsultation=$prochaineConsultation, pressionArterielle=$pressionArterielle, poids=$poids, taille=$taille, temperature=$temperature, frequenceCardiaque=$frequenceCardiaque, notesComplementaires=$notesComplementaires, createdAt=$createdAt]';

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
    if (this.dateConsultation != null) {
      json[r'dateConsultation'] = this.dateConsultation!.toUtc().toIso8601String();
    } else {
      json[r'dateConsultation'] = null;
    }
    if (this.motif != null) {
      json[r'motif'] = this.motif;
    } else {
      json[r'motif'] = null;
    }
    if (this.symptomes != null) {
      json[r'symptomes'] = this.symptomes;
    } else {
      json[r'symptomes'] = null;
    }
    if (this.diagnostic != null) {
      json[r'diagnostic'] = this.diagnostic;
    } else {
      json[r'diagnostic'] = null;
    }
    if (this.traitementRecommande != null) {
      json[r'traitementRecommande'] = this.traitementRecommande;
    } else {
      json[r'traitementRecommande'] = null;
    }
    if (this.suiviRecommande != null) {
      json[r'suiviRecommande'] = this.suiviRecommande;
    } else {
      json[r'suiviRecommande'] = null;
    }
    if (this.dureeConsultationMinutes != null) {
      json[r'dureeConsultationMinutes'] = this.dureeConsultationMinutes;
    } else {
      json[r'dureeConsultationMinutes'] = null;
    }
    if (this.gravite != null) {
      json[r'gravite'] = this.gravite;
    } else {
      json[r'gravite'] = null;
    }
    if (this.prochaineConsultation != null) {
      json[r'prochaineConsultation'] = this.prochaineConsultation!.toUtc().toIso8601String();
    } else {
      json[r'prochaineConsultation'] = null;
    }
    if (this.pressionArterielle != null) {
      json[r'pressionArterielle'] = this.pressionArterielle;
    } else {
      json[r'pressionArterielle'] = null;
    }
    if (this.poids != null) {
      json[r'poids'] = this.poids;
    } else {
      json[r'poids'] = null;
    }
    if (this.taille != null) {
      json[r'taille'] = this.taille;
    } else {
      json[r'taille'] = null;
    }
    if (this.temperature != null) {
      json[r'temperature'] = this.temperature;
    } else {
      json[r'temperature'] = null;
    }
    if (this.frequenceCardiaque != null) {
      json[r'frequenceCardiaque'] = this.frequenceCardiaque;
    } else {
      json[r'frequenceCardiaque'] = null;
    }
    if (this.notesComplementaires != null) {
      json[r'notesComplementaires'] = this.notesComplementaires;
    } else {
      json[r'notesComplementaires'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [Consultation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Consultation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Consultation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Consultation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Consultation(
        id: mapValueOfType<String>(json, r'id'),
        carnet: CarnetMedical.fromJson(json[r'carnet']),
        medecin: Medecin.fromJson(json[r'medecin']),
        hopital: Hopital.fromJson(json[r'hopital']),
        dateConsultation: mapDateTime(json, r'dateConsultation', r''),
        motif: mapValueOfType<String>(json, r'motif'),
        symptomes: mapValueOfType<String>(json, r'symptomes'),
        diagnostic: mapValueOfType<String>(json, r'diagnostic'),
        traitementRecommande: mapValueOfType<String>(json, r'traitementRecommande'),
        suiviRecommande: mapValueOfType<String>(json, r'suiviRecommande'),
        dureeConsultationMinutes: mapValueOfType<int>(json, r'dureeConsultationMinutes'),
        gravite: ConsultationGraviteEnum.fromJson(json[r'gravite']),
        prochaineConsultation: mapDateTime(json, r'prochaineConsultation', r''),
        pressionArterielle: mapValueOfType<String>(json, r'pressionArterielle'),
        poids: mapValueOfType<double>(json, r'poids'),
        taille: mapValueOfType<double>(json, r'taille'),
        temperature: mapValueOfType<double>(json, r'temperature'),
        frequenceCardiaque: mapValueOfType<int>(json, r'frequenceCardiaque'),
        notesComplementaires: mapValueOfType<String>(json, r'notesComplementaires'),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<Consultation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Consultation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Consultation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Consultation> mapFromJson(dynamic json) {
    final map = <String, Consultation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Consultation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Consultation-objects as value to a dart map
  static Map<String, List<Consultation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Consultation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Consultation.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class ConsultationGraviteEnum {
  /// Instantiate a new enum with the provided [value].
  const ConsultationGraviteEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const FAIBLE = ConsultationGraviteEnum._(r'FAIBLE');
  static const MOYENNE = ConsultationGraviteEnum._(r'MOYENNE');
  static const HAUTE = ConsultationGraviteEnum._(r'HAUTE');
  static const URGENTE = ConsultationGraviteEnum._(r'URGENTE');

  /// List of all possible values in this [enum][ConsultationGraviteEnum].
  static const values = <ConsultationGraviteEnum>[
    FAIBLE,
    MOYENNE,
    HAUTE,
    URGENTE,
  ];

  static ConsultationGraviteEnum? fromJson(dynamic value) => ConsultationGraviteEnumTypeTransformer().decode(value);

  static List<ConsultationGraviteEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConsultationGraviteEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConsultationGraviteEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ConsultationGraviteEnum] to String,
/// and [decode] dynamic data back to [ConsultationGraviteEnum].
class ConsultationGraviteEnumTypeTransformer {
  factory ConsultationGraviteEnumTypeTransformer() => _instance ??= const ConsultationGraviteEnumTypeTransformer._();

  const ConsultationGraviteEnumTypeTransformer._();

  String encode(ConsultationGraviteEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ConsultationGraviteEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ConsultationGraviteEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'FAIBLE': return ConsultationGraviteEnum.FAIBLE;
        case r'MOYENNE': return ConsultationGraviteEnum.MOYENNE;
        case r'HAUTE': return ConsultationGraviteEnum.HAUTE;
        case r'URGENTE': return ConsultationGraviteEnum.URGENTE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ConsultationGraviteEnumTypeTransformer] instance.
  static ConsultationGraviteEnumTypeTransformer? _instance;
}



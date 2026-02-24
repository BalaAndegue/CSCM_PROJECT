//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Document {
  /// Returns a new [Document] instance.
  Document({
    this.id,
    this.carnet,
    this.uploadedBy,
    this.nomFichier,
    this.nomOriginal,
    this.typeMime,
    this.taille,
    this.cheminStockage,
    this.typeDocument,
    this.chiffre,
    this.description,
    this.entiteType,
    this.entiteId,
    this.actif,
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
  String? uploadedBy;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nomFichier;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nomOriginal;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? typeMime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? taille;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? cheminStockage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? typeDocument;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? chiffre;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? entiteType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? entiteId;

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
  DateTime? createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Document &&
    other.id == id &&
    other.carnet == carnet &&
    other.uploadedBy == uploadedBy &&
    other.nomFichier == nomFichier &&
    other.nomOriginal == nomOriginal &&
    other.typeMime == typeMime &&
    other.taille == taille &&
    other.cheminStockage == cheminStockage &&
    other.typeDocument == typeDocument &&
    other.chiffre == chiffre &&
    other.description == description &&
    other.entiteType == entiteType &&
    other.entiteId == entiteId &&
    other.actif == actif &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (carnet == null ? 0 : carnet!.hashCode) +
    (uploadedBy == null ? 0 : uploadedBy!.hashCode) +
    (nomFichier == null ? 0 : nomFichier!.hashCode) +
    (nomOriginal == null ? 0 : nomOriginal!.hashCode) +
    (typeMime == null ? 0 : typeMime!.hashCode) +
    (taille == null ? 0 : taille!.hashCode) +
    (cheminStockage == null ? 0 : cheminStockage!.hashCode) +
    (typeDocument == null ? 0 : typeDocument!.hashCode) +
    (chiffre == null ? 0 : chiffre!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (entiteType == null ? 0 : entiteType!.hashCode) +
    (entiteId == null ? 0 : entiteId!.hashCode) +
    (actif == null ? 0 : actif!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode);

  @override
  String toString() => 'Document[id=$id, carnet=$carnet, uploadedBy=$uploadedBy, nomFichier=$nomFichier, nomOriginal=$nomOriginal, typeMime=$typeMime, taille=$taille, cheminStockage=$cheminStockage, typeDocument=$typeDocument, chiffre=$chiffre, description=$description, entiteType=$entiteType, entiteId=$entiteId, actif=$actif, createdAt=$createdAt]';

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
    if (this.uploadedBy != null) {
      json[r'uploadedBy'] = this.uploadedBy;
    } else {
      json[r'uploadedBy'] = null;
    }
    if (this.nomFichier != null) {
      json[r'nomFichier'] = this.nomFichier;
    } else {
      json[r'nomFichier'] = null;
    }
    if (this.nomOriginal != null) {
      json[r'nomOriginal'] = this.nomOriginal;
    } else {
      json[r'nomOriginal'] = null;
    }
    if (this.typeMime != null) {
      json[r'typeMime'] = this.typeMime;
    } else {
      json[r'typeMime'] = null;
    }
    if (this.taille != null) {
      json[r'taille'] = this.taille;
    } else {
      json[r'taille'] = null;
    }
    if (this.cheminStockage != null) {
      json[r'cheminStockage'] = this.cheminStockage;
    } else {
      json[r'cheminStockage'] = null;
    }
    if (this.typeDocument != null) {
      json[r'typeDocument'] = this.typeDocument;
    } else {
      json[r'typeDocument'] = null;
    }
    if (this.chiffre != null) {
      json[r'chiffre'] = this.chiffre;
    } else {
      json[r'chiffre'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.entiteType != null) {
      json[r'entiteType'] = this.entiteType;
    } else {
      json[r'entiteType'] = null;
    }
    if (this.entiteId != null) {
      json[r'entiteId'] = this.entiteId;
    } else {
      json[r'entiteId'] = null;
    }
    if (this.actif != null) {
      json[r'actif'] = this.actif;
    } else {
      json[r'actif'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    return json;
  }

  /// Returns a new [Document] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Document? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Document[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Document[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Document(
        id: mapValueOfType<String>(json, r'id'),
        carnet: CarnetMedical.fromJson(json[r'carnet']),
        uploadedBy: mapValueOfType<String>(json, r'uploadedBy'),
        nomFichier: mapValueOfType<String>(json, r'nomFichier'),
        nomOriginal: mapValueOfType<String>(json, r'nomOriginal'),
        typeMime: mapValueOfType<String>(json, r'typeMime'),
        taille: mapValueOfType<int>(json, r'taille'),
        cheminStockage: mapValueOfType<String>(json, r'cheminStockage'),
        typeDocument: mapValueOfType<String>(json, r'typeDocument'),
        chiffre: mapValueOfType<bool>(json, r'chiffre'),
        description: mapValueOfType<String>(json, r'description'),
        entiteType: mapValueOfType<String>(json, r'entiteType'),
        entiteId: mapValueOfType<String>(json, r'entiteId'),
        actif: mapValueOfType<bool>(json, r'actif'),
        createdAt: mapDateTime(json, r'createdAt', r''),
      );
    }
    return null;
  }

  static List<Document> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Document>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Document.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Document> mapFromJson(dynamic json) {
    final map = <String, Document>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Document.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Document-objects as value to a dart map
  static Map<String, List<Document>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Document>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Document.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


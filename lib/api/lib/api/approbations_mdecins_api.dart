//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ApprobationsMdecinsApi {
  ApprobationsMdecinsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Approuver l'accès d'un médecin au carnet (patient signe)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [String] medecinId (required):
  ///
  /// * [SignatureRequest] signatureRequest:
  Future<Response> approuver1WithHttpInfo(String carnetId, String medecinId, { SignatureRequest? signatureRequest, }) async {
    // ignore: prefer_const_declarations
    final path = r'/approbations/carnet/{carnetId}/medecin/{medecinId}'
      .replaceAll('{carnetId}', carnetId)
      .replaceAll('{medecinId}', medecinId);

    // ignore: prefer_final_locals
    Object? postBody = signatureRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Approuver l'accès d'un médecin au carnet (patient signe)
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [String] medecinId (required):
  ///
  /// * [SignatureRequest] signatureRequest:
  Future<ApiResponseApprobationMedecin?> approuver1(String carnetId, String medecinId, { SignatureRequest? signatureRequest, }) async {
    final response = await approuver1WithHttpInfo(carnetId, medecinId,  signatureRequest: signatureRequest, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseApprobationMedecin',) as ApiResponseApprobationMedecin;
    
    }
    return null;
  }

  /// Médecins approuvés pour un carnet
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  Future<Response> getMedecinsApprouvesWithHttpInfo(String carnetId,) async {
    // ignore: prefer_const_declarations
    final path = r'/approbations/carnet/{carnetId}'
      .replaceAll('{carnetId}', carnetId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Médecins approuvés pour un carnet
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  Future<ApiResponseListApprobationMedecin?> getMedecinsApprouves(String carnetId,) async {
    final response = await getMedecinsApprouvesWithHttpInfo(carnetId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseListApprobationMedecin',) as ApiResponseListApprobationMedecin;
    
    }
    return null;
  }

  /// Mes accès patients (médecin connecté)
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMesAccesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/approbations/medecin/mes-acces';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Mes accès patients (médecin connecté)
  Future<ApiResponseListApprobationMedecin?> getMesAcces() async {
    final response = await getMesAccesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseListApprobationMedecin',) as ApiResponseListApprobationMedecin;
    
    }
    return null;
  }

  /// Révoquer l'accès d'un médecin
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MotifRequest] motifRequest:
  Future<Response> revoquerWithHttpInfo(String id, { MotifRequest? motifRequest, }) async {
    // ignore: prefer_const_declarations
    final path = r'/approbations/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = motifRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Révoquer l'accès d'un médecin
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MotifRequest] motifRequest:
  Future<ApiResponseApprobationMedecin?> revoquer(String id, { MotifRequest? motifRequest, }) async {
    final response = await revoquerWithHttpInfo(id,  motifRequest: motifRequest, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseApprobationMedecin',) as ApiResponseApprobationMedecin;
    
    }
    return null;
  }
}

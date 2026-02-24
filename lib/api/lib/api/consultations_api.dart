//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ConsultationsApi {
  ConsultationsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Ajouter une consultation
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Consultation] consultation (required):
  ///
  /// * [String] hopitalId:
  Future<Response> create3WithHttpInfo(String carnetId, Consultation consultation, { String? hopitalId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/consultations/carnet/{carnetId}'
      .replaceAll('{carnetId}', carnetId);

    // ignore: prefer_final_locals
    Object? postBody = consultation;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (hopitalId != null) {
      queryParams.addAll(_queryParams('', 'hopitalId', hopitalId));
    }

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

  /// Ajouter une consultation
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Consultation] consultation (required):
  ///
  /// * [String] hopitalId:
  Future<ApiResponseConsultation?> create3(String carnetId, Consultation consultation, { String? hopitalId, }) async {
    final response = await create3WithHttpInfo(carnetId, consultation,  hopitalId: hopitalId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseConsultation',) as ApiResponseConsultation;
    
    }
    return null;
  }

  /// Supprimer une consultation (admin)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> delete2WithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/consultations/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Supprimer une consultation (admin)
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseVoid?> delete2(String id,) async {
    final response = await delete2WithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseVoid',) as ApiResponseVoid;
    
    }
    return null;
  }

  /// Consultations d'un carnet
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<Response> getByCarnet2WithHttpInfo(String carnetId, Pageable pageable,) async {
    // ignore: prefer_const_declarations
    final path = r'/consultations/carnet/{carnetId}'
      .replaceAll('{carnetId}', carnetId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'pageable', pageable));

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

  /// Consultations d'un carnet
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<ApiResponsePageConsultation?> getByCarnet2(String carnetId, Pageable pageable,) async {
    final response = await getByCarnet2WithHttpInfo(carnetId, pageable,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponsePageConsultation',) as ApiResponsePageConsultation;
    
    }
    return null;
  }

  /// Détail d'une consultation
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getById4WithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/consultations/{id}'
      .replaceAll('{id}', id);

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

  /// Détail d'une consultation
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseConsultation?> getById4(String id,) async {
    final response = await getById4WithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseConsultation',) as ApiResponseConsultation;
    
    }
    return null;
  }

  /// Consultations d'un médecin
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] medecinId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<Response> getByMedecinWithHttpInfo(String medecinId, Pageable pageable,) async {
    // ignore: prefer_const_declarations
    final path = r'/consultations/medecin/{medecinId}'
      .replaceAll('{medecinId}', medecinId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'pageable', pageable));

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

  /// Consultations d'un médecin
  ///
  /// Parameters:
  ///
  /// * [String] medecinId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<ApiResponsePageConsultation?> getByMedecin(String medecinId, Pageable pageable,) async {
    final response = await getByMedecinWithHttpInfo(medecinId, pageable,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponsePageConsultation',) as ApiResponsePageConsultation;
    
    }
    return null;
  }

  /// Modifier une consultation
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [Consultation] consultation (required):
  Future<Response> update3WithHttpInfo(String id, Consultation consultation,) async {
    // ignore: prefer_const_declarations
    final path = r'/consultations/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = consultation;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Modifier une consultation
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [Consultation] consultation (required):
  Future<ApiResponseConsultation?> update3(String id, Consultation consultation,) async {
    final response = await update3WithHttpInfo(id, consultation,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseConsultation',) as ApiResponseConsultation;
    
    }
    return null;
  }
}

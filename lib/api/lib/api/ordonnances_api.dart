//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class OrdonnancesApi {
  OrdonnancesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Annuler une ordonnance
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> annulerWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/ordonnances/{id}/annuler'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Annuler une ordonnance
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseOrdonnance?> annuler(String id,) async {
    final response = await annulerWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseOrdonnance',) as ApiResponseOrdonnance;
    
    }
    return null;
  }

  /// Créer une ordonnance
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [String] hopitalId (required):
  ///
  /// * [Ordonnance] ordonnance (required):
  Future<Response> createWithHttpInfo(String carnetId, String hopitalId, Ordonnance ordonnance,) async {
    // ignore: prefer_const_declarations
    final path = r'/ordonnances/carnet/{carnetId}'
      .replaceAll('{carnetId}', carnetId);

    // ignore: prefer_final_locals
    Object? postBody = ordonnance;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'hopitalId', hopitalId));

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

  /// Créer une ordonnance
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [String] hopitalId (required):
  ///
  /// * [Ordonnance] ordonnance (required):
  Future<ApiResponseOrdonnance?> create(String carnetId, String hopitalId, Ordonnance ordonnance,) async {
    final response = await createWithHttpInfo(carnetId, hopitalId, ordonnance,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseOrdonnance',) as ApiResponseOrdonnance;
    
    }
    return null;
  }

  /// Ordonnances d'un carnet
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<Response> getByCarnetWithHttpInfo(String carnetId, Pageable pageable,) async {
    // ignore: prefer_const_declarations
    final path = r'/ordonnances/carnet/{carnetId}'
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

  /// Ordonnances d'un carnet
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<ApiResponsePageOrdonnance?> getByCarnet(String carnetId, Pageable pageable,) async {
    final response = await getByCarnetWithHttpInfo(carnetId, pageable,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponsePageOrdonnance',) as ApiResponsePageOrdonnance;
    
    }
    return null;
  }

  /// Détail d'une ordonnance
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getByIdWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/ordonnances/{id}'
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

  /// Détail d'une ordonnance
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseOrdonnance?> getById(String id,) async {
    final response = await getByIdWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseOrdonnance',) as ApiResponseOrdonnance;
    
    }
    return null;
  }

  /// Mes ordonnances (médecin connecté)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Pageable] pageable (required):
  Future<Response> getMesOrdonnancesWithHttpInfo(Pageable pageable,) async {
    // ignore: prefer_const_declarations
    final path = r'/ordonnances/medecin/mes-ordonnances';

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

  /// Mes ordonnances (médecin connecté)
  ///
  /// Parameters:
  ///
  /// * [Pageable] pageable (required):
  Future<ApiResponsePageOrdonnance?> getMesOrdonnances(Pageable pageable,) async {
    final response = await getMesOrdonnancesWithHttpInfo(pageable,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponsePageOrdonnance',) as ApiResponsePageOrdonnance;
    
    }
    return null;
  }

  /// Modifier une ordonnance
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [Ordonnance] ordonnance (required):
  Future<Response> updateWithHttpInfo(String id, Ordonnance ordonnance,) async {
    // ignore: prefer_const_declarations
    final path = r'/ordonnances/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = ordonnance;

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

  /// Modifier une ordonnance
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [Ordonnance] ordonnance (required):
  Future<ApiResponseOrdonnance?> update(String id, Ordonnance ordonnance,) async {
    final response = await updateWithHttpInfo(id, ordonnance,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseOrdonnance',) as ApiResponseOrdonnance;
    
    }
    return null;
  }
}

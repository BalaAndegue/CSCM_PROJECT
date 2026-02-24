//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AllergiesApi {
  AllergiesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Ajouter une allergie
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Allergie] allergie (required):
  Future<Response> create4WithHttpInfo(String carnetId, Allergie allergie,) async {
    // ignore: prefer_const_declarations
    final path = r'/allergies/carnet/{carnetId}'
      .replaceAll('{carnetId}', carnetId);

    // ignore: prefer_final_locals
    Object? postBody = allergie;

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

  /// Ajouter une allergie
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Allergie] allergie (required):
  Future<ApiResponseAllergie?> create4(String carnetId, Allergie allergie,) async {
    final response = await create4WithHttpInfo(carnetId, allergie,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseAllergie',) as ApiResponseAllergie;
    
    }
    return null;
  }

  /// Supprimer une allergie
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> delete3WithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/allergies/{id}'
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

  /// Supprimer une allergie
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseVoid?> delete3(String id,) async {
    final response = await delete3WithHttpInfo(id,);
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

  /// Allergies actives d'un carnet
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  Future<Response> getActivesWithHttpInfo(String carnetId,) async {
    // ignore: prefer_const_declarations
    final path = r'/allergies/carnet/{carnetId}/actives'
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

  /// Allergies actives d'un carnet
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  Future<ApiResponseListAllergie?> getActives(String carnetId,) async {
    final response = await getActivesWithHttpInfo(carnetId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseListAllergie',) as ApiResponseListAllergie;
    
    }
    return null;
  }

  /// Toutes les allergies d'un carnet
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  Future<Response> getByCarnet3WithHttpInfo(String carnetId,) async {
    // ignore: prefer_const_declarations
    final path = r'/allergies/carnet/{carnetId}'
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

  /// Toutes les allergies d'un carnet
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  Future<ApiResponseListAllergie?> getByCarnet3(String carnetId,) async {
    final response = await getByCarnet3WithHttpInfo(carnetId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseListAllergie',) as ApiResponseListAllergie;
    
    }
    return null;
  }

  /// Détail d'une allergie
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getById6WithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/allergies/{id}'
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

  /// Détail d'une allergie
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseAllergie?> getById6(String id,) async {
    final response = await getById6WithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseAllergie',) as ApiResponseAllergie;
    
    }
    return null;
  }

  /// Modifier une allergie
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [Allergie] allergie (required):
  Future<Response> update4WithHttpInfo(String id, Allergie allergie,) async {
    // ignore: prefer_const_declarations
    final path = r'/allergies/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = allergie;

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

  /// Modifier une allergie
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [Allergie] allergie (required):
  Future<ApiResponseAllergie?> update4(String id, Allergie allergie,) async {
    final response = await update4WithHttpInfo(id, allergie,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseAllergie',) as ApiResponseAllergie;
    
    }
    return null;
  }
}

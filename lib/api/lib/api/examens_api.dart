//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ExamensApi {
  ExamensApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Ajouter un résultat d'examen
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ResultatExamen] resultatExamen (required):
  Future<Response> addResultatWithHttpInfo(String id, ResultatExamen resultatExamen,) async {
    // ignore: prefer_const_declarations
    final path = r'/examens/{id}/resultats'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = resultatExamen;

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

  /// Ajouter un résultat d'examen
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ResultatExamen] resultatExamen (required):
  Future<ApiResponseResultatExamen?> addResultat(String id, ResultatExamen resultatExamen,) async {
    final response = await addResultatWithHttpInfo(id, resultatExamen,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseResultatExamen',) as ApiResponseResultatExamen;
    
    }
    return null;
  }

  /// Prescrire un examen
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Examen] examen (required):
  Future<Response> create2WithHttpInfo(String carnetId, Examen examen,) async {
    // ignore: prefer_const_declarations
    final path = r'/examens/carnet/{carnetId}'
      .replaceAll('{carnetId}', carnetId);

    // ignore: prefer_final_locals
    Object? postBody = examen;

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

  /// Prescrire un examen
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Examen] examen (required):
  Future<ApiResponseExamen?> create2(String carnetId, Examen examen,) async {
    final response = await create2WithHttpInfo(carnetId, examen,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseExamen',) as ApiResponseExamen;
    
    }
    return null;
  }

  /// Supprimer un examen
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> delete1WithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/examens/{id}'
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

  /// Supprimer un examen
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseVoid?> delete1(String id,) async {
    final response = await delete1WithHttpInfo(id,);
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

  /// Examens d'un carnet
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<Response> getByCarnet1WithHttpInfo(String carnetId, Pageable pageable,) async {
    // ignore: prefer_const_declarations
    final path = r'/examens/carnet/{carnetId}'
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

  /// Examens d'un carnet
  ///
  /// Parameters:
  ///
  /// * [String] carnetId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<ApiResponsePageExamen?> getByCarnet1(String carnetId, Pageable pageable,) async {
    final response = await getByCarnet1WithHttpInfo(carnetId, pageable,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponsePageExamen',) as ApiResponsePageExamen;
    
    }
    return null;
  }

  /// Détail d'un examen
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getById3WithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/examens/{id}'
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

  /// Détail d'un examen
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseExamen?> getById3(String id,) async {
    final response = await getById3WithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseExamen',) as ApiResponseExamen;
    
    }
    return null;
  }

  /// Résultats d'un examen
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getResultatsWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/examens/{id}/resultats'
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

  /// Résultats d'un examen
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseListResultatExamen?> getResultats(String id,) async {
    final response = await getResultatsWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseListResultatExamen',) as ApiResponseListResultatExamen;
    
    }
    return null;
  }

  /// Marquer l'examen comme réalisé
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> marquerRealiseWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/examens/{id}/realise'
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

  /// Marquer l'examen comme réalisé
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseExamen?> marquerRealise(String id,) async {
    final response = await marquerRealiseWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseExamen',) as ApiResponseExamen;
    
    }
    return null;
  }

  /// Modifier un examen
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [Examen] examen (required):
  Future<Response> update2WithHttpInfo(String id, Examen examen,) async {
    // ignore: prefer_const_declarations
    final path = r'/examens/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = examen;

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

  /// Modifier un examen
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [Examen] examen (required):
  Future<ApiResponseExamen?> update2(String id, Examen examen,) async {
    final response = await update2WithHttpInfo(id, examen,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseExamen',) as ApiResponseExamen;
    
    }
    return null;
  }
}

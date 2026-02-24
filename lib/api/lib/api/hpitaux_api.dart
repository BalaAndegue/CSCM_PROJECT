//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class HpitauxApi {
  HpitauxApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Créer un hôpital (admin)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Hopital] hopital (required):
  Future<Response> create1WithHttpInfo(Hopital hopital,) async {
    // ignore: prefer_const_declarations
    final path = r'/hopitaux';

    // ignore: prefer_final_locals
    Object? postBody = hopital;

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

  /// Créer un hôpital (admin)
  ///
  /// Parameters:
  ///
  /// * [Hopital] hopital (required):
  Future<ApiResponseHopital?> create1(Hopital hopital,) async {
    final response = await create1WithHttpInfo(hopital,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseHopital',) as ApiResponseHopital;
    
    }
    return null;
  }

  /// Supprimer un hôpital (admin)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/hopitaux/{id}'
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

  /// Supprimer un hôpital (admin)
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseVoid?> delete(String id,) async {
    final response = await deleteWithHttpInfo(id,);
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

  /// Détacher un médecin de l'hôpital
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] medecinId (required):
  Future<Response> detacherMedecinWithHttpInfo(String id, String medecinId,) async {
    // ignore: prefer_const_declarations
    final path = r'/hopitaux/{id}/medecins/{medecinId}'
      .replaceAll('{id}', id)
      .replaceAll('{medecinId}', medecinId);

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

  /// Détacher un médecin de l'hôpital
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] medecinId (required):
  Future<ApiResponseVoid?> detacherMedecin(String id, String medecinId,) async {
    final response = await detacherMedecinWithHttpInfo(id, medecinId,);
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

  /// Lister les hôpitaux
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Pageable] pageable (required):
  Future<Response> getAll1WithHttpInfo(Pageable pageable,) async {
    // ignore: prefer_const_declarations
    final path = r'/hopitaux';

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

  /// Lister les hôpitaux
  ///
  /// Parameters:
  ///
  /// * [Pageable] pageable (required):
  Future<ApiResponsePageHopital?> getAll1(Pageable pageable,) async {
    final response = await getAll1WithHttpInfo(pageable,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponsePageHopital',) as ApiResponsePageHopital;
    
    }
    return null;
  }

  /// Détail d'un hôpital
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getById2WithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/hopitaux/{id}'
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

  /// Détail d'un hôpital
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseHopital?> getById2(String id,) async {
    final response = await getById2WithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseHopital',) as ApiResponseHopital;
    
    }
    return null;
  }

  /// Médecins d'un hôpital
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getMedecinsWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/hopitaux/{id}/medecins'
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

  /// Médecins d'un hôpital
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseObject?> getMedecins(String id,) async {
    final response = await getMedecinsWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseObject',) as ApiResponseObject;
    
    }
    return null;
  }

  /// Rattacher un médecin à l'hôpital
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] medecinId (required):
  ///
  /// * [ServiceRequest] serviceRequest:
  Future<Response> rattacherMedecinWithHttpInfo(String id, String medecinId, { ServiceRequest? serviceRequest, }) async {
    // ignore: prefer_const_declarations
    final path = r'/hopitaux/{id}/medecins/{medecinId}'
      .replaceAll('{id}', id)
      .replaceAll('{medecinId}', medecinId);

    // ignore: prefer_final_locals
    Object? postBody = serviceRequest;

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

  /// Rattacher un médecin à l'hôpital
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] medecinId (required):
  ///
  /// * [ServiceRequest] serviceRequest:
  Future<ApiResponseMedecinHopital?> rattacherMedecin(String id, String medecinId, { ServiceRequest? serviceRequest, }) async {
    final response = await rattacherMedecinWithHttpInfo(id, medecinId,  serviceRequest: serviceRequest, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseMedecinHopital',) as ApiResponseMedecinHopital;
    
    }
    return null;
  }

  /// Modifier un hôpital
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [Hopital] hopital (required):
  Future<Response> update1WithHttpInfo(String id, Hopital hopital,) async {
    // ignore: prefer_const_declarations
    final path = r'/hopitaux/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = hopital;

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

  /// Modifier un hôpital
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [Hopital] hopital (required):
  Future<ApiResponseHopital?> update1(String id, Hopital hopital,) async {
    final response = await update1WithHttpInfo(id, hopital,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseHopital',) as ApiResponseHopital;
    
    }
    return null;
  }
}

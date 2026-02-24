//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MdecinsApi {
  MdecinsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Lister les médecins
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Pageable] pageable (required):
  ///
  /// * [String] specialite:
  Future<Response> getAllWithHttpInfo(Pageable pageable, { String? specialite, }) async {
    // ignore: prefer_const_declarations
    final path = r'/medecins';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (specialite != null) {
      queryParams.addAll(_queryParams('', 'specialite', specialite));
    }
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

  /// Lister les médecins
  ///
  /// Parameters:
  ///
  /// * [Pageable] pageable (required):
  ///
  /// * [String] specialite:
  Future<ApiResponsePageMedecin?> getAll(Pageable pageable, { String? specialite, }) async {
    final response = await getAllWithHttpInfo(pageable,  specialite: specialite, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponsePageMedecin',) as ApiResponsePageMedecin;
    
    }
    return null;
  }

  /// Détail d'un médecin
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getById1WithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/medecins/{id}'
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

  /// Détail d'un médecin
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseMedecin?> getById1(String id,) async {
    final response = await getById1WithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseMedecin',) as ApiResponseMedecin;
    
    }
    return null;
  }

  /// Hôpitaux d'un médecin
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getHopitauxWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/medecins/{id}/hopitaux'
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

  /// Hôpitaux d'un médecin
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseListMedecin?> getHopitaux(String id,) async {
    final response = await getHopitauxWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseListMedecin',) as ApiResponseListMedecin;
    
    }
    return null;
  }

  /// Mon profil médecin
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMyProfile1WithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/medecins/me';

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

  /// Mon profil médecin
  Future<ApiResponseMedecin?> getMyProfile1() async {
    final response = await getMyProfile1WithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseMedecin',) as ApiResponseMedecin;
    
    }
    return null;
  }

  /// Rejeter un médecin (admin)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [RaisonRequest] raisonRequest (required):
  Future<Response> rejeterWithHttpInfo(String id, RaisonRequest raisonRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/medecins/{id}/rejeter'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = raisonRequest;

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

  /// Rejeter un médecin (admin)
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [RaisonRequest] raisonRequest (required):
  Future<ApiResponseMedecin?> rejeter(String id, RaisonRequest raisonRequest,) async {
    final response = await rejeterWithHttpInfo(id, raisonRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseMedecin',) as ApiResponseMedecin;
    
    }
    return null;
  }

  /// Suspendre un médecin (admin)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> suspendreWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/medecins/{id}/suspendre'
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

  /// Suspendre un médecin (admin)
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseMedecin?> suspendre(String id,) async {
    final response = await suspendreWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseMedecin',) as ApiResponseMedecin;
    
    }
    return null;
  }

  /// Modifier mon profil médecin
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateMedecinRequest] updateMedecinRequest (required):
  Future<Response> updateMyProfile1WithHttpInfo(UpdateMedecinRequest updateMedecinRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/medecins/me';

    // ignore: prefer_final_locals
    Object? postBody = updateMedecinRequest;

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

  /// Modifier mon profil médecin
  ///
  /// Parameters:
  ///
  /// * [UpdateMedecinRequest] updateMedecinRequest (required):
  Future<ApiResponseMedecin?> updateMyProfile1(UpdateMedecinRequest updateMedecinRequest,) async {
    final response = await updateMyProfile1WithHttpInfo(updateMedecinRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseMedecin',) as ApiResponseMedecin;
    
    }
    return null;
  }

  /// Valider un médecin (admin)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> validerWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/medecins/{id}/valider'
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

  /// Valider un médecin (admin)
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseMedecin?> valider(String id,) async {
    final response = await validerWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseMedecin',) as ApiResponseMedecin;
    
    }
    return null;
  }
}

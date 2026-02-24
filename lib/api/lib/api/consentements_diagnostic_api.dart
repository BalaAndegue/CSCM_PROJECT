//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ConsentementsDiagnosticApi {
  ConsentementsDiagnosticApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Approuver le consentement (manager hôpital)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> approuverWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/consents/{id}/approuver'
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

  /// Approuver le consentement (manager hôpital)
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseConsentDiagnosticHopital?> approuver(String id,) async {
    final response = await approuverWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseConsentDiagnosticHopital',) as ApiResponseConsentDiagnosticHopital;
    
    }
    return null;
  }

  /// Demander un consentement (médecin)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DemandeConsentRequest] demandeConsentRequest (required):
  Future<Response> demanderWithHttpInfo(DemandeConsentRequest demandeConsentRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/consents';

    // ignore: prefer_final_locals
    Object? postBody = demandeConsentRequest;

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

  /// Demander un consentement (médecin)
  ///
  /// Parameters:
  ///
  /// * [DemandeConsentRequest] demandeConsentRequest (required):
  Future<ApiResponseConsentDiagnosticHopital?> demander(DemandeConsentRequest demandeConsentRequest,) async {
    final response = await demanderWithHttpInfo(demandeConsentRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseConsentDiagnosticHopital',) as ApiResponseConsentDiagnosticHopital;
    
    }
    return null;
  }

  /// Consentements d'un hôpital
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] hopitalId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<Response> getByHopitalWithHttpInfo(String hopitalId, Pageable pageable,) async {
    // ignore: prefer_const_declarations
    final path = r'/consents/hopital/{hopitalId}'
      .replaceAll('{hopitalId}', hopitalId);

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

  /// Consentements d'un hôpital
  ///
  /// Parameters:
  ///
  /// * [String] hopitalId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<ApiResponsePageConsentDiagnosticHopital?> getByHopital(String hopitalId, Pageable pageable,) async {
    final response = await getByHopitalWithHttpInfo(hopitalId, pageable,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponsePageConsentDiagnosticHopital',) as ApiResponsePageConsentDiagnosticHopital;
    
    }
    return null;
  }

  /// Détail d'un consentement
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getById5WithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/consents/{id}'
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

  /// Détail d'un consentement
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseConsentDiagnosticHopital?> getById5(String id,) async {
    final response = await getById5WithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseConsentDiagnosticHopital',) as ApiResponseConsentDiagnosticHopital;
    
    }
    return null;
  }

  /// Consentements en attente (manager)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] hopitalId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<Response> getPendingWithHttpInfo(String hopitalId, Pageable pageable,) async {
    // ignore: prefer_const_declarations
    final path = r'/consents/hopital/{hopitalId}/pending'
      .replaceAll('{hopitalId}', hopitalId);

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

  /// Consentements en attente (manager)
  ///
  /// Parameters:
  ///
  /// * [String] hopitalId (required):
  ///
  /// * [Pageable] pageable (required):
  Future<ApiResponsePageConsentDiagnosticHopital?> getPending(String hopitalId, Pageable pageable,) async {
    final response = await getPendingWithHttpInfo(hopitalId, pageable,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponsePageConsentDiagnosticHopital',) as ApiResponsePageConsentDiagnosticHopital;
    
    }
    return null;
  }

  /// Refuser le consentement (manager hôpital)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MotifRequest] motifRequest (required):
  Future<Response> refuserWithHttpInfo(String id, MotifRequest motifRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/consents/{id}/refuser'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = motifRequest;

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

  /// Refuser le consentement (manager hôpital)
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MotifRequest] motifRequest (required):
  Future<ApiResponseConsentDiagnosticHopital?> refuser(String id, MotifRequest motifRequest,) async {
    final response = await refuserWithHttpInfo(id, motifRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseConsentDiagnosticHopital',) as ApiResponseConsentDiagnosticHopital;
    
    }
    return null;
  }
}

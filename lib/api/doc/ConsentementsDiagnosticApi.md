# carnet_medical_api.api.ConsentementsDiagnosticApi

## Load the API package
```dart
import 'package:carnet_medical_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**approuver**](ConsentementsDiagnosticApi.md#approuver) | **PUT** /consents/{id}/approuver | Approuver le consentement (manager hôpital)
[**demander**](ConsentementsDiagnosticApi.md#demander) | **POST** /consents | Demander un consentement (médecin)
[**getByHopital**](ConsentementsDiagnosticApi.md#getbyhopital) | **GET** /consents/hopital/{hopitalId} | Consentements d'un hôpital
[**getById5**](ConsentementsDiagnosticApi.md#getbyid5) | **GET** /consents/{id} | Détail d'un consentement
[**getPending**](ConsentementsDiagnosticApi.md#getpending) | **GET** /consents/hopital/{hopitalId}/pending | Consentements en attente (manager)
[**refuser**](ConsentementsDiagnosticApi.md#refuser) | **PUT** /consents/{id}/refuser | Refuser le consentement (manager hôpital)


# **approuver**
> ApiResponseConsentDiagnosticHopital approuver(id)

Approuver le consentement (manager hôpital)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsentementsDiagnosticApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.approuver(id);
    print(result);
} catch (e) {
    print('Exception when calling ConsentementsDiagnosticApi->approuver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseConsentDiagnosticHopital**](ApiResponseConsentDiagnosticHopital.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **demander**
> ApiResponseConsentDiagnosticHopital demander(demandeConsentRequest)

Demander un consentement (médecin)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsentementsDiagnosticApi();
final demandeConsentRequest = DemandeConsentRequest(); // DemandeConsentRequest | 

try {
    final result = api_instance.demander(demandeConsentRequest);
    print(result);
} catch (e) {
    print('Exception when calling ConsentementsDiagnosticApi->demander: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **demandeConsentRequest** | [**DemandeConsentRequest**](DemandeConsentRequest.md)|  | 

### Return type

[**ApiResponseConsentDiagnosticHopital**](ApiResponseConsentDiagnosticHopital.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getByHopital**
> ApiResponsePageConsentDiagnosticHopital getByHopital(hopitalId, pageable)

Consentements d'un hôpital

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsentementsDiagnosticApi();
final hopitalId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final pageable = ; // Pageable | 

try {
    final result = api_instance.getByHopital(hopitalId, pageable);
    print(result);
} catch (e) {
    print('Exception when calling ConsentementsDiagnosticApi->getByHopital: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **hopitalId** | **String**|  | 
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**ApiResponsePageConsentDiagnosticHopital**](ApiResponsePageConsentDiagnosticHopital.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getById5**
> ApiResponseConsentDiagnosticHopital getById5(id)

Détail d'un consentement

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsentementsDiagnosticApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getById5(id);
    print(result);
} catch (e) {
    print('Exception when calling ConsentementsDiagnosticApi->getById5: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseConsentDiagnosticHopital**](ApiResponseConsentDiagnosticHopital.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPending**
> ApiResponsePageConsentDiagnosticHopital getPending(hopitalId, pageable)

Consentements en attente (manager)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsentementsDiagnosticApi();
final hopitalId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final pageable = ; // Pageable | 

try {
    final result = api_instance.getPending(hopitalId, pageable);
    print(result);
} catch (e) {
    print('Exception when calling ConsentementsDiagnosticApi->getPending: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **hopitalId** | **String**|  | 
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**ApiResponsePageConsentDiagnosticHopital**](ApiResponsePageConsentDiagnosticHopital.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refuser**
> ApiResponseConsentDiagnosticHopital refuser(id, motifRequest)

Refuser le consentement (manager hôpital)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsentementsDiagnosticApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final motifRequest = MotifRequest(); // MotifRequest | 

try {
    final result = api_instance.refuser(id, motifRequest);
    print(result);
} catch (e) {
    print('Exception when calling ConsentementsDiagnosticApi->refuser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **motifRequest** | [**MotifRequest**](MotifRequest.md)|  | 

### Return type

[**ApiResponseConsentDiagnosticHopital**](ApiResponseConsentDiagnosticHopital.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


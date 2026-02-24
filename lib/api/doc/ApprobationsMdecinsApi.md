# carnet_medical_api.api.ApprobationsMdecinsApi

## Load the API package
```dart
import 'package:carnet_medical_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**approuver1**](ApprobationsMdecinsApi.md#approuver1) | **POST** /approbations/carnet/{carnetId}/medecin/{medecinId} | Approuver l'accès d'un médecin au carnet (patient signe)
[**getMedecinsApprouves**](ApprobationsMdecinsApi.md#getmedecinsapprouves) | **GET** /approbations/carnet/{carnetId} | Médecins approuvés pour un carnet
[**getMesAcces**](ApprobationsMdecinsApi.md#getmesacces) | **GET** /approbations/medecin/mes-acces | Mes accès patients (médecin connecté)
[**revoquer**](ApprobationsMdecinsApi.md#revoquer) | **DELETE** /approbations/{id} | Révoquer l'accès d'un médecin


# **approuver1**
> ApiResponseApprobationMedecin approuver1(carnetId, medecinId, signatureRequest)

Approuver l'accès d'un médecin au carnet (patient signe)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ApprobationsMdecinsApi();
final carnetId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final medecinId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final signatureRequest = SignatureRequest(); // SignatureRequest | 

try {
    final result = api_instance.approuver1(carnetId, medecinId, signatureRequest);
    print(result);
} catch (e) {
    print('Exception when calling ApprobationsMdecinsApi->approuver1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **carnetId** | **String**|  | 
 **medecinId** | **String**|  | 
 **signatureRequest** | [**SignatureRequest**](SignatureRequest.md)|  | [optional] 

### Return type

[**ApiResponseApprobationMedecin**](ApiResponseApprobationMedecin.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMedecinsApprouves**
> ApiResponseListApprobationMedecin getMedecinsApprouves(carnetId)

Médecins approuvés pour un carnet

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ApprobationsMdecinsApi();
final carnetId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getMedecinsApprouves(carnetId);
    print(result);
} catch (e) {
    print('Exception when calling ApprobationsMdecinsApi->getMedecinsApprouves: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **carnetId** | **String**|  | 

### Return type

[**ApiResponseListApprobationMedecin**](ApiResponseListApprobationMedecin.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMesAcces**
> ApiResponseListApprobationMedecin getMesAcces()

Mes accès patients (médecin connecté)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ApprobationsMdecinsApi();

try {
    final result = api_instance.getMesAcces();
    print(result);
} catch (e) {
    print('Exception when calling ApprobationsMdecinsApi->getMesAcces: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponseListApprobationMedecin**](ApiResponseListApprobationMedecin.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **revoquer**
> ApiResponseApprobationMedecin revoquer(id, motifRequest)

Révoquer l'accès d'un médecin

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ApprobationsMdecinsApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final motifRequest = MotifRequest(); // MotifRequest | 

try {
    final result = api_instance.revoquer(id, motifRequest);
    print(result);
} catch (e) {
    print('Exception when calling ApprobationsMdecinsApi->revoquer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **motifRequest** | [**MotifRequest**](MotifRequest.md)|  | [optional] 

### Return type

[**ApiResponseApprobationMedecin**](ApiResponseApprobationMedecin.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


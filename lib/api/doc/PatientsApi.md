# carnet_medical_api.api.PatientsApi

## Load the API package
```dart
import 'package:carnet_medical_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAllPatients**](PatientsApi.md#getallpatients) | **GET** /patients | Lister tous les patients (admin)
[**getByNumeroCarnet**](PatientsApi.md#getbynumerocarnet) | **GET** /patients/carnet/{numeroCarnet} | Trouver un patient par numéro de carnet
[**getMyProfile**](PatientsApi.md#getmyprofile) | **GET** /patients/me | Mon profil patient
[**getPatientById**](PatientsApi.md#getpatientbyid) | **GET** /patients/{id} | Voir un patient par ID
[**updateMyProfile**](PatientsApi.md#updatemyprofile) | **PUT** /patients/me | Modifier mon profil


# **getAllPatients**
> ApiResponsePagePatient getAllPatients(pageable, query)

Lister tous les patients (admin)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = PatientsApi();
final pageable = ; // Pageable | 
final query = query_example; // String | 

try {
    final result = api_instance.getAllPatients(pageable, query);
    print(result);
} catch (e) {
    print('Exception when calling PatientsApi->getAllPatients: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 
 **query** | **String**|  | [optional] 

### Return type

[**ApiResponsePagePatient**](ApiResponsePagePatient.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getByNumeroCarnet**
> ApiResponsePatient getByNumeroCarnet(numeroCarnet)

Trouver un patient par numéro de carnet

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = PatientsApi();
final numeroCarnet = numeroCarnet_example; // String | 

try {
    final result = api_instance.getByNumeroCarnet(numeroCarnet);
    print(result);
} catch (e) {
    print('Exception when calling PatientsApi->getByNumeroCarnet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **numeroCarnet** | **String**|  | 

### Return type

[**ApiResponsePatient**](ApiResponsePatient.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyProfile**
> ApiResponsePatient getMyProfile()

Mon profil patient

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = PatientsApi();

try {
    final result = api_instance.getMyProfile();
    print(result);
} catch (e) {
    print('Exception when calling PatientsApi->getMyProfile: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponsePatient**](ApiResponsePatient.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPatientById**
> ApiResponsePatient getPatientById(id)

Voir un patient par ID

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = PatientsApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getPatientById(id);
    print(result);
} catch (e) {
    print('Exception when calling PatientsApi->getPatientById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponsePatient**](ApiResponsePatient.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyProfile**
> ApiResponsePatient updateMyProfile(patient)

Modifier mon profil

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = PatientsApi();
final patient = Patient(); // Patient | 

try {
    final result = api_instance.updateMyProfile(patient);
    print(result);
} catch (e) {
    print('Exception when calling PatientsApi->updateMyProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **patient** | [**Patient**](Patient.md)|  | 

### Return type

[**ApiResponsePatient**](ApiResponsePatient.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


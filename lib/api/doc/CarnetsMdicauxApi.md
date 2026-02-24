# carnet_medical_api.api.CarnetsMdicauxApi

## Load the API package
```dart
import 'package:carnet_medical_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**archiver**](CarnetsMdicauxApi.md#archiver) | **PUT** /carnets/{id}/archiver | Archiver un carnet (admin)
[**getCarnetById**](CarnetsMdicauxApi.md#getcarnetbyid) | **GET** /carnets/{id} | Carnet par ID (médecin approuvé ou admin)
[**getMyCarnet**](CarnetsMdicauxApi.md#getmycarnet) | **GET** /carnets/me | Mon carnet médical (patient connecté)
[**getSummary**](CarnetsMdicauxApi.md#getsummary) | **GET** /carnets/{id}/summary | Résumé complet du carnet (dernières consult, allergies actives)
[**updateNotes**](CarnetsMdicauxApi.md#updatenotes) | **PUT** /carnets/{id}/notes | Mettre à jour les notes générales du carnet


# **archiver**
> ApiResponseCarnetMedical archiver(id)

Archiver un carnet (admin)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = CarnetsMdicauxApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.archiver(id);
    print(result);
} catch (e) {
    print('Exception when calling CarnetsMdicauxApi->archiver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseCarnetMedical**](ApiResponseCarnetMedical.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCarnetById**
> ApiResponseCarnetMedical getCarnetById(id)

Carnet par ID (médecin approuvé ou admin)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = CarnetsMdicauxApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getCarnetById(id);
    print(result);
} catch (e) {
    print('Exception when calling CarnetsMdicauxApi->getCarnetById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseCarnetMedical**](ApiResponseCarnetMedical.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyCarnet**
> ApiResponseCarnetMedical getMyCarnet()

Mon carnet médical (patient connecté)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = CarnetsMdicauxApi();

try {
    final result = api_instance.getMyCarnet();
    print(result);
} catch (e) {
    print('Exception when calling CarnetsMdicauxApi->getMyCarnet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponseCarnetMedical**](ApiResponseCarnetMedical.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSummary**
> ApiResponseMapStringObject getSummary(id)

Résumé complet du carnet (dernières consult, allergies actives)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = CarnetsMdicauxApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getSummary(id);
    print(result);
} catch (e) {
    print('Exception when calling CarnetsMdicauxApi->getSummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseMapStringObject**](ApiResponseMapStringObject.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateNotes**
> ApiResponseCarnetMedical updateNotes(id, notesRequest)

Mettre à jour les notes générales du carnet

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = CarnetsMdicauxApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final notesRequest = NotesRequest(); // NotesRequest | 

try {
    final result = api_instance.updateNotes(id, notesRequest);
    print(result);
} catch (e) {
    print('Exception when calling CarnetsMdicauxApi->updateNotes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **notesRequest** | [**NotesRequest**](NotesRequest.md)|  | 

### Return type

[**ApiResponseCarnetMedical**](ApiResponseCarnetMedical.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


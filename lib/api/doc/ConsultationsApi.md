# carnet_medical_api.api.ConsultationsApi

## Load the API package
```dart
import 'package:carnet_medical_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create3**](ConsultationsApi.md#create3) | **POST** /consultations/carnet/{carnetId} | Ajouter une consultation
[**delete2**](ConsultationsApi.md#delete2) | **DELETE** /consultations/{id} | Supprimer une consultation (admin)
[**getByCarnet2**](ConsultationsApi.md#getbycarnet2) | **GET** /consultations/carnet/{carnetId} | Consultations d'un carnet
[**getById4**](ConsultationsApi.md#getbyid4) | **GET** /consultations/{id} | Détail d'une consultation
[**getByMedecin**](ConsultationsApi.md#getbymedecin) | **GET** /consultations/medecin/{medecinId} | Consultations d'un médecin
[**update3**](ConsultationsApi.md#update3) | **PUT** /consultations/{id} | Modifier une consultation


# **create3**
> ApiResponseConsultation create3(carnetId, consultation, hopitalId)

Ajouter une consultation

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsultationsApi();
final carnetId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final consultation = Consultation(); // Consultation | 
final hopitalId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.create3(carnetId, consultation, hopitalId);
    print(result);
} catch (e) {
    print('Exception when calling ConsultationsApi->create3: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **carnetId** | **String**|  | 
 **consultation** | [**Consultation**](Consultation.md)|  | 
 **hopitalId** | **String**|  | [optional] 

### Return type

[**ApiResponseConsultation**](ApiResponseConsultation.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **delete2**
> ApiResponseVoid delete2(id)

Supprimer une consultation (admin)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsultationsApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.delete2(id);
    print(result);
} catch (e) {
    print('Exception when calling ConsultationsApi->delete2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseVoid**](ApiResponseVoid.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getByCarnet2**
> ApiResponsePageConsultation getByCarnet2(carnetId, pageable)

Consultations d'un carnet

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsultationsApi();
final carnetId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final pageable = ; // Pageable | 

try {
    final result = api_instance.getByCarnet2(carnetId, pageable);
    print(result);
} catch (e) {
    print('Exception when calling ConsultationsApi->getByCarnet2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **carnetId** | **String**|  | 
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**ApiResponsePageConsultation**](ApiResponsePageConsultation.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getById4**
> ApiResponseConsultation getById4(id)

Détail d'une consultation

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsultationsApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getById4(id);
    print(result);
} catch (e) {
    print('Exception when calling ConsultationsApi->getById4: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseConsultation**](ApiResponseConsultation.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getByMedecin**
> ApiResponsePageConsultation getByMedecin(medecinId, pageable)

Consultations d'un médecin

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsultationsApi();
final medecinId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final pageable = ; // Pageable | 

try {
    final result = api_instance.getByMedecin(medecinId, pageable);
    print(result);
} catch (e) {
    print('Exception when calling ConsultationsApi->getByMedecin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **medecinId** | **String**|  | 
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**ApiResponsePageConsultation**](ApiResponsePageConsultation.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **update3**
> ApiResponseConsultation update3(id, consultation)

Modifier une consultation

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ConsultationsApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final consultation = Consultation(); // Consultation | 

try {
    final result = api_instance.update3(id, consultation);
    print(result);
} catch (e) {
    print('Exception when calling ConsultationsApi->update3: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **consultation** | [**Consultation**](Consultation.md)|  | 

### Return type

[**ApiResponseConsultation**](ApiResponseConsultation.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


# carnet_medical_api.api.OrdonnancesApi

## Load the API package
```dart
import 'package:carnet_medical_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**annuler**](OrdonnancesApi.md#annuler) | **PUT** /ordonnances/{id}/annuler | Annuler une ordonnance
[**create**](OrdonnancesApi.md#create) | **POST** /ordonnances/carnet/{carnetId} | Créer une ordonnance
[**getByCarnet**](OrdonnancesApi.md#getbycarnet) | **GET** /ordonnances/carnet/{carnetId} | Ordonnances d'un carnet
[**getById**](OrdonnancesApi.md#getbyid) | **GET** /ordonnances/{id} | Détail d'une ordonnance
[**getMesOrdonnances**](OrdonnancesApi.md#getmesordonnances) | **GET** /ordonnances/medecin/mes-ordonnances | Mes ordonnances (médecin connecté)
[**update**](OrdonnancesApi.md#update) | **PUT** /ordonnances/{id} | Modifier une ordonnance


# **annuler**
> ApiResponseOrdonnance annuler(id)

Annuler une ordonnance

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = OrdonnancesApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.annuler(id);
    print(result);
} catch (e) {
    print('Exception when calling OrdonnancesApi->annuler: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseOrdonnance**](ApiResponseOrdonnance.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **create**
> ApiResponseOrdonnance create(carnetId, hopitalId, ordonnance)

Créer une ordonnance

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = OrdonnancesApi();
final carnetId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final hopitalId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ordonnance = Ordonnance(); // Ordonnance | 

try {
    final result = api_instance.create(carnetId, hopitalId, ordonnance);
    print(result);
} catch (e) {
    print('Exception when calling OrdonnancesApi->create: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **carnetId** | **String**|  | 
 **hopitalId** | **String**|  | 
 **ordonnance** | [**Ordonnance**](Ordonnance.md)|  | 

### Return type

[**ApiResponseOrdonnance**](ApiResponseOrdonnance.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getByCarnet**
> ApiResponsePageOrdonnance getByCarnet(carnetId, pageable)

Ordonnances d'un carnet

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = OrdonnancesApi();
final carnetId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final pageable = ; // Pageable | 

try {
    final result = api_instance.getByCarnet(carnetId, pageable);
    print(result);
} catch (e) {
    print('Exception when calling OrdonnancesApi->getByCarnet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **carnetId** | **String**|  | 
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**ApiResponsePageOrdonnance**](ApiResponsePageOrdonnance.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getById**
> ApiResponseOrdonnance getById(id)

Détail d'une ordonnance

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = OrdonnancesApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getById(id);
    print(result);
} catch (e) {
    print('Exception when calling OrdonnancesApi->getById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseOrdonnance**](ApiResponseOrdonnance.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMesOrdonnances**
> ApiResponsePageOrdonnance getMesOrdonnances(pageable)

Mes ordonnances (médecin connecté)

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = OrdonnancesApi();
final pageable = ; // Pageable | 

try {
    final result = api_instance.getMesOrdonnances(pageable);
    print(result);
} catch (e) {
    print('Exception when calling OrdonnancesApi->getMesOrdonnances: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pageable** | [**Pageable**](.md)|  | 

### Return type

[**ApiResponsePageOrdonnance**](ApiResponsePageOrdonnance.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **update**
> ApiResponseOrdonnance update(id, ordonnance)

Modifier une ordonnance

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = OrdonnancesApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ordonnance = Ordonnance(); // Ordonnance | 

try {
    final result = api_instance.update(id, ordonnance);
    print(result);
} catch (e) {
    print('Exception when calling OrdonnancesApi->update: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **ordonnance** | [**Ordonnance**](Ordonnance.md)|  | 

### Return type

[**ApiResponseOrdonnance**](ApiResponseOrdonnance.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


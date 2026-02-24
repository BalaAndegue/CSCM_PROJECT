# carnet_medical_api.api.DashboardApi

## Load the API package
```dart
import 'package:carnet_medical_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**dashboardAdmin**](DashboardApi.md#dashboardadmin) | **GET** /dashboard/admin | Dashboard admin – vue globale de la plateforme
[**dashboardManager**](DashboardApi.md#dashboardmanager) | **GET** /dashboard/manager | Dashboard manager hôpital
[**dashboardMedecin**](DashboardApi.md#dashboardmedecin) | **GET** /dashboard/medecin | Dashboard médecin – statistiques et accès patients
[**dashboardPatient**](DashboardApi.md#dashboardpatient) | **GET** /dashboard/patient | Dashboard patient – résumé de son carnet


# **dashboardAdmin**
> ApiResponseMapStringObject dashboardAdmin()

Dashboard admin – vue globale de la plateforme

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DashboardApi();

try {
    final result = api_instance.dashboardAdmin();
    print(result);
} catch (e) {
    print('Exception when calling DashboardApi->dashboardAdmin: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponseMapStringObject**](ApiResponseMapStringObject.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **dashboardManager**
> ApiResponseMapStringObject dashboardManager()

Dashboard manager hôpital

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DashboardApi();

try {
    final result = api_instance.dashboardManager();
    print(result);
} catch (e) {
    print('Exception when calling DashboardApi->dashboardManager: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponseMapStringObject**](ApiResponseMapStringObject.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **dashboardMedecin**
> ApiResponseMapStringObject dashboardMedecin()

Dashboard médecin – statistiques et accès patients

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DashboardApi();

try {
    final result = api_instance.dashboardMedecin();
    print(result);
} catch (e) {
    print('Exception when calling DashboardApi->dashboardMedecin: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponseMapStringObject**](ApiResponseMapStringObject.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **dashboardPatient**
> ApiResponseMapStringObject dashboardPatient()

Dashboard patient – résumé de son carnet

### Example
```dart
import 'package:carnet_medical_api/api.dart';
// TODO Configure HTTP Bearer authorization: Bearer_Authentication
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('Bearer_Authentication').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DashboardApi();

try {
    final result = api_instance.dashboardPatient();
    print(result);
} catch (e) {
    print('Exception when calling DashboardApi->dashboardPatient: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponseMapStringObject**](ApiResponseMapStringObject.md)

### Authorization

[Bearer_Authentication](../README.md#Bearer_Authentication)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


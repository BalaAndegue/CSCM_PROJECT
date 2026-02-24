# carnet_medical_api.model.Ordonnance

## Load the model package
```dart
import 'package:carnet_medical_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | [optional] 
**consultation** | [**Consultation**](Consultation.md) |  | [optional] 
**carnet** | [**CarnetMedical**](CarnetMedical.md) |  | [optional] 
**medecin** | [**Medecin**](Medecin.md) |  | [optional] 
**hopital** | [**Hopital**](Hopital.md) |  | [optional] 
**datePrescription** | [**DateTime**](DateTime.md) |  | [optional] 
**dateExpiration** | [**DateTime**](DateTime.md) |  | [optional] 
**renouvelable** | **bool** |  | [optional] 
**nombreRenouvellements** | **int** |  | [optional] 
**numeroOrdonnance** | **String** |  | [optional] 
**medicaments** | [**List<Map<String, Object>>**](Map.md) |  | [optional] [default to const []]
**instructions** | **String** |  | [optional] 
**posologieDetaillee** | **String** |  | [optional] 
**notePharmacien** | **String** |  | [optional] 
**status** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



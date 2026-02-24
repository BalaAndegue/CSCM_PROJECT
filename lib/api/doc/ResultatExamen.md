# carnet_medical_api.model.ResultatExamen

## Load the model package
```dart
import 'package:carnet_medical_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | [optional] 
**examen** | [**Examen**](Examen.md) |  | [optional] 
**fichierResultat** | [**Document**](Document.md) |  | [optional] 
**valeursCles** | [**Map<String, Object>**](Object.md) |  | [optional] [default to const {}]
**interpretation** | **String** |  | [optional] 
**conclusion** | **String** |  | [optional] 
**medecinLecteur** | [**Medecin**](Medecin.md) |  | [optional] 
**dateLecture** | [**DateTime**](DateTime.md) |  | [optional] 
**normale** | **bool** |  | [optional] 
**valeursReference** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)



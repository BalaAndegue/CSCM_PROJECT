//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/administration_api.dart';
part 'api/allergies_api.dart';
part 'api/approbations_mdecins_api.dart';
part 'api/authentification_api.dart';
part 'api/carnets_mdicaux_api.dart';
part 'api/consentements_diagnostic_api.dart';
part 'api/consultations_api.dart';
part 'api/dashboard_api.dart';
part 'api/examens_api.dart';
part 'api/hpitaux_api.dart';
part 'api/mdecins_api.dart';
part 'api/ordonnances_api.dart';
part 'api/patients_api.dart';

part 'model/allergie.dart';
part 'model/api_response_allergie.dart';
part 'model/api_response_approbation_medecin.dart';
part 'model/api_response_carnet_medical.dart';
part 'model/api_response_consent_diagnostic_hopital.dart';
part 'model/api_response_consultation.dart';
part 'model/api_response_examen.dart';
part 'model/api_response_hopital.dart';
part 'model/api_response_list_allergie.dart';
part 'model/api_response_list_approbation_medecin.dart';
part 'model/api_response_list_medecin.dart';
part 'model/api_response_list_resultat_examen.dart';
part 'model/api_response_map_string_object.dart';
part 'model/api_response_medecin.dart';
part 'model/api_response_medecin_hopital.dart';
part 'model/api_response_object.dart';
part 'model/api_response_ordonnance.dart';
part 'model/api_response_page_consent_diagnostic_hopital.dart';
part 'model/api_response_page_consultation.dart';
part 'model/api_response_page_examen.dart';
part 'model/api_response_page_hopital.dart';
part 'model/api_response_page_medecin.dart';
part 'model/api_response_page_object.dart';
part 'model/api_response_page_ordonnance.dart';
part 'model/api_response_page_patient.dart';
part 'model/api_response_page_user.dart';
part 'model/api_response_patient.dart';
part 'model/api_response_resultat_examen.dart';
part 'model/api_response_void.dart';
part 'model/approbation_medecin.dart';
part 'model/carnet_medical.dart';
part 'model/consent_diagnostic_hopital.dart';
part 'model/consultation.dart';
part 'model/demande_consent_request.dart';
part 'model/document.dart';
part 'model/email_request.dart';
part 'model/examen.dart';
part 'model/hopital.dart';
part 'model/login_request.dart';
part 'model/medecin.dart';
part 'model/medecin_hopital.dart';
part 'model/motif_request.dart';
part 'model/notes_request.dart';
part 'model/ordonnance.dart';
part 'model/page_consent_diagnostic_hopital.dart';
part 'model/page_consultation.dart';
part 'model/page_examen.dart';
part 'model/page_hopital.dart';
part 'model/page_medecin.dart';
part 'model/page_object.dart';
part 'model/page_ordonnance.dart';
part 'model/page_patient.dart';
part 'model/page_user.dart';
part 'model/pageable.dart';
part 'model/pageable_object.dart';
part 'model/patient.dart';
part 'model/raison_request.dart';
part 'model/refresh_request.dart';
part 'model/register_medecin_request.dart';
part 'model/register_patient_request.dart';
part 'model/reset_password_request.dart';
part 'model/resultat_examen.dart';
part 'model/service_request.dart';
part 'model/signature_request.dart';
part 'model/sort_object.dart';
part 'model/update_medecin_request.dart';
part 'model/user.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';

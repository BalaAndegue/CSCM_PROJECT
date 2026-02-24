import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';

// ─── Patient Profile ──────────────────────────────────────────────────────────
final currentPatientProvider = FutureProvider<Patient?>((ref) async {
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await PatientsApi(clientAsync).getMyProfile();
    return response?.data;
  } catch (_) {
    return null;
  }
});

// ─── Carnet Medical ID for the logged-in patient ──────────────────────────────
final patientCarnetProvider = FutureProvider<CarnetMedical?>((ref) async {
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await CarnetsMdicauxApi(clientAsync).getMyCarnet();
    return response?.data;
  } catch (_) {
    return null;
  }
});

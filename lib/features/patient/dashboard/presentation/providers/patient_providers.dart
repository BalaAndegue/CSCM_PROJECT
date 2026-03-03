import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';

// ─── Patient Profile ──────────────────────────────────────────────────────────
final currentPatientProvider = FutureProvider<Patient?>((ref) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await PatientsApi(client).getMyProfile();
    return response?.data;
  } catch (_) {
    return null;
  }
});

// ─── Carnet médical du patient connecté ──────────────────────────────────────
final patientCarnetProvider = FutureProvider<CarnetMedical?>((ref) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await CarnetsMdicauxApi(client).getMyCarnet();
    return response?.data;
  } catch (_) {
    return null;
  }
});

// ─── Dashboard patient (données agrégées du backend) ─────────────────────────
final patientDashboardProvider =
    FutureProvider<Map<String, Object?>>((ref) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await DashboardApi(client).dashboardPatient();
    return response?.data ?? {};
  } catch (_) {
    return {};
  }
});

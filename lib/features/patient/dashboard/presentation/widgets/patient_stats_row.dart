import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../providers/patient_providers.dart';

// Stats providers
final consultationsCountProvider = FutureProvider<int>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return 0;
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await ConsultationsApi(clientAsync)
        .getByCarnet2(carnet!.id!, Pageable(page: 0, size: 1));
    return response?.data?.totalElements ?? 0;
  } catch (_) {
    return 0;
  }
});

final allergiesCountProvider = FutureProvider<int>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return 0;
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response =
        await AllergiesApi(clientAsync).getByCarnet3(carnet!.id!);
    return response?.data?.length ?? 0;
  } catch (_) {
    return 0;
  }
});

final examensCountProvider = FutureProvider<int>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return 0;
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await ExamensApi(clientAsync)
        .getByCarnet1(carnet!.id!, Pageable(page: 0, size: 1));
    return response?.data?.totalElements ?? 0;
  } catch (_) {
    return 0;
  }
});

class PatientStatsRow extends ConsumerWidget {
  const PatientStatsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consultations = ref.watch(consultationsCountProvider);
    final allergies = ref.watch(allergiesCountProvider);
    final examens = ref.watch(examensCountProvider);

    return Row(
      children: [
        Expanded(
            child: _StatTile(
          icon: Icons.medical_services_outlined,
          label: 'Consultations',
          asyncValue: consultations,
          color: AppColors.primary,
        )),
        const SizedBox(width: 12),
        Expanded(
            child: _StatTile(
          icon: Icons.warning_amber_outlined,
          label: 'Allergies',
          asyncValue: allergies,
          color: AppColors.warning,
        )),
        const SizedBox(width: 12),
        Expanded(
            child: _StatTile(
          icon: Icons.biotech_outlined,
          label: 'Examens',
          asyncValue: examens,
          color: AppColors.secondary,
        )),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.asyncValue,
    required this.color,
  });

  final IconData icon;
  final String label;
  final AsyncValue<int> asyncValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? AppColors.outlineVariantDark
              : AppColors.outlineVariantLight,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          asyncValue.when(
            data: (count) => Text(
              '$count',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            loading: () => SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: color)),
            error: (_, __) => Text('—',
                style: TextStyle(color: color, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../providers/patient_providers.dart';

final recentConsultationsProvider =
    FutureProvider<List<Consultation>>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return [];
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await ConsultationsApi(clientAsync)
        .getByCarnet2(carnet!.id!, Pageable(page: 0, size: 3));
    return response?.data?.content ?? [];
  } catch (_) {
    return [];
  }
});

class RecentActivityCard extends ConsumerWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consultationsAsync = ref.watch(recentConsultationsProvider);

    return consultationsAsync.when(
      data: (list) {
        if (list.isEmpty) {
          return _EmptyActivity();
        }
        return Column(
          children: list
              .map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ActivityItem(consultation: c),
                  ))
              .toList(),
        );
      },
      loading: () => Column(
        children: List.generate(
            3, (_) => const Padding(padding: EdgeInsets.only(bottom: 12), child: _SkeletonItem())),
      ),
      error: (_, __) =>
          const Center(child: Text('Impossible de charger l\'activité')),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({required this.consultation});
  final Consultation consultation;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.outlineVariantDark : AppColors.outlineVariantLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.medical_services_outlined,
                color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  consultation.motif ?? 'Consultation',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _fmtDate(consultation.dateConsultation),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded,
              color: AppColors.onSurfaceVariantLight, size: 20),
        ],
      ),
    );
  }

  String _fmtDate(DateTime? d) {
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}

class _SkeletonItem extends StatelessWidget {
  const _SkeletonItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class _EmptyActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.history_outlined,
                size: 48,
                color: AppColors.onSurfaceVariantLight.withAlpha(80)),
            const SizedBox(height: 12),
            Text(
              'Aucune activité récente',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.onSurfaceVariantLight),
            ),
          ],
        ),
      ),
    );
  }
}

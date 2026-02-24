import 'package:flutter/material.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/theme/app_colors.dart';

class PatientHealthSummaryCard extends StatelessWidget {
  const PatientHealthSummaryCard({super.key, required this.patient});
  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outlineVariantLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.favorite_outline_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Résumé de santé',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Health metrics grid
          Row(
            children: [
              Expanded(
                child: _HealthMetric(
                  label: 'Groupe sanguin',
                  value: _bloodGroupLabel(patient?.groupeSanguin),
                  icon: Icons.water_drop_outlined,
                  color: AppColors.heartRate,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HealthMetric(
                  label: 'Genre',
                  value: _genreLabel(patient?.genre),
                  icon: Icons.person_outline_rounded,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _HealthMetric(
                  label: 'Situation',
                  value: _situationLabel(patient?.situationFamiliale),
                  icon: Icons.people_outline_rounded,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HealthMetric(
                  label: 'Profession',
                  value: patient?.profession ?? 'Non renseigné',
                  icon: Icons.work_outline_rounded,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          if (patient?.antecedentsMedicaux != null) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              '📋 Antécédents médicaux',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.onSurfaceVariantLight,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              patient!.antecedentsMedicaux!,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  String _bloodGroupLabel(PatientGroupeSanguinEnum? g) {
    if (g == null) return 'N/A';
    return g.value.replaceAll('_', '');
  }

  String _genreLabel(PatientGenreEnum? g) {
    if (g == null) return 'N/A';
    switch (g) {
      case PatientGenreEnum.M:
        return 'Masculin';
      case PatientGenreEnum.F:
        return 'Féminin';
      default:
        return 'Autre';
    }
  }

  String _situationLabel(PatientSituationFamilialeEnum? s) {
    if (s == null) return 'N/A';
    switch (s) {
      case PatientSituationFamilialeEnum.CELIBATAIRE:
        return 'Célibataire';
      case PatientSituationFamilialeEnum.MARIE:
        return 'Marié(e)';
      case PatientSituationFamilialeEnum.DIVORCE:
        return 'Divorcé(e)';
      case PatientSituationFamilialeEnum.VEUF:
        return 'Veuf/Veuve';
      default:
        return 'N/A';
    }
  }
}

class _HealthMetric extends StatelessWidget {
  const _HealthMetric({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outlineVariantLight),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurfaceVariantLight,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurfaceLight,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

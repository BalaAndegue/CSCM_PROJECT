import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/app_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';

// Providers
final medecinProfileProvider = FutureProvider<Medecin?>((ref) async {
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await MdecinsApi(clientAsync).getMyProfile1();
    return response?.data;
  } catch (_) {
    return null;
  }
});

// Recent patients who had appointments with this medecin
final recentPatientsProvider = FutureProvider<List<Patient>>((ref) async {
  final medecin = await ref.watch(medecinProfileProvider.future);
  if (medecin?.id == null) return [];
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    // Get consultations by this medecin and extract unique patients
    final response = await ConsultationsApi(clientAsync)
        .getByMedecin(medecin!.id!, Pageable(page: 0, size: 10));
    final consultations = response?.data?.content ?? [];
    // Collect unique patients from consultations
    final seen = <String>{};
    final patients = <Patient>[];
    for (final c in consultations) {
      if (c.carnet?.patient?.id != null &&
          seen.add(c.carnet!.patient!.id!)) {
        patients.add(c.carnet!.patient!);
      }
    }
    return patients.take(5).toList();
  } catch (_) {
    return [];
  }
});

// ─── Main Dashboard Page ──────────────────────────────────────────────────────

class MedecinDashboardPage extends ConsumerWidget {
  const MedecinDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medecinAsync = ref.watch(medecinProfileProvider);
    final patientsAsync = ref.watch(recentPatientsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MedecinAppBar(medecinAsync: medecinAsync, ref: ref),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Search patient card
                _SearchPatientCard(onTap: () =>
                    context.push(AppRoutes.medecinSearch)),
                const SizedBox(height: 24),

                // Stats row
                medecinAsync.when(
                  data: (m) => _MedecinStatsRow(medecin: m),
                  loading: () => const _SkeletonRow(),
                  error: (_, __) => const SizedBox(),
                ),
                const SizedBox(height: 24),

                // Recent patients section
                Text(
                  'Patients récents',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),

                patientsAsync.when(
                  data: (patients) => patients.isEmpty
                      ? const _EmptyPatients()
                      : Column(
                          children: patients
                              .map((p) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12),
                                    child: _PatientRecentCard(patient: p),
                                  ))
                              .toList(),
                        ),
                  loading: () => Column(
                    children: List.generate(
                      3,
                      (_) => const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: _SkeletonItem(),
                      ),
                    ),
                  ),
                  error: (_, __) =>
                      const Text('Impossible de charger les patients'),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── App Bar ─────────────────────────────────────────────────────────────────

class _MedecinAppBar extends StatelessWidget {
  const _MedecinAppBar({required this.medecinAsync, required this.ref});
  final AsyncValue<Medecin?> medecinAsync;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF007268), Color(0xFF00A896), Color(0xFF33C4B5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: medecinAsync.when(
                data: (m) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            color: Colors.white.withAlpha(80), width: 2),
                      ),
                      child: Center(
                        child: Text(
                          m?.user?.nomComplet?.isNotEmpty == true
                              ? m!.user!.nomComplet![0].toUpperCase()
                              : 'M',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dr. ${m?.user?.nomComplet ?? ''}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                          if (m?.specialite != null)
                            Text(
                              m!.specialite!,
                              style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 14),
                            ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: (m?.disponible == true
                                      ? AppColors.success
                                      : AppColors.warning)
                                  .withAlpha(40),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: (m?.disponible == true
                                        ? AppColors.success
                                        : AppColors.warning)
                                    .withAlpha(100),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: m?.disponible == true
                                        ? AppColors.success
                                        : AppColors.warning,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  m?.disponible == true
                                      ? 'Disponible'
                                      : 'Indisponible',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: m?.disponible == true
                                        ? AppColors.success
                                        : AppColors.warning,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout_outlined, color: Colors.white),
          onPressed: () => ref.read(authProvider.notifier).logout(),
        ),
      ],
    );
  }
}

// ─── Search Card ──────────────────────────────────────────────────────────────

class _SearchPatientCard extends StatelessWidget {
  const _SearchPatientCard({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withAlpha(60),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.person_search_outlined,
                  color: Colors.white, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rechercher un patient',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Accédez au dossier d\'un patient',
                    style: TextStyle(
                        color: Colors.white.withAlpha(200), fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}

// ─── Stats Row ────────────────────────────────────────────────────────────────

class _MedecinStatsRow extends StatelessWidget {
  const _MedecinStatsRow({required this.medecin});
  final Medecin? medecin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _StatChip(
          icon: Icons.work_outline_rounded,
          label: 'Expérience',
          value: '${medecin?.anneesExperience ?? 0} ans',
          color: AppColors.medecinColor,
        )),
        const SizedBox(width: 12),
        Expanded(
            child: _StatChip(
          icon: Icons.school_outlined,
          label: 'Diplômes',
          value: '${medecin?.diplomes?.length ?? 0}',
          color: AppColors.secondary,
        )),
        const SizedBox(width: 12),
        Expanded(
            child: _StatChip(
          icon: Icons.payments_outlined,
          label: 'Consultation',
          value: medecin?.consultationFee != null
              ? '${medecin!.consultationFee!.toStringAsFixed(0)} DA'
              : 'N/A',
          color: AppColors.success,
        )),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: isDark
                ? AppColors.outlineVariantDark
                : AppColors.outlineVariantLight),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color)),
          Text(label,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// ─── Recent Patient Card ──────────────────────────────────────────────────────

class _PatientRecentCard extends StatelessWidget {
  const _PatientRecentCard({required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () =>
          context.push(AppRoutes.patientDossierPath(patient.id ?? '')),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark
                ? AppColors.outlineVariantDark
                : AppColors.outlineVariantLight,
          ),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'patient-avatar-${patient.id}',
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    patient.user?.nomComplet?.isNotEmpty == true
                        ? patient.user!.nomComplet![0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.user?.nomComplet ?? 'Patient',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  if (patient.numeroCarnet != null)
                    Text('N° ${patient.numeroCarnet}',
                        style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppColors.onSurfaceVariantLight),
          ],
        ),
      ),
    );
  }
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

class _EmptyPatients extends StatelessWidget {
  const _EmptyPatients();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(Icons.people_outline,
              size: 56,
              color: AppColors.onSurfaceVariantLight.withAlpha(80)),
          const SizedBox(height: 12),
          Text(
            'Aucun patient récent',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.onSurfaceVariantLight),
          ),
        ],
      ),
    );
  }
}

class _SkeletonRow extends StatelessWidget {
  const _SkeletonRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (i) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < 2 ? 12 : 0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkeletonItem extends StatelessWidget {
  const _SkeletonItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carnet_medical_api/api.dart';
import 'dart:convert';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/app_router.dart';
import '../../../../shared/presentation/pages/qr_scanner_page.dart';

// ─── Providers ──────────────────────────────────────────────────────────────

final medecinProfileProvider = FutureProvider<Medecin?>((ref) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await MdecinsApi(client).getMyProfile1();
    return response?.data;
  } catch (_) {
    return null;
  }
});

// Dashboard agrégé backend
final medecinDashboardProvider =
    FutureProvider<Map<String, Object?>>((ref) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await DashboardApi(client).dashboardMedecin();
    return response?.data ?? {};
  } catch (_) {
    return {};
  }
});

// Liste des approbations actives du médecin (patients autorisés)
final mesAccesProvider =
    FutureProvider<List<ApprobationMedecin>>((ref) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await ApprobationsMdecinsApi(client).getMesAcces();
    return (response?.data ?? []).where((a) => a.actif == true).toList();
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
    final accesAsync = ref.watch(mesAccesProvider);

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

                // Mes patients autorisés
                Text(
                  'Mes patients autorisés',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),

                accesAsync.when(
                  data: (accList) => accList.isEmpty
                      ? const _EmptyPatients()
                      : Column(
                          children: accList
                              .map((a) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: _AccesPatientCard(
                                      approbation: a,
                                      onTap: () {
                                        final pid = a.carnet?.patient?.id;
                                        if (pid != null) {
                                          context.push(
                                              AppRoutes.patientDossierPath(pid));
                                        }
                                      },
                                    ),
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
      // Avatar tappable → profil médecin
      leading: GestureDetector(
        onTap: () => context.go(AppRoutes.medecinProfile),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: medecinAsync.when(
            data: (m) => CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white.withAlpha(30),
              child: Text(
                m?.user?.nomComplet?.isNotEmpty == true
                    ? m!.user!.nomComplet![0].toUpperCase()
                    : 'M',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            loading: () => const CircleAvatar(
                radius: 18, backgroundColor: Colors.white30),
            error: (_, __) => const CircleAvatar(radius: 18),
          ),
        ),
      ),
      actions: [
        // QR scanner pour lire le QR patient
        IconButton(
          icon: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white),
          tooltip: 'Scanner patient',
          onPressed: () => _openQrScanner(context),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          tooltip: 'Notifications',
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  void _openQrScanner(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => QrScannerPage(
        title: 'Scanner patient',
        subtitle: 'Scannez le QR code du carnet du patient',
        accentColor: AppColors.medecinColor,
        onResult: (raw) async {
          // Attend JSON {"type":"patient","carnetId":"xxx","patientId":"xxx"}
          String? patientId;
          try {
            final j = jsonDecode(raw) as Map<String, dynamic>;
            if (j['type'] == 'patient') {
              patientId = j['patientId'] as String?;
            }
          } catch (_) {
            patientId = raw.trim();
          }
          if (patientId == null || patientId.isEmpty) return false;
          if (context.mounted) {
            context.pop();
            context.push(AppRoutes.patientDossierPath(patientId));
          }
          return true;
        },
      ),
    ));
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
          value: '${(medecin?.diplomes ?? []).length}',
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

// ─── Accès Patient Card (from mesAccesProvider) ──────────────────────────────

class _AccesPatientCard extends StatelessWidget {
  const _AccesPatientCard({required this.approbation, required this.onTap});
  final ApprobationMedecin approbation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final patient = approbation.carnet?.patient;
    final name = patient?.user?.nomComplet ?? 'Patient';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final numCarnet = patient?.numeroCarnet;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark
                ? AppColors.outlineVariantDark
                : const Color(0xFFB2EDE8),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
                color: AppColors.medecinColor.withAlpha(10),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF007268), Color(0xFF00A896)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(initial,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  if (numCarnet != null)
                    Text('N° $numCarnet',
                        style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Actif',
                  style: TextStyle(
                      color: AppColors.success,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppColors.onSurfaceVariantLight),
          ],
        ),
      ),
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/providers/theme_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../../../patient/dashboard/presentation/providers/patient_providers.dart';

// ─── Providers ────────────────────────────────────────────────────────────────
final patientProfileUpdateProvider =
    StateNotifierProvider<_PatientProfileNotifier, AsyncValue<void>>(
  (ref) => _PatientProfileNotifier(ref),
);

class _PatientProfileNotifier extends StateNotifier<AsyncValue<void>> {
  _PatientProfileNotifier(this._ref) : super(const AsyncValue.data(null));
  final Ref _ref;

  Future<void> update(Patient patient) async {
    state = const AsyncValue.loading();
    try {
      final client =
          await _ref.read(authenticatedApiClientProvider.future);
      await PatientsApi(client).updateMyProfile(patient);
      _ref.invalidate(currentPatientProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// ─── Page principale ──────────────────────────────────────────────────────────
class PatientProfilePage extends ConsumerStatefulWidget {
  const PatientProfilePage({super.key});

  @override
  ConsumerState<PatientProfilePage> createState() =>
      _PatientProfilePageState();
}

class _PatientProfilePageState extends ConsumerState<PatientProfilePage> {
  @override
  Widget build(BuildContext context) {
    final patientAsync = ref.watch(currentPatientProvider);
    final carnetAsync = ref.watch(patientCarnetProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // ── App Bar Hero ─────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _ProfileHeroHeader(
                patientAsync: patientAsync,
                carnetAsync: carnetAsync,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Info carnet ───────────────────────────────────────────
                carnetAsync.when(
                  data: (carnet) => carnet != null
                      ? _CarnetInfoCard(carnet: carnet)
                      : const SizedBox(),
                  loading: () => const _SkeletonCard(height: 100),
                  error: (_, __) => const SizedBox(),
                ),
                const SizedBox(height: 20),

                // ── Informations personnelles ─────────────────────────────
                patientAsync.when(
                  data: (patient) => patient != null
                      ? _PersonalInfoCard(patient: patient)
                      : const SizedBox(),
                  loading: () => const _SkeletonCard(height: 200),
                  error: (_, __) => const SizedBox(),
                ),
                const SizedBox(height: 20),

                // ── Paramètres de l'application ───────────────────────────
                const _AppSettingsCard(),
                const SizedBox(height: 20),

                // ── Déconnexion ───────────────────────────────────────────
                _LogoutButton(ref: ref),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Hero Header ──────────────────────────────────────────────────────────────
class _ProfileHeroHeader extends StatelessWidget {
  const _ProfileHeroHeader({
    required this.patientAsync,
    required this.carnetAsync,
  });
  final AsyncValue<Patient?> patientAsync;
  final AsyncValue<CarnetMedical?> carnetAsync;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D4DA1), Color(0xFF1E6FD9), Color(0xFF4A8FEA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              patientAsync.when(
                data: (patient) {
                  final initial =
                      patient?.user?.nomComplet?.isNotEmpty == true
                          ? patient!.user!.nomComplet![0].toUpperCase()
                          : '?';
                  return Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF5B9AF4), Color(0xFF7C6FF7)],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white.withAlpha(120), width: 3),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withAlpha(40),
                                blurRadius: 20,
                                offset: const Offset(0, 6)),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            initial,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        patient?.user?.nomComplet ?? 'Patient',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        patient?.user?.email ?? '',
                        style: TextStyle(
                          color: Colors.white.withAlpha(180),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
                error: (_, __) =>
                    const Icon(Icons.person_rounded, color: Colors.white, size: 60),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Carnet Info Card ─────────────────────────────────────────────────────────
class _CarnetInfoCard extends StatelessWidget {
  const _CarnetInfoCard({required this.carnet});
  final CarnetMedical carnet;

  @override
  Widget build(BuildContext context) {
    final patient = carnet.patient;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E6FD9), Color(0xFF00A896)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: AppColors.primary.withAlpha(50),
              blurRadius: 20,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.credit_card_rounded,
                color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Carnet Médical',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                Text(
                  'N° ${patient?.numeroCarnet ?? '—'}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1),
                ),
                const SizedBox(height: 4),
                Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      carnet.statut ?? 'ACTIF',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  if (patient?.groupeSanguin != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      '🩸 ${patient!.groupeSanguin!.value}',
                      style: TextStyle(
                          color: Colors.white.withAlpha(200), fontSize: 12),
                    ),
                  ],
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Informations personnelles ────────────────────────────────────────────────
class _PersonalInfoCard extends StatelessWidget {
  const _PersonalInfoCard({required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Informations personnelles',
      icon: Icons.person_rounded,
      iconColor: AppColors.primary,
      child: Column(
        children: [
          _InfoRow(
              icon: Icons.badge_rounded,
              label: 'Nom complet',
              value: patient.user?.nomComplet ?? '—'),
          _InfoRow(
              icon: Icons.email_rounded,
              label: 'Email',
              value: patient.user?.email ?? '—'),
          _InfoRow(
              icon: Icons.phone_rounded,
              label: 'Téléphone',
              value: patient.telephone ?? '—'),
          _InfoRow(
              icon: Icons.cake_rounded,
              label: 'Date de naissance',
              value: patient.dateNaissance != null
                  ? _fmtDate(patient.dateNaissance!)
                  : '—'),
          _InfoRow(
              icon: Icons.wc_rounded,
              label: 'Genre',
              value: patient.genre?.value ?? '—'),
          _InfoRow(
              icon: Icons.location_on_rounded,
              label: 'Adresse',
              value: patient.adresse ?? '—'),
          if (patient.contactUrgenceNom != null)
            _InfoRow(
                icon: Icons.emergency_rounded,
                label: 'Contact urgence',
                value:
                    '${patient.contactUrgenceNom} – ${patient.contactUrgenceTelephone ?? ''}'),
        ],
      ),
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

// ─── App Settings Card ────────────────────────────────────────────────────────
class _AppSettingsCard extends ConsumerWidget {
  const _AppSettingsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return _SectionCard(
      title: 'Paramètres de l\'application',
      icon: Icons.settings_rounded,
      iconColor: AppColors.accent,
      child: Column(
        children: [
          _SettingsTile(
            icon: isDark
                ? Icons.dark_mode_rounded
                : Icons.light_mode_rounded,
            iconColor: isDark ? AppColors.accent : AppColors.warning,
            label: 'Thème',
            subtitle: isDark ? 'Mode sombre' : 'Mode clair',
            trailing: Switch.adaptive(
              value: isDark,
              activeColor: AppColors.primary,
              onChanged: (v) => ref
                  .read(themeModeProvider.notifier)
                  .state = v ? ThemeMode.dark : ThemeMode.light,
            ),
          ),
          const Divider(height: 1, indent: 56),
          _SettingsTile(
            icon: Icons.language_rounded,
            iconColor: AppColors.secondary,
            label: 'Langue',
            subtitle: 'Français',
            trailing: const Icon(Icons.chevron_right_rounded,
                color: AppColors.onSurfaceVariantLight),
            onTap: () => _showLanguageDialog(context),
          ),
          const Divider(height: 1, indent: 56),
          _SettingsTile(
            icon: Icons.notifications_rounded,
            iconColor: AppColors.warning,
            label: 'Notifications',
            subtitle: 'Activées',
            trailing: const Icon(Icons.chevron_right_rounded,
                color: AppColors.onSurfaceVariantLight),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 56),
          _SettingsTile(
            icon: Icons.security_rounded,
            iconColor: AppColors.success,
            label: 'Sécurité',
            subtitle: 'Authentification JWT',
            trailing: const Icon(Icons.chevron_right_rounded,
                color: AppColors.onSurfaceVariantLight),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 56),
          _SettingsTile(
            icon: Icons.info_rounded,
            iconColor: AppColors.info,
            label: 'Version',
            subtitle: 'CSCM v1.0.0',
            trailing: const SizedBox(),
            onTap: null,
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Langue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇫🇷', style: TextStyle(fontSize: 24)),
              title: const Text('Français'),
              trailing: const Icon(Icons.check_rounded,
                  color: AppColors.primary),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
              title: const Text('English'),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Logout Button ────────────────────────────────────────────────────────────
class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.error.withAlpha(10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.error.withAlpha(30)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.error.withAlpha(15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.logout_rounded,
              color: AppColors.error, size: 22),
        ),
        title: const Text(
          'Se déconnecter',
          style: TextStyle(
              color: AppColors.error, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Terminer la session en cours',
          style: TextStyle(
              color: AppColors.error.withAlpha(150), fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: AppColors.error),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onTap: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Déconnexion'),
              content: const Text(
                  'Êtes-vous sûr de vouloir vous déconnecter ?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Annuler')),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  style: FilledButton.styleFrom(
                      backgroundColor: AppColors.error),
                  child: const Text('Déconnecter'),
                ),
              ],
            ),
          );
          if (confirm == true) {
            ref.read(authProvider.notifier).logout();
          }
        },
      ),
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
  });
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color:
                isDark ? AppColors.outlineVariantDark : AppColors.outlineVariantLight),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(isDark ? 20 : 8),
              blurRadius: 20,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: iconColor.withAlpha(18),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 10),
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ]),
          ),
          const Divider(height: 1),
          child,
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(12),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: AppColors.primary, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppColors.onSurfaceVariantLight)),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500)),
          ]),
        ),
      ]),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });
  final IconData icon;
  final Color iconColor;
  final String label;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: iconColor.withAlpha(15),
            borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(label,
          style:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(subtitle,
          style: const TextStyle(
              fontSize: 12, color: AppColors.onSurfaceVariantLight)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24)),
    );
  }
}

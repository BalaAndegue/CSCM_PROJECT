import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/theme_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../../../medecin/dashboard/presentation/pages/medecin_dashboard_page.dart';

// ─── Page principale ──────────────────────────────────────────────────────────
class MedecinProfilePage extends ConsumerWidget {
  const MedecinProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medecinAsync = ref.watch(medecinProfileProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _MedecinHeroHeader(medecinAsync: medecinAsync),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                medecinAsync.when(
                  data: (medecin) => medecin != null
                      ? _MedecinInfoCard(medecin: medecin)
                      : const SizedBox(),
                  loading: () => _SkeletonCard(height: 180),
                  error: (_, __) => const SizedBox(),
                ),
                const SizedBox(height: 20),
                const _AppSettingsMedecin(),
                const SizedBox(height: 20),
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
class _MedecinHeroHeader extends StatelessWidget {
  const _MedecinHeroHeader({required this.medecinAsync});
  final AsyncValue<Medecin?> medecinAsync;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF005A54), Color(0xFF007268), Color(0xFF00A896)],
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
              medecinAsync.when(
                data: (medecin) {
                  final initial =
                      medecin?.user?.nomComplet?.isNotEmpty == true
                          ? medecin!.user!.nomComplet![0].toUpperCase()
                          : 'M';
                  return Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF33C4B5),
                              Color(0xFF00A896)
                            ],
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
                        'Dr. ${medecin?.user?.nomComplet ?? 'Médecin'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        medecin?.specialite ?? '',
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (medecin?.numeroOrdre != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(20),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'N° Ord. ${medecin!.numeroOrdre}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
                error: (_, __) => const Icon(
                    Icons.medical_services_rounded,
                    color: Colors.white,
                    size: 60),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Informations médecin ─────────────────────────────────────────────────────
class _MedecinInfoCard extends StatelessWidget {
  const _MedecinInfoCard({required this.medecin});
  final Medecin medecin;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Profil professionnel',
      icon: Icons.medical_services_rounded,
      iconColor: AppColors.medecinColor,
      children: [
        _InfoRow(
            icon: Icons.badge_rounded,
            label: 'Nom complet',
            value: 'Dr. ${medecin.user?.nomComplet ?? '—'}'),
        _InfoRow(
            icon: Icons.email_rounded,
            label: 'Email',
            value: medecin.user?.email ?? '—'),
        _InfoRow(
            icon: Icons.local_hospital_rounded,
            label: 'Spécialité',
            value: medecin.specialite ?? '—'),
        if (medecin.sousSpecialite != null)
          _InfoRow(
              icon: Icons.medical_information_rounded,
              label: 'Sous-spécialité',
              value: medecin.sousSpecialite!),
        _InfoRow(
            icon: Icons.card_membership_rounded,
            label: 'N° Ordre',
            value: medecin.numeroOrdre ?? '—'),
        _InfoRow(
            icon: Icons.credit_card_rounded,
            label: 'Carte professionnelle',
            value: medecin.numeroCarteProfessionnelle ?? '—'),
        if (medecin.anneesExperience != null)
          _InfoRow(
              icon: Icons.timeline_rounded,
              label: 'Expérience',
              value: '${medecin.anneesExperience} ans'),
        _InfoRow(
            icon: Icons.verified_rounded,
            label: 'Statut',
            value: medecin.status?.value ?? '—'),
      ],
    );
  }
}

// ─── App Settings Médecin ─────────────────────────────────────────────────────
class _AppSettingsMedecin extends ConsumerWidget {
  const _AppSettingsMedecin();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return _SectionCard(
      title: 'Paramètres',
      icon: Icons.settings_rounded,
      iconColor: AppColors.accent,
      children: [
        _SettingsTile(
          icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          iconColor: isDark ? AppColors.accent : AppColors.warning,
          label: 'Thème',
          subtitle: isDark ? 'Mode sombre' : 'Mode clair',
          trailing: Switch.adaptive(
            value: isDark,
            activeColor: AppColors.medecinColor,
            onChanged: (v) => ref.read(themeModeProvider.notifier).state =
                v ? ThemeMode.dark : ThemeMode.light,
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
          onTap: () {},
        ),
        const Divider(height: 1, indent: 56),
        _SettingsTile(
          icon: Icons.notifications_rounded,
          iconColor: AppColors.warning,
          label: 'Notifications',
          subtitle: 'Rappels de consultations',
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
          child:
              const Icon(Icons.logout_rounded, color: AppColors.error, size: 22),
        ),
        title: const Text('Se déconnecter',
            style: TextStyle(
                color: AppColors.error, fontWeight: FontWeight.w600)),
        subtitle: Text('Terminer la session en cours',
            style:
                TextStyle(color: AppColors.error.withAlpha(150), fontSize: 12)),
        trailing:
            const Icon(Icons.chevron_right_rounded, color: AppColors.error),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
    required this.children,
  });
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: isDark
                ? AppColors.outlineVariantDark
                : AppColors.outlineVariantLight),
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
          ...children,
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
              color: AppColors.medecinColor.withAlpha(12),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: AppColors.medecinColor, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariantLight)),
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
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../providers/patient_providers.dart';
import '../widgets/patient_health_summary_card.dart';
import '../widgets/patient_quick_actions.dart';
import '../widgets/patient_stats_row.dart';
import '../widgets/recent_activity_card.dart';

class PatientDashboardPage extends ConsumerWidget {
  const PatientDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientAsync = ref.watch(currentPatientProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // === App Bar ===
          _PatientSliverAppBar(patientAsync: patientAsync, ref: ref),

          // === Content ===
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quick actions (floating) 
                const PatientQuickActions(),
                const SizedBox(height: 20),

                // Health summary card
                patientAsync.when(
                  data: (patient) => PatientHealthSummaryCard(patient: patient),
                  loading: () => const _CardSkeleton(height: 180),
                  error: (_, __) => const _ErrorCard(),
                ),
                const SizedBox(height: 20),

                // Stats row
                const PatientStatsRow(),
                const SizedBox(height: 24),

                // Section title
                Text(
                  'Activité récente',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),

                // Recent activity
                const RecentActivityCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientSliverAppBar extends StatelessWidget {
  const _PatientSliverAppBar({
    required this.patientAsync,
    required this.ref,
  });

  final AsyncValue<Patient?> patientAsync;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: isDark ? AppColors.darkHeroGradient : AppColors.heroGradient,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      patientAsync.when(
                        data: (patient) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bonjour,',
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              patient?.user?.nomComplet ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                        loading: () => const SizedBox(),
                        error: (_, __) => const SizedBox(),
                      ),
                      // Profile avatar with Hero
                      patientAsync.when(
                        data: (patient) => Hero(
                          tag: 'patient-avatar-${patient?.id}',
                          child: _ProfileAvatar(
                            name: patient?.user?.nomComplet?.isNotEmpty == true
                                ? patient!.user!.nomComplet![0].toUpperCase()
                                : '?',
                            photoUrl: null,
                          ),
                        ),
                        loading: () => const _AvatarSkeleton(),
                        error: (_, __) => const _ProfileAvatar(name: '?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Carnet number badge
                  patientAsync.maybeWhen(
                    data: (p) => p?.numeroCarnet != null
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(25),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withAlpha(50)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.credit_card_outlined,
                                    color: Colors.white, size: 14),
                                const SizedBox(width: 6),
                                Text(
                                  'N° ${p!.numeroCarnet}',
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(220),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    orElse: () => const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.logout_outlined, color: Colors.white),
          onPressed: () => ref.read(authProvider.notifier).logout(),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.name, this.photoUrl});

  final String name;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withAlpha(180), width: 2),
        color: Colors.white.withAlpha(30),
      ),
      child: photoUrl != null
          ? ClipOval(
              child: Image.network(
                photoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _initials(name),
              ),
            )
          : _initials(name),
    );
  }

  Widget _initials(String name) {
    return Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _AvatarSkeleton extends StatelessWidget {
  const _AvatarSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withAlpha(30),
      ),
    );
  }
}

class _CardSkeleton extends StatelessWidget {
  const _CardSkeleton({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.wifi_off_outlined, color: AppColors.error),
          SizedBox(width: 12),
          Text('Impossible de charger les données'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';

// ─── Providers ─────────────────────────────────────────────────────────────

final patientDossierProvider =
    FutureProvider.family<Patient?, String>((ref, patientId) async {
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await PatientsApi(clientAsync).getPatientById(patientId);
    return response?.data;
  } catch (_) {
    return null;
  }
});

// Fetch the patient's carnet by patient ID, then get data
final medecinPatientCarnetProvider =
    FutureProvider.family<CarnetMedical?, String>((ref, patientId) async {
  final patient = await ref.watch(patientDossierProvider(patientId).future);
  // CarnetMedical needs to be fetched via ApprobationsMdecins context
  // The patient object itself doesn't embed carnet, so we try approved medecin listing
  return null; // placeholder - carnet access via approbation context
});

final medecinConsultationsProvider =
    FutureProvider.family<List<Consultation>, String>((ref, medecinId) async {
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await ConsultationsApi(clientAsync)
        .getByMedecin(medecinId, Pageable(page: 0, size: 50));
    return response?.data?.content ?? [];
  } catch (_) {
    return [];
  }
});

final approvedPatientAllergiesProvider =
    FutureProvider.family<List<ApprobationMedecin>, String>(
        (ref, patientId) async {
  // Get approbations for this medecin - need the carnet ID from the approbation
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response =
        await ApprobationsMdecinsApi(clientAsync).getMedecinsApprouves(patientId);
    return response?.data ?? [];
  } catch (_) {
    return [];
  }
});

// ─── Main Dossier Page ───────────────────────────────────────────────────────

class PatientDossierPage extends ConsumerStatefulWidget {
  const PatientDossierPage({super.key, required this.patientId});
  final String patientId;

  @override
  ConsumerState<PatientDossierPage> createState() => _PatientDossierPageState();
}

class _PatientDossierPageState extends ConsumerState<PatientDossierPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patientAsync = ref.watch(patientDossierProvider(widget.patientId));

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _PatientDossierAppBar(
            patientAsync: patientAsync,
            patientId: widget.patientId,
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: AppColors.medecinColor,
                unselectedLabelColor: AppColors.onSurfaceVariantLight,
                indicatorColor: AppColors.medecinColor,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                unselectedLabelStyle:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                tabs: const [
                  Tab(text: 'Consultations'),
                  Tab(text: 'Allergies'),
                  Tab(text: 'Examens'),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _InfoTab(message: 'Consultations accessibles selon vos droits d\'accès', icon: Icons.medical_services_outlined),
            _InfoTab(message: 'Allergies accessibles selon vos droits d\'accès', icon: Icons.warning_amber_outlined),
            _InfoTab(message: 'Examens accessibles selon vos droits d\'accès', icon: Icons.biotech_outlined),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        backgroundColor: AppColors.medecinColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final tabIndex = _tabController.index;
    String title;
    switch (tabIndex) {
      case 0:
        title = 'Nouvelle consultation';
        break;
      case 1:
        title = 'Nouvelle allergie';
        break;
      default:
        title = 'Nouvel examen';
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: const TextField(
          decoration: InputDecoration(
            labelText: 'Motif / Description',
            hintText: 'Entrez le motif...',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Annuler')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            style: FilledButton.styleFrom(backgroundColor: AppColors.medecinColor),
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}

// ─── App Bar ─────────────────────────────────────────────────────────────────

class _PatientDossierAppBar extends StatelessWidget {
  const _PatientDossierAppBar({
    required this.patientAsync,
    required this.patientId,
  });

  final AsyncValue<Patient?> patientAsync;
  final String patientId;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
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
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: patientAsync.when(
                data: (patient) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'patient-avatar-$patientId',
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.white.withAlpha(100), width: 2),
                        ),
                        child: Center(
                          child: Text(
                            patient?.user?.nomComplet?.isNotEmpty == true
                                ? patient!.user!.nomComplet![0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patient?.user?.nomComplet ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3),
                          ),
                          const SizedBox(height: 4),
                          if (patient?.numeroCarnet != null)
                            Text('📋 N° ${patient!.numeroCarnet}',
                                style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 13)),
                          if (patient?.groupeSanguin != null)
                            Text(
                              '🩸 ${patient!.groupeSanguin!.value.replaceAll(RegExp(r'_PLUS|_MINUS'), '').replaceAll('_', '')}',
                              style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 13),
                            ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(25),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.white.withAlpha(50)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.lock_open_outlined,
                                    color: Colors.white, size: 13),
                                const SizedBox(width: 4),
                                Text(
                                  'Accès autorisé',
                                  style: TextStyle(
                                      color: Colors.white.withAlpha(220),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
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
    );
  }
}

// ─── Tab Bar Delegate ─────────────────────────────────────────────────────────

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  const _TabBarDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height + 1;

  @override
  double get maxExtent => tabBar.preferredSize.height + 1;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) => false;
}

// ─── Info Tab ─────────────────────────────────────────────────────────────────

class _InfoTab extends StatelessWidget {
  const _InfoTab({required this.message, required this.icon});
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 56, color: AppColors.medecinColor.withAlpha(80)),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariantLight,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

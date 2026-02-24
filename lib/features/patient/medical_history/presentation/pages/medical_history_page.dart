import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../patient/dashboard/presentation/providers/patient_providers.dart';

// ─── Providers ─────────────────────────────────────────────────────────────

final consultationsProvider = FutureProvider<List<Consultation>>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return [];
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await ConsultationsApi(clientAsync)
        .getByCarnet2(carnet!.id!, Pageable(page: 0, size: 50));
    return response?.data?.content ?? [];
  } catch (_) {
    return [];
  }
});

final allergiesProvider = FutureProvider<List<Allergie>>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return [];
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await AllergiesApi(clientAsync).getByCarnet3(carnet!.id!);
    return response?.data ?? [];
  } catch (_) {
    return [];
  }
});

final examensProvider = FutureProvider<List<Examen>>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return [];
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await ExamensApi(clientAsync)
        .getByCarnet1(carnet!.id!, Pageable(page: 0, size: 50));
    return response?.data?.content ?? [];
  } catch (_) {
    return [];
  }
});

// ─── Main Page ──────────────────────────────────────────────────────────────

class MedicalHistoryPage extends ConsumerStatefulWidget {
  const MedicalHistoryPage({super.key});

  @override
  ConsumerState<MedicalHistoryPage> createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends ConsumerState<MedicalHistoryPage>
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
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            title: const Text('Mon Carnet Médical'),
            bottom: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: AppColors.onSurfaceVariantLight,
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              tabs: const [
                Tab(text: 'Consultations'),
                Tab(text: 'Allergies'),
                Tab(text: 'Examens'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _ConsultationsList(ref: ref),
            _AllergiesList(ref: ref),
            _ExamensList(ref: ref),
          ],
        ),
      ),
    );
  }
}

// ─── Consultations ──────────────────────────────────────────────────────────

class _ConsultationsList extends StatelessWidget {
  const _ConsultationsList({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final consultationsAsync = ref.watch(consultationsProvider);

    return consultationsAsync.when(
      data: (list) => list.isEmpty
          ? _EmptyTab(label: 'Aucune consultation enregistrée', icon: Icons.medical_services_outlined)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _ConsultationCard(consultation: list[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur: $e')),
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  const _ConsultationCard({required this.consultation});
  final Consultation consultation;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.outlineVariantDark : AppColors.outlineVariantLight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(6), blurRadius: 12, offset: const Offset(0, 2)),
        ],
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
                child: const Icon(Icons.medical_services_outlined, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      consultation.motif ?? 'Consultation',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      _formatDate(consultation.dateConsultation),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              if (consultation.gravite != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _gravityColor(consultation.gravite?.value).withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    consultation.gravite!.value,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _gravityColor(consultation.gravite?.value),
                    ),
                  ),
                ),
            ],
          ),
          if (consultation.diagnostic != null) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              '🔍 ${consultation.diagnostic!}',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Color _gravityColor(String? g) {
    switch (g?.toUpperCase()) {
      case 'CRITIQUE':
      case 'GRAVE':
        return AppColors.error;
      case 'MODERE':
        return AppColors.warning;
      default:
        return AppColors.success;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

// ─── Allergies ──────────────────────────────────────────────────────────────

class _AllergiesList extends StatelessWidget {
  const _AllergiesList({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final allergiesAsync = ref.watch(allergiesProvider);

    return allergiesAsync.when(
      data: (list) => list.isEmpty
          ? _EmptyTab(label: 'Aucune allergie enregistrée', icon: Icons.warning_amber_outlined)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _AllergieCard(allergie: list[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Erreur de chargement')),
    );
  }
}

class _AllergieCard extends StatelessWidget {
  const _AllergieCard({required this.allergie});
  final Allergie allergie;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gravite = allergie.gravite?.value ?? '';
    final color = _graviteColor(gravite);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.warning_amber_rounded, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  allergie.nomAllergene ?? 'Allergène inconnu',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (allergie.typeAllergene != null)
                  Text('Type: ${allergie.typeAllergene}', style: Theme.of(context).textTheme.bodySmall),
                if (allergie.description != null)
                  Text(allergie.description!, style: Theme.of(context).textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          if (gravite.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(8)),
              child: Text(gravite, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
            ),
        ],
      ),
    );
  }

  Color _graviteColor(String g) {
    switch (g.toUpperCase()) {
      case 'GRAVE':
      case 'ANAPHYLAXIE':
        return AppColors.error;
      case 'MODEREE':
        return AppColors.warning;
      default:
        return AppColors.success;
    }
  }
}

// ─── Examens ─────────────────────────────────────────────────────────────────

class _ExamensList extends StatelessWidget {
  const _ExamensList({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final examensAsync = ref.watch(examensProvider);

    return examensAsync.when(
      data: (list) => list.isEmpty
          ? _EmptyTab(label: 'Aucun examen enregistré', icon: Icons.biotech_outlined)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _ExamenCard(examen: list[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Erreur de chargement')),
    );
  }
}

class _ExamenCard extends StatelessWidget {
  const _ExamenCard({required this.examen});
  final Examen examen;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final date = examen.dateRealisation ?? examen.datePrescription;
    final isUrgent = examen.urgent ?? false;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isUrgent
              ? AppColors.error.withAlpha(60)
              : isDark ? AppColors.outlineVariantDark : AppColors.outlineVariantLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondary.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.biotech_outlined, color: AppColors.secondary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  examen.typeExamen ?? 'Examen',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (examen.categorieExamen != null)
                  Text(examen.categorieExamen!, style: Theme.of(context).textTheme.bodySmall),
                if (date != null)
                  Text(_formatDate(date), style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          if (isUrgent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.error.withAlpha(20), borderRadius: BorderRadius.circular(8)),
              child: const Text('URGENT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.error)),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

// ─── Empty State ─────────────────────────────────────────────────────────────

class _EmptyTab extends StatelessWidget {
  const _EmptyTab({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 56, color: AppColors.onSurfaceVariantLight.withAlpha(100)),
          const SizedBox(height: 16),
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariantLight)),
        ],
      ),
    );
  }
}

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
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final resp = await ConsultationsApi(client)
        .getByCarnet2(carnet!.id!, Pageable(page: 0, size: 50));
    return resp?.data?.content ?? [];
  } catch (_) {
    return [];
  }
});

final allergiesProvider = FutureProvider<List<Allergie>>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return [];
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final resp = await AllergiesApi(client).getByCarnet3(carnet!.id!);
    return resp?.data ?? [];
  } catch (_) {
    return [];
  }
});

final examensProvider = FutureProvider<List<Examen>>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return [];
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final resp = await ExamensApi(client)
        .getByCarnet1(carnet!.id!, Pageable(page: 0, size: 50));
    return resp?.data?.content ?? [];
  } catch (_) {
    return [];
  }
});

final ordonnancesProvider = FutureProvider<List<Ordonnance>>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return [];
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final resp = await OrdonnancesApi(client)
        .getByCarnet(carnet!.id!, Pageable(page: 0, size: 50));
    return resp?.data?.content ?? [];
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
    _tabController = TabController(length: 4, vsync: this);
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
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            title: const Text('Mon Carnet Médical'),
            bottom: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.onSurfaceVariantLight,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelStyle:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              tabs: const [
                Tab(text: 'Consultations'),
                Tab(text: 'Allergies'),
                Tab(text: 'Examens'),
                Tab(text: 'Ordonnances'),
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
            _OrdonnancesList(ref: ref),
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
    final async = ref.watch(consultationsProvider);
    return async.when(
      data: (list) => list.isEmpty
          ? const _EmptyTab(
              label: 'Aucune consultation enregistrée',
              icon: Icons.medical_services_outlined)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _ConsultationCard(c: list[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _ErrorTab(message: e.toString()),
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  const _ConsultationCard({required this.c});
  final Consultation c;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final graviteValue = c.gravite?.value ?? '';
    final gColor = _graviteColor(graviteValue);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? AppColors.outlineVariantDark
              : AppColors.outlineVariantLight,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(6),
              blurRadius: 12,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.medical_services_outlined,
                color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(c.motif ?? 'Consultation',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
              Row(children: [
                if (c.medecin?.user?.nomComplet != null)
                  Text('Dr. ${c.medecin!.user!.nomComplet!}',
                      style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(width: 6),
                Text('• ${_fmtDate(c.dateConsultation)}',
                    style: Theme.of(context).textTheme.bodySmall),
              ]),
            ]),
          ),
          if (graviteValue.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: gColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(graviteValue,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: gColor)),
            ),
        ]),
        if (c.diagnostic != null) ...[
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 6),
          Text('🔍 ${c.diagnostic!}',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
        ],
        if (c.traitementRecommande != null) ...[
          const SizedBox(height: 6),
          Text('💊 ${c.traitementRecommande!}',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ]),
    );
  }

  Color _graviteColor(String g) {
    switch (g.toUpperCase()) {
      case 'URGENTE':
      case 'HAUTE':
        return AppColors.error;
      case 'MOYENNE':
        return AppColors.warning;
      default:
        return AppColors.success;
    }
  }

  String _fmtDate(DateTime? d) {
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}

// ─── Allergies ──────────────────────────────────────────────────────────────

class _AllergiesList extends StatelessWidget {
  const _AllergiesList({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(allergiesProvider);
    return async.when(
      data: (list) => list.isEmpty
          ? const _EmptyTab(
              label: 'Aucune allergie enregistrée',
              icon: Icons.warning_amber_outlined)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _AllergieCard(a: list[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) =>
          const _ErrorTab(message: 'Impossible de charger les allergies'),
    );
  }
}

class _AllergieCard extends StatelessWidget {
  const _AllergieCard({required this.a});
  final Allergie a;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gravite = a.gravite?.value ?? '';
    final color = _graviteColor(gravite);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(12)),
          child: Icon(Icons.warning_amber_rounded, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(a.nomAllergene ?? 'Allergène inconnu',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            if (a.typeAllergene != null)
              Text('Type: ${a.typeAllergene}',
                  style: Theme.of(context).textTheme.bodySmall),
            if (a.typeReaction != null)
              Text('Réaction: ${a.typeReaction?.value ?? ''}',
                  style: Theme.of(context).textTheme.bodySmall),
            if (a.traitementUrgence != null)
              Text('⚡ ${a.traitementUrgence}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.error),
                  maxLines: 2),
          ]),
        ),
        if (gravite.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(8)),
            child: Text(gravite,
                style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w600, color: color)),
          ),
      ]),
    );
  }

  Color _graviteColor(String g) {
    switch (g.toUpperCase()) {
      case 'MORTELLE':
      case 'SEVERE':
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
    final async = ref.watch(examensProvider);
    return async.when(
      data: (list) => list.isEmpty
          ? const _EmptyTab(
              label: 'Aucun examen enregistré',
              icon: Icons.biotech_outlined)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _ExamenCard(e: list[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) =>
          const _ErrorTab(message: 'Impossible de charger les examens'),
    );
  }
}

class _ExamenCard extends StatelessWidget {
  const _ExamenCard({required this.e});
  final Examen e;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isUrgent = e.urgent ?? false;
    final date = e.dateRealisation ?? e.datePrescription;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isUrgent
              ? AppColors.error.withAlpha(60)
              : isDark
                  ? AppColors.outlineVariantDark
                  : AppColors.outlineVariantLight,
        ),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.secondary.withAlpha(20),
              borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.biotech_outlined,
              color: AppColors.secondary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(e.typeExamen ?? 'Examen',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            if (e.categorieExamen != null)
              Text(e.categorieExamen!,
                  style: Theme.of(context).textTheme.bodySmall),
            if (date != null)
              Text(_fmtDate(date),
                  style: Theme.of(context).textTheme.bodySmall),
            if (e.etablissementRealisation != null)
              Text('🏥 ${e.etablissementRealisation}',
                  style: Theme.of(context).textTheme.bodySmall),
          ]),
        ),
        if (isUrgent)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: AppColors.error.withAlpha(20),
                borderRadius: BorderRadius.circular(8)),
            child: const Text('URGENT',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.error)),
          ),
      ]),
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

// ─── Ordonnances ─────────────────────────────────────────────────────────────

class _OrdonnancesList extends StatelessWidget {
  const _OrdonnancesList({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(ordonnancesProvider);
    return async.when(
      data: (list) => list.isEmpty
          ? const _EmptyTab(
              label: 'Aucune ordonnance enregistrée',
              icon: Icons.medication_outlined)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _OrdonnanceCard(o: list[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) =>
          const _ErrorTab(message: 'Impossible de charger les ordonnances'),
    );
  }
}

class _OrdonnanceCard extends StatelessWidget {
  const _OrdonnanceCard({required this.o});
  final Ordonnance o;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final status = o.status?.value ?? '';
    final statusColor = status == 'ACTIVE'
        ? AppColors.success
        : status == 'EXPIREE'
            ? AppColors.warning
            : AppColors.onSurfaceVariantLight;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? AppColors.outlineVariantDark
              : AppColors.outlineVariantLight,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.secondary.withAlpha(20),
                borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.medication_outlined,
                color: AppColors.secondary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(o.numeroOrdonnance ?? 'Ordonnance',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
              Text(
                  'Dr. ${o.medecin?.user?.nomComplet ?? ''} • ${_fmtDate(o.datePrescription)}',
                  style: Theme.of(context).textTheme.bodySmall),
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: statusColor.withAlpha(20),
                borderRadius: BorderRadius.circular(8)),
            child: Text(status,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor)),
          ),
        ]),
        if (o.instructions != null) ...[
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 6),
          Text('📋 ${o.instructions!}',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
        ],
        if (o.renouvelable == true) ...[
          const SizedBox(height: 6),
          Row(children: [
            const Icon(Icons.refresh, size: 14, color: AppColors.primary),
            const SizedBox(width: 4),
            Text('Renouvelable (${o.nombreRenouvellements ?? 0} fois)',
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500)),
          ]),
        ],
      ]),
    );
  }

  String _fmtDate(DateTime? d) {
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

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
          Icon(icon,
              size: 56,
              color: AppColors.onSurfaceVariantLight.withAlpha(100)),
          const SizedBox(height: 16),
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.onSurfaceVariantLight)),
        ],
      ),
    );
  }
}

class _ErrorTab extends StatelessWidget {
  const _ErrorTab({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_outlined,
                size: 48, color: AppColors.error),
            const SizedBox(height: 12),
            Text(message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.onSurfaceVariantLight),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

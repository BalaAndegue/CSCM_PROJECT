import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';

// ─── Providers ─────────────────────────────────────────────────────────────

// Profil du patient par son ID
final patientDossierProvider =
    FutureProvider.family<Patient?, String>((ref, patientId) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await PatientsApi(client).getPatientById(patientId);
    return response?.data;
  } catch (_) {
    return null;
  }
});

// Carnet du patient : obtenu depuis les approbations du médecin connecté
// L'approbation contient le carnet directement
final medecinPatientCarnetIdProvider =
    FutureProvider.family<String?, String>((ref, patientId) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    // Obtenir les accès du médecin : chaque ApprobationMedecin contient le carnet
    final response = await ApprobationsMdecinsApi(client).getMesAcces();
    final approbations = response?.data ?? [];
    final match = approbations.firstWhere(
      (a) => a.carnet?.patient?.id == patientId && (a.actif ?? false),
      orElse: () => approbations.firstWhere(
        (a) => a.carnet?.patient?.id == patientId,
        orElse: () => ApprobationMedecin(),
      ),
    );
    return match.carnet?.id;
  } catch (_) {
    return null;
  }
});

// Consultations du carnet du patient
final dossierConsultationsProvider =
    FutureProvider.family<List<Consultation>, String>((ref, carnetId) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await ConsultationsApi(client)
        .getByCarnet2(carnetId, Pageable(page: 0, size: 50));
    return response?.data?.content ?? [];
  } catch (_) {
    return [];
  }
});

// Allergies du carnet du patient
final dossierAllergiesProvider =
    FutureProvider.family<List<Allergie>, String>((ref, carnetId) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await AllergiesApi(client).getByCarnet3(carnetId);
    return response?.data ?? [];
  } catch (_) {
    return [];
  }
});

// Examens du carnet du patient
final dossierExamensProvider =
    FutureProvider.family<List<Examen>, String>((ref, carnetId) async {
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response = await ExamensApi(client)
        .getByCarnet1(carnetId, Pageable(page: 0, size: 50));
    return response?.data?.content ?? [];
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
    final carnetIdAsync =
        ref.watch(medecinPatientCarnetIdProvider(widget.patientId));

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
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
                labelStyle: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600),
                unselectedLabelStyle: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w400),
                tabs: const [
                  Tab(text: 'Consultations'),
                  Tab(text: 'Allergies'),
                  Tab(text: 'Examens'),
                ],
              ),
            ),
          ),
        ],
        body: carnetIdAsync.when(
          data: (carnetId) {
            if (carnetId == null) {
              return const _NoAccessTab();
            }
            return TabBarView(
              controller: _tabController,
              children: [
                _DossierConsultationsTab(carnetId: carnetId),
                _DossierAllergiesTab(carnetId: carnetId),
                _DossierExamensTab(carnetId: carnetId),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const _NoAccessTab(),
        ),
      ),
      floatingActionButton: carnetIdAsync.maybeWhen(
        data: (carnetId) => carnetId != null
            ? FloatingActionButton.extended(
                onPressed: () => _showAddBottomSheet(context, carnetId),
                backgroundColor: AppColors.medecinColor,
                foregroundColor: Colors.white,
                icon: const Icon(Icons.add),
                label: const Text('Ajouter',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              )
            : null,
        orElse: () => null,
      ),
    );
  }

  void _showAddBottomSheet(BuildContext context, String carnetId) {
    final tabIndex = _tabController.index;
    if (tabIndex == 0) {
      _showAddConsultation(context, carnetId);
    } else if (tabIndex == 1) {
      _showAddAllergie(context, carnetId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Pour les examens, utilisez la fiche de consultation.')),
      );
    }
  }

  // ─── Formulaire Consultation ────────────────────────────────────────────────
  void _showAddConsultation(BuildContext context, String carnetId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) =>
          _AddConsultationSheet(carnetId: carnetId, widgetRef: ref),
    );
  }

  // ─── Formulaire Allergie ────────────────────────────────────────────────────
  void _showAddAllergie(BuildContext context, String carnetId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AddAllergieSheet(carnetId: carnetId, widgetRef: ref),
    );
  }
}

// ─── Consultation Tab ─────────────────────────────────────────────────────────
class _DossierConsultationsTab extends ConsumerWidget {
  const _DossierConsultationsTab({required this.carnetId});
  final String carnetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dossierConsultationsProvider(carnetId));
    return async.when(
      data: (list) => list.isEmpty
          ? const _EmptyDossier(
              label: 'Aucune consultation',
              icon: Icons.medical_services_outlined)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _DossierConsultationCard(c: list[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const _EmptyDossier(
          label: 'Erreur de chargement', icon: Icons.error_outline),
    );
  }
}

class _DossierConsultationCard extends StatelessWidget {
  const _DossierConsultationCard({required this.c});
  final Consultation c;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.medecinColor.withAlpha(20),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.medical_services_outlined,
                color: AppColors.medecinColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(c.motif ?? 'Consultation',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
              Text(_fmtDate(c.dateConsultation),
                  style: Theme.of(context).textTheme.bodySmall),
            ]),
          ),
          if (c.gravite != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _graviteColor(c.gravite!.value).withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(c.gravite!.value,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _graviteColor(c.gravite!.value))),
            ),
        ]),
        if (c.diagnostic != null) ...[
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 6),
          Text('🔍 ${c.diagnostic!}',
              style: Theme.of(context).textTheme.bodySmall, maxLines: 4),
        ],
        if (c.traitementRecommande != null) ...[
          const SizedBox(height: 4),
          Text('💊 ${c.traitementRecommande!}',
              style: Theme.of(context).textTheme.bodySmall, maxLines: 3),
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

// ─── Allergies Tab ─────────────────────────────────────────────────────────────
class _DossierAllergiesTab extends ConsumerWidget {
  const _DossierAllergiesTab({required this.carnetId});
  final String carnetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dossierAllergiesProvider(carnetId));
    return async.when(
      data: (list) => list.isEmpty
          ? const _EmptyDossier(
              label: 'Aucune allergie enregistrée',
              icon: Icons.warning_amber_outlined)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _AllergieCard(a: list[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const _EmptyDossier(
          label: 'Erreur de chargement', icon: Icons.error_outline),
    );
  }
}

class _AllergieCard extends StatelessWidget {
  const _AllergieCard({required this.a});
  final Allergie a;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = a.gravite?.value == 'MORTELLE' || a.gravite?.value == 'SEVERE'
        ? AppColors.error
        : a.gravite?.value == 'MODEREE'
            ? AppColors.warning
            : AppColors.success;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: color.withAlpha(20), borderRadius: BorderRadius.circular(10)),
          child: Icon(Icons.warning_amber_rounded, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(a.nomAllergene ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            if (a.typeAllergene != null)
              Text(a.typeAllergene!,
                  style: Theme.of(context).textTheme.bodySmall),
          ]),
        ),
        if (a.gravite != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: color.withAlpha(20), borderRadius: BorderRadius.circular(8)),
            child: Text(a.gravite!.value,
                style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w600, color: color)),
          ),
      ]),
    );
  }
}

// ─── Examens Tab ──────────────────────────────────────────────────────────────
class _DossierExamensTab extends ConsumerWidget {
  const _DossierExamensTab({required this.carnetId});
  final String carnetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dossierExamensProvider(carnetId));
    return async.when(
      data: (list) => list.isEmpty
          ? const _EmptyDossier(
              label: 'Aucun examen prescrit', icon: Icons.biotech_outlined)
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _ExamenCard(e: list[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const _EmptyDossier(
          label: 'Erreur de chargement', icon: Icons.error_outline),
    );
  }
}

class _ExamenCard extends StatelessWidget {
  const _ExamenCard({required this.e});
  final Examen e;

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
              : AppColors.outlineVariantLight,
        ),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.secondary.withAlpha(20),
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.biotech_outlined,
              color: AppColors.secondary, size: 18),
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
          ]),
        ),
        if (e.urgent == true)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
}

// ─── Formulaire Ajouter Consultation ─────────────────────────────────────────
class _AddConsultationSheet extends ConsumerStatefulWidget {
  const _AddConsultationSheet(
      {required this.carnetId, required this.widgetRef});
  final String carnetId;
  final WidgetRef widgetRef;

  @override
  ConsumerState<_AddConsultationSheet> createState() =>
      _AddConsultationSheetState();
}

class _AddConsultationSheetState
    extends ConsumerState<_AddConsultationSheet> {
  final _motifCtrl = TextEditingController();
  final _diagnosticCtrl = TextEditingController();
  final _traitementCtrl = TextEditingController();
  String _gravite = 'FAIBLE';
  bool _loading = false;

  @override
  void dispose() {
    _motifCtrl.dispose();
    _diagnosticCtrl.dispose();
    _traitementCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                    color: AppColors.outlineLight,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 20),
            Text('Nouvelle consultation',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            TextField(
              controller: _motifCtrl,
              decoration: const InputDecoration(
                  labelText: 'Motif *',
                  hintText: 'Ex: Fièvre, toux, douleur...'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _diagnosticCtrl,
              decoration: const InputDecoration(
                  labelText: 'Diagnostic',
                  hintText: 'Conclusion diagnostique'),
              maxLines: 3,
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _traitementCtrl,
              decoration: const InputDecoration(
                  labelText: 'Traitement recommandé'),
              maxLines: 2,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _gravite,
              decoration: const InputDecoration(labelText: 'Gravité'),
              items: const [
                DropdownMenuItem(value: 'FAIBLE', child: Text('Faible')),
                DropdownMenuItem(value: 'MOYENNE', child: Text('Moyenne')),
                DropdownMenuItem(value: 'HAUTE', child: Text('Haute')),
                DropdownMenuItem(value: 'URGENTE', child: Text('Urgente')),
              ],
              onChanged: (v) => setState(() => _gravite = v ?? 'FAIBLE'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _loading ? null : _submit,
              style: FilledButton.styleFrom(
                  backgroundColor: AppColors.medecinColor),
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Text('Enregistrer la consultation'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_motifCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le motif est obligatoire')),
      );
      return;
    }

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    setState(() => _loading = true);
    try {
      final client =
          await widget.widgetRef.read(authenticatedApiClientProvider.future);
      await ConsultationsApi(client).create3(
        widget.carnetId,
        Consultation(
          motif: _motifCtrl.text.trim(),
          diagnostic: _diagnosticCtrl.text.isNotEmpty
              ? _diagnosticCtrl.text.trim()
              : null,
          traitementRecommande: _traitementCtrl.text.isNotEmpty
              ? _traitementCtrl.text.trim()
              : null,
          dateConsultation: DateTime.now(),
          gravite: ConsultationGraviteEnum.fromJson(_gravite),
        ),
      );
      widget.widgetRef
          .invalidate(dossierConsultationsProvider(widget.carnetId));
      if (mounted) navigator.pop();
      messenger.showSnackBar(
        const SnackBar(content: Text('✅ Consultation ajoutée')),
      );
    } catch (e) {
      setState(() => _loading = false);
      messenger.showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }
}

// ─── Formulaire Ajouter Allergie ─────────────────────────────────────────────
class _AddAllergieSheet extends ConsumerStatefulWidget {
  const _AddAllergieSheet({required this.carnetId, required this.widgetRef});
  final String carnetId;
  final WidgetRef widgetRef;

  @override
  ConsumerState<_AddAllergieSheet> createState() => _AddAllergieSheetState();
}

class _AddAllergieSheetState extends ConsumerState<_AddAllergieSheet> {
  final _nomCtrl = TextEditingController();
  final _typeCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  String _gravite = 'LEGERE';
  bool _loading = false;

  @override
  void dispose() {
    _nomCtrl.dispose();
    _typeCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                    color: AppColors.outlineLight,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 20),
            Text('Nouvelle allergie',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            TextField(
              controller: _nomCtrl,
              decoration: const InputDecoration(
                  labelText: 'Allergène *',
                  hintText: 'Ex: Pénicilline, Arachides...'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _typeCtrl,
              decoration: const InputDecoration(
                  labelText: 'Type d\'allergène',
                  hintText: 'Ex: Médicament, Alimentaire...'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _descriptionCtrl,
              decoration: const InputDecoration(
                  labelText: 'Description / Traitement d\'urgence'),
              maxLines: 2,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _gravite,
              decoration: const InputDecoration(labelText: 'Gravité'),
              items: const [
                DropdownMenuItem(value: 'LEGERE', child: Text('Légère')),
                DropdownMenuItem(value: 'MODEREE', child: Text('Modérée')),
                DropdownMenuItem(value: 'SEVERE', child: Text('Sévère')),
                DropdownMenuItem(value: 'MORTELLE', child: Text('Mortelle')),
              ],
              onChanged: (v) => setState(() => _gravite = v ?? 'LEGERE'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _loading ? null : _submit,
              style: FilledButton.styleFrom(
                  backgroundColor: AppColors.medecinColor),
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Text('Enregistrer l\'allergie'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_nomCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le nom de l\'allergène est obligatoire')),
      );
      return;
    }

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    setState(() => _loading = true);
    try {
      final client =
          await widget.widgetRef.read(authenticatedApiClientProvider.future);
      await AllergiesApi(client).create4(
        widget.carnetId,
        Allergie(
          nomAllergene: _nomCtrl.text.trim(),
          typeAllergene: _typeCtrl.text.isNotEmpty ? _typeCtrl.text.trim() : null,
          description: _descriptionCtrl.text.isNotEmpty
              ? _descriptionCtrl.text.trim()
              : null,
          gravite: AllergieGraviteEnum.fromJson(_gravite),
          active: true,
        ),
      );
      widget.widgetRef.invalidate(dossierAllergiesProvider(widget.carnetId));
      if (mounted) navigator.pop();
      messenger.showSnackBar(
        const SnackBar(content: Text('✅ Allergie enregistrée')),
      );
    } catch (e) {
      setState(() => _loading = false);
      messenger.showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
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
              colors: [
                Color(0xFF007268),
                Color(0xFF00A896),
                Color(0xFF33C4B5)
              ],
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
                              '🩸 ${patient!.groupeSanguin!.value}',
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
                              border:
                                  Border.all(color: Colors.white.withAlpha(50)),
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

// ─── Helpers ─────────────────────────────────────────────────────────────────

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  const _TabBarDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height + 1;

  @override
  double get maxExtent => tabBar.preferredSize.height + 1;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(color: Theme.of(context).colorScheme.surface, child: tabBar);

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) => false;
}

class _EmptyDossier extends StatelessWidget {
  const _EmptyDossier({required this.label, required this.icon});
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

class _NoAccessTab extends StatelessWidget {
  const _NoAccessTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_outline, size: 56, color: AppColors.warning),
          const SizedBox(height: 16),
          Text('Accès non autorisé',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            'Le patient n\'a pas encore accordé l\'accès\nou l\'accès a été révoqué.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

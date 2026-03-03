import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../dashboard/presentation/providers/patient_providers.dart';

// ─── Provider approbations du patient connecté ────────────────────────────────
final approbationsProvider =
    FutureProvider<List<ApprobationMedecin>>((ref) async {
  final carnet = await ref.watch(patientCarnetProvider.future);
  if (carnet?.id == null) return [];
  final client = await ref.watch(authenticatedApiClientProvider.future);
  try {
    final response =
        await ApprobationsMdecinsApi(client).getMedecinsApprouves(carnet!.id!);
    return response?.data ?? [];
  } catch (_) {
    return [];
  }
});

// ─── Page principale ─────────────────────────────────────────────────────────
class AccessManagementPage extends ConsumerWidget {
  const AccessManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final approbationsAsync = ref.watch(approbationsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            title: Text('Accès & Consentements'),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _AccessInfoCard(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Médecins ayant accès',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    FilledButton.icon(
                      onPressed: () => _showAddDialog(context, ref),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Ajouter'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        textStyle: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                approbationsAsync.when(
                  data: (list) => list.isEmpty
                      ? const _EmptyAccess()
                      : Column(
                          children: list
                              .map((a) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child:
                                        _ApprobationCard(approbation: a, ref: ref),
                                  ))
                              .toList(),
                        ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, __) =>
                      const Text('Erreur de chargement'),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AddAccessBottomSheet(widgetRef: ref),
    );
  }
}

// ─── Info Card ────────────────────────────────────────────────────────────────
class _AccessInfoCard extends StatelessWidget {
  const _AccessInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withAlpha(40)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded,
              color: AppColors.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Gérez qui peut consulter votre dossier médical. '
              'Vous pouvez accorder un accès permanent ou le révoquer à tout moment.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.primaryDark),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Approbation Card ─────────────────────────────────────────────────────────
class _ApprobationCard extends StatelessWidget {
  const _ApprobationCard({required this.approbation, required this.ref});
  final ApprobationMedecin approbation;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isActive = approbation.actif ?? false;
    final isTemporary = approbation.dateExpiration != null;
    final statusColor = isActive ? AppColors.success : AppColors.warning;

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
              blurRadius: 10,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    approbation.medecin?.user?.nomComplet?.isNotEmpty == true
                        ? approbation.medecin!.user!.nomComplet![0]
                            .toUpperCase()
                        : 'M',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${approbation.medecin?.user?.nomComplet ?? 'Médecin'}',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      approbation.medecin?.specialite ?? 'Spécialiste',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isActive ? 'Actif' : 'En attente',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (isTemporary && approbation.dateExpiration != null) ...[
                const Icon(Icons.timer_outlined,
                    size: 14, color: AppColors.warning),
                const SizedBox(width: 4),
                Text(
                  'Expire le ${_fmtDate(approbation.dateExpiration!)}',
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.warning,
                      fontWeight: FontWeight.w500),
                ),
              ] else ...[
                const Icon(Icons.lock_open_outlined,
                    size: 14, color: AppColors.success),
                const SizedBox(width: 4),
                const Text(
                  'Accès permanent',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.success,
                      fontWeight: FontWeight.w500),
                ),
              ],
              const Spacer(),
              TextButton.icon(
                onPressed: () => _revokeDialog(context, ref),
                icon: const Icon(Icons.block_outlined, size: 16),
                label: const Text('Révoquer'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.error,
                  textStyle: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  Future<void> _revokeDialog(BuildContext context, WidgetRef ref) async {
    final motifController = TextEditingController();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Révoquer l\'accès'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'Êtes-vous sûr de vouloir révoquer l\'accès de ce médecin ?'),
            const SizedBox(height: 12),
            TextField(
              controller: motifController,
              decoration: const InputDecoration(
                labelText: 'Motif (optionnel)',
                hintText: 'Raison de la révocation...',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Annuler')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Révoquer'),
          ),
        ],
      ),
    );

    if (confirm == true && approbation.id != null) {
      try {
        final client =
            await ref.read(authenticatedApiClientProvider.future);
        await ApprobationsMdecinsApi(client).revoquer(
          approbation.id!,
          motifRequest: MotifRequest(motif: motifController.text.isNotEmpty
              ? motifController.text
              : 'Révocation par le patient'),
        );
        ref.invalidate(approbationsProvider);
      } catch (_) {}
    }
    motifController.dispose();
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────
class _EmptyAccess extends StatelessWidget {
  const _EmptyAccess();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(Icons.shield_outlined,
              size: 56,
              color: AppColors.onSurfaceVariantLight.withAlpha(100)),
          const SizedBox(height: 16),
          Text(
            'Aucun médecin n\'a accès à votre dossier',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariantLight,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Appuyez sur « Ajouter » pour accorder un accès à un médecin',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Ajout d'un accès ────────────────────────────────────────────────────────
class _AddAccessBottomSheet extends ConsumerStatefulWidget {
  const _AddAccessBottomSheet({required this.widgetRef});
  final WidgetRef widgetRef;

  @override
  ConsumerState<_AddAccessBottomSheet> createState() =>
      _AddAccessBottomSheetState();
}

class _AddAccessBottomSheetState extends ConsumerState<_AddAccessBottomSheet> {
  final _medecinIdCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _medecinIdCtrl.dispose();
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
          const SizedBox(height: 24),
          Text('Accorder un accès médecin',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            'Entrez l\'UUID du médecin (fourni par votre médecin)',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _medecinIdCtrl,
            decoration: const InputDecoration(
              labelText: 'ID du médecin',
              hintText: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
              prefixIcon: Icon(Icons.person_search_outlined),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!,
                style: const TextStyle(color: AppColors.error, fontSize: 13)),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Text('Accorder l\'accès'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final medecinId = _medecinIdCtrl.text.trim();
    if (medecinId.isEmpty) {
      setState(() => _error = 'Veuillez entrer l\'ID du médecin');
      return;
    }

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final carnet =
          await ref.read(patientCarnetProvider.future);
      if (carnet?.id == null) {
        setState(() {
          _loading = false;
          _error = 'Carnet médical introuvable';
        });
        return;
      }
      final client =
          await ref.read(authenticatedApiClientProvider.future);
      await ApprobationsMdecinsApi(client).approuver1(
        carnet!.id!,
        medecinId,
        signatureRequest: SignatureRequest(signature: 'CONSENT_GRANTED'),
      );
      ref.invalidate(approbationsProvider);
      if (mounted) navigator.pop();
    } on ApiException catch (e) {
      setState(() {
        _loading = false;
        _error = e.code == 409
            ? 'Accès déjà accordé ou médecin invalide'
            : 'Erreur: ${e.message ?? e.code}';
      });
    } catch (_) {
      setState(() {
        _loading = false;
        _error = 'Erreur réseau. Vérifiez votre connexion.';
      });
    }
    if (mounted) {
      messenger.showSnackBar(
        const SnackBar(content: Text('✅ Accès accordé avec succès')),
      );
    }
  }
}

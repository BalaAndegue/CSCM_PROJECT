import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';

// Providers
final approbationsProvider =
    FutureProvider<List<ApprobationMedecin>>((ref) async {
  final clientAsync = await ref.watch(authenticatedApiClientProvider.future);
  final api = ApprobationsMdecinsApi(clientAsync);
  try {
    final response = await api.getMesAcces();
    return response?.data ?? [];
  } catch (_) {
    return [];
  }
});

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
                // Header info card
                const _AccessInfoCard(),
                const SizedBox(height: 24),

                // Title row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Médecins ayant accès',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    FilledButton.icon(
                      onPressed: () => _showAddAccessDialog(context, ref),
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

                // Approbations list
                approbationsAsync.when(
                  data: (list) => list.isEmpty
                      ? const _EmptyAccess()
                      : Column(
                          children: list
                              .map((a) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: _ApprobationCard(
                                        approbation: a, ref: ref),
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

  void _showAddAccessDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => _AddAccessBottomSheet(ref: ref),
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
          const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Gérez qui peut consulter votre dossier médical. Vous pouvez accorder un accès permanent ou limité à 24h.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primaryDark,
                  ),
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
    // Temporary if it has an expiration date in the future
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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Doctor avatar
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
                        ? approbation.medecin!.user!.nomComplet![0].toUpperCase()
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
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      approbation.medecin?.specialite ?? 'Spécialiste',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              // Status badge
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
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (isTemporary &&
                  approbation.dateExpiration != null) ...[
                const Icon(Icons.timer_outlined,
                    size: 14, color: AppColors.warning),
                const SizedBox(width: 4),
                Text(
                  'Expire le ${_fmtDate(approbation.dateExpiration!)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.warning,
                    fontWeight: FontWeight.w500,
                  ),
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const Spacer(),
              TextButton.icon(
                onPressed: () => _revokeAccess(context, ref),
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

  Future<void> _revokeAccess(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Révoquer l\'accès'),
        content: const Text(
            'Êtes-vous sûr de vouloir révoquer l\'accès de ce médecin à votre dossier ?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Annuler')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
                FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Révoquer'),
          ),
        ],
      ),
    );

    if (confirm == true && approbation.id != null) {
      try {
        final clientAsync =
            await ref.read(authenticatedApiClientProvider.future);
        final api = ApprobationsMdecinsApi(clientAsync);
        await api.revoquer(approbation.id!);
        ref.invalidate(approbationsProvider);
      } catch (_) {}
    }
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
            'Ajoutez un médecin pour lui donner accès à votre carnet médical',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Add Access Bottom Sheet ─────────────────────────────────────────────────

class _AddAccessBottomSheet extends StatefulWidget {
  const _AddAccessBottomSheet({required this.ref});
  final WidgetRef ref;

  @override
  State<_AddAccessBottomSheet> createState() => _AddAccessBottomSheetState();
}

class _AddAccessBottomSheetState extends State<_AddAccessBottomSheet> {
  final _medecinIdController = TextEditingController();
  final _carnetIdController = TextEditingController();
  String _accessType = 'PERMANENT';

  @override
  void dispose() {
    _medecinIdController.dispose();
    _carnetIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Ajouter un accès médecin',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Entrez l\'identifiant du médecin et de votre carnet pour accorder l\'accès',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),

          TextField(
            controller: _carnetIdController,
            decoration: const InputDecoration(
              labelText: 'ID du carnet médical',
              hintText: 'ex: CM-001234',
              prefixIcon: Icon(Icons.credit_card_outlined),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _medecinIdController,
            decoration: const InputDecoration(
              labelText: 'ID du médecin',
              hintText: 'ex: DR-001234',
              prefixIcon: Icon(Icons.person_search_outlined),
            ),
          ),
          const SizedBox(height: 16),

          // Access type
          Row(
            children: [
              Expanded(
                child: _AccessTypeChip(
                  label: 'Permanent',
                  icon: Icons.lock_open_outlined,
                  isSelected: _accessType == 'PERMANENT',
                  color: AppColors.success,
                  onTap: () => setState(() => _accessType = 'PERMANENT'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _AccessTypeChip(
                  label: '24 heures',
                  icon: Icons.timer_outlined,
                  isSelected: _accessType == 'TEMPORAIRE',
                  color: AppColors.warning,
                  onTap: () => setState(() => _accessType = 'TEMPORAIRE'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          FilledButton(
            onPressed: () => _submitAccess(context),
            child: const Text('Accorder l\'accès'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitAccess(BuildContext context) async {
    if (_medecinIdController.text.isEmpty ||
        _carnetIdController.text.isEmpty) return;
    try {
      final clientAsync =
          await widget.ref.read(authenticatedApiClientProvider.future);
      final api = ApprobationsMdecinsApi(clientAsync);
      await api.approuver1(
          _carnetIdController.text, _medecinIdController.text);
      widget.ref.invalidate(approbationsProvider);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }
}

class _AccessTypeChip extends StatelessWidget {
  const _AccessTypeChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? color : AppColors.outlineLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: isSelected
                    ? color
                    : AppColors.onSurfaceVariantLight,
                size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? color : AppColors.onSurfaceVariantLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../../core/providers/api_client_provider.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/app_router.dart';
import '../providers/patient_providers.dart';
import '../../../../shared/presentation/pages/qr_scanner_page.dart';

class PatientQuickActions extends ConsumerWidget {
  const PatientQuickActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            label: 'Scanner QR',
            icon: Icons.qr_code_scanner_rounded,
            gradient: AppColors.primaryGradient,
            onPressed: () => _openQrScanner(context, ref),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionButton(
            label: 'Mon QR',
            icon: Icons.qr_code_rounded,
            gradient: const LinearGradient(
              colors: [Color(0xFF007268), Color(0xFF00A896)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onPressed: () => _showMyQr(context, ref),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionButton(
            label: 'Accès',
            icon: Icons.admin_panel_settings_rounded,
            gradient: const LinearGradient(
              colors: [Color(0xFF7C6FF7), Color(0xFFAB99FA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onPressed: () => context.go(AppRoutes.patientAccess),
          ),
        ),
      ],
    );
  }

  /// Scanne le QR badge du médecin puis appelle approuver1().
  Future<void> _openQrScanner(BuildContext context, WidgetRef ref) async {
    final carnet = await ref.read(patientCarnetProvider.future);
    if (carnet?.id == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Carnet non disponible.')),
        );
      }
      return;
    }

    if (!context.mounted) return;
    final ok = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => QrScannerPage(
          title: 'Scanner badge médecin',
          subtitle: 'Pointez le QR code du médecin pour accorder l\'accès',
          accentColor: AppColors.patientColor,
          onResult: (raw) async {
            String medecinId;
            try {
              final j = jsonDecode(raw) as Map<String, dynamic>;
              medecinId = (j['medecinId'] ?? j['id'] ?? '').toString();
            } catch (_) {
              medecinId = raw.trim();
            }
            if (medecinId.isEmpty) return false;
            final client =
                await ref.read(authenticatedApiClientProvider.future);
            await ApprobationsMdecinsApi(client).approuver1(
              carnet!.id!,
              medecinId,
              signatureRequest: SignatureRequest(signature: 'CONSENT_GRANTED'),
            );
            return true;
          },
        ),
      ),
    );

    if ((ok ?? false) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('✅ Accès accordé au médecin'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  /// Affiche le QR code du carnet (pour que le médecin scanne).
  Future<void> _showMyQr(BuildContext context, WidgetRef ref) async {
    final carnet = await ref.read(patientCarnetProvider.future);
    if (carnet == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Carnet non disponible.')));
      }
      return;
    }
    if (!context.mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PatientQrSheet(carnet: carnet),
    );
  }
}

// ─── Feuille QR Code patient ──────────────────────────────────────────────────
class PatientQrSheet extends StatelessWidget {
  const PatientQrSheet({super.key, required this.carnet});
  final CarnetMedical carnet;

  @override
  Widget build(BuildContext context) {
    final payload = jsonEncode({
      'type': 'patient',
      'carnetId': carnet.id ?? '',
      'patientId': carnet.patient?.id ?? '',
    });

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).padding.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
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
          const SizedBox(height: 20),

          // Header
          Row(children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(15),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.qr_code_2_rounded,
                  color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Mon QR Médical',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
              Text('Montrez ce code au médecin',
                  style: Theme.of(context).textTheme.bodySmall),
            ]),
          ]),
          const SizedBox(height: 24),

          // QR Code
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.primary.withAlpha(50), width: 1.5),
              boxShadow: [
                BoxShadow(
                    color: AppColors.primary.withAlpha(25),
                    blurRadius: 24,
                    offset: const Offset(0, 8)),
              ],
            ),
            child: QrImageView(
              data: payload,
              version: QrVersions.auto,
              size: 220,
              backgroundColor: Colors.white,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Color(0xFF1E6FD9),
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: Color(0xFF0D4DA1),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Info carnet
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withAlpha(25)),
            ),
            child: Row(children: [
              const Icon(Icons.credit_card_rounded,
                  color: AppColors.primary, size: 18),
              const SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('N° ${carnet.patient?.numeroCarnet ?? '—'}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14)),
                Text(carnet.patient?.user?.nomComplet ?? '',
                    style: const TextStyle(
                        color: AppColors.onSurfaceVariantLight, fontSize: 12)),
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}

// ─── Quick Action Button ──────────────────────────────────────────────────────
class _QuickActionButton extends StatefulWidget {
  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.gradient,
    required this.onPressed,
  });
  final String label;
  final IconData icon;
  final LinearGradient gradient;
  final VoidCallback onPressed;

  @override
  State<_QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<_QuickActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.93,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _anim.reverse(),
      onTapUp: (_) {
        _anim.forward();
        widget.onPressed();
      },
      onTapCancel: () => _anim.forward(),
      child: ScaleTransition(
        scale: _anim,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: widget.gradient.colors.first.withAlpha(65),
                  blurRadius: 18,
                  offset: const Offset(0, 5)),
            ],
          ),
          child: Column(
            children: [
              Icon(widget.icon, color: Colors.white, size: 26),
              const SizedBox(height: 7),
              Text(
                widget.label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

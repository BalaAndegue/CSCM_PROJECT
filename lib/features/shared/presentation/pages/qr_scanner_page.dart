import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/theme/app_colors.dart';

/// Page de scan QR générique.
/// [onResult] reçoit le JSON décodé ou le texte brut scanné.
/// [title] et [subtitle] personnalisent l'UI.
class QrScannerPage extends StatefulWidget {
  const QrScannerPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.onResult,
  });

  final String title;
  final String subtitle;
  final Color accentColor;
  final Future<bool> Function(String rawValue) onResult;

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController _ctrl = MobileScannerController();
  bool _processing = false;
  String? _feedback;
  bool _success = false;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Camera ──────────────────────────────────────────────────────
          MobileScanner(
            controller: _ctrl,
            onDetect: _onDetect,
          ),

          // ── Overlay ─────────────────────────────────────────────────────
          _ScannerOverlay(accentColor: widget.accentColor),

          // ── Top bar ─────────────────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    _TopButton(
                      icon: Icons.close_rounded,
                      onTap: () => context.pop(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            widget.subtitle,
                            style: TextStyle(
                              color: Colors.white.withAlpha(180),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _TopButton(
                      icon: Icons.flash_on_rounded,
                      onTap: () => _ctrl.toggleTorch(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Processing / feedback ────────────────────────────────────────
          if (_processing)
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

          // ── Feedback banner ──────────────────────────────────────────────
          if (_feedback != null)
            Positioned(
              bottom: 48,
              left: 24,
              right: 24,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: _success
                      ? AppColors.success.withAlpha(230)
                      : AppColors.error.withAlpha(230),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Icon(
                      _success ? Icons.check_circle_rounded : Icons.error_rounded,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _feedback!,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_processing) return;
    final barcode = capture.barcodes.firstOrNull;
    final raw = barcode?.rawValue;
    if (raw == null) return;

    setState(() => _processing = true);
    await _ctrl.stop();

    try {
      final ok = await widget.onResult(raw);
      if (!mounted) return;
      setState(() {
        _processing = false;
        _success = ok;
        _feedback = ok ? 'Succès !' : 'Code QR invalide ou accès refusé.';
      });
      if (ok) {
        await Future.delayed(const Duration(milliseconds: 900));
        if (mounted) context.pop(true);
      } else {
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          setState(() => _feedback = null);
          await _ctrl.start();
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _processing = false;
        _success = false;
        _feedback = 'Erreur : $e';
      });
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _feedback = null);
        await _ctrl.start();
      }
    }
  }
}

// ─── Overlay avec cible de scan ───────────────────────────────────────────────
class _ScannerOverlay extends StatelessWidget {
  const _ScannerOverlay({required this.accentColor});
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const boxSize = 260.0;
    const cornerSize = 24.0;
    const strokeWidth = 4.0;

    return CustomPaint(
      size: Size(size.width, size.height),
      painter: _OverlayPainter(
        boxSize: boxSize,
        accentColor: accentColor,
        cornerSize: cornerSize,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _OverlayPainter extends CustomPainter {
  const _OverlayPainter({
    required this.boxSize,
    required this.accentColor,
    required this.cornerSize,
    required this.strokeWidth,
  });
  final double boxSize;
  final Color accentColor;
  final double cornerSize;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final left = cx - boxSize / 2;
    final top = cy - boxSize / 2;
    final rect = Rect.fromLTWH(left, top, boxSize, boxSize);

    // Dim overlay
    final outerPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final innerPath = Path()..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(16)));
    final combined = Path.combine(PathOperation.difference, outerPath, innerPath);
    canvas.drawPath(combined, Paint()..color = Colors.black.withAlpha(150));

    // Corner brackets
    final paint = Paint()
      ..color = accentColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // top-left
    canvas.drawLine(Offset(left, top + cornerSize), Offset(left, top), paint);
    canvas.drawLine(Offset(left, top), Offset(left + cornerSize, top), paint);
    // top-right
    canvas.drawLine(Offset(left + boxSize - cornerSize, top), Offset(left + boxSize, top), paint);
    canvas.drawLine(Offset(left + boxSize, top), Offset(left + boxSize, top + cornerSize), paint);
    // bottom-left
    canvas.drawLine(Offset(left, top + boxSize - cornerSize), Offset(left, top + boxSize), paint);
    canvas.drawLine(Offset(left, top + boxSize), Offset(left + cornerSize, top + boxSize), paint);
    // bottom-right
    canvas.drawLine(Offset(left + boxSize - cornerSize, top + boxSize), Offset(left + boxSize, top + boxSize), paint);
    canvas.drawLine(Offset(left + boxSize, top + boxSize - cornerSize), Offset(left + boxSize, top + boxSize), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Bouton rond dans le top bar ─────────────────────────────────────────────
class _TopButton extends StatelessWidget {
  const _TopButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

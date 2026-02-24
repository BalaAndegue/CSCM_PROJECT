import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../providers/auth_provider.dart';
import '../widgets/login_form.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late AnimationController _contentController;
  late Animation<double> _bgFade;
  late Animation<Offset> _slideAnim;
  late Animation<double> _contentFade;

  @override
  void initState() {
    super.initState();

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _bgFade = CurvedAnimation(parent: _bgController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeOutCubic,
    ));
    _contentFade = CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeOut,
    );

    _bgController.forward().then((_) => _contentController.forward());
  }

  @override
  void dispose() {
    _bgController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    // Listen to auth state changes - redirect is handled by router
    ref.listen<AuthState>(authProvider, (_, next) {
      if (next.isAuthenticated) {
        context.go(_dashboardForRole(next.role));
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // === Background gradient ===
          FadeTransition(
            opacity: _bgFade,
            child: Container(
              height: size.height * 0.42,
              decoration: BoxDecoration(
                gradient: isDark
                    ? AppColors.darkHeroGradient
                    : AppColors.heroGradient,
              ),
            ),
          ),

          // === Background decorative circles ===
          Positioned(
            top: -60,
            right: -60,
            child: FadeTransition(
              opacity: _bgFade,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(18),
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: -80,
            child: FadeTransition(
              opacity: _bgFade,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(10),
                ),
              ),
            ),
          ),

          // === Content ===
          SafeArea(
            child: Column(
              children: [
                // Top logo area
                SizedBox(
                  height: size.height * 0.30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: FadeTransition(
                      opacity: _bgFade,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(30),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.white.withAlpha(80),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.health_and_safety_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'CSCM',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Bienvenue\nsur votre carnet',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.2,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Carnet de Santé Connecté et Mobile',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(180),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Scrollable form card
                Expanded(
                  child: SlideTransition(
                    position: _slideAnim,
                    child: FadeTransition(
                      opacity: _contentFade,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.surfaceDark
                              : AppColors.surfaceLight,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(30),
                              blurRadius: 40,
                              offset: const Offset(0, -8),
                            ),
                          ],
                        ),
                        child: const SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(28, 32, 28, 24),
                          child: LoginForm(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _dashboardForRole(AuthRole role) {
    switch (role) {
      case AuthRole.patient:
        return AppRoutes.patientDashboard;
      case AuthRole.medecin:
        return AppRoutes.medecinDashboard;
      default:
        return AppRoutes.login;
    }
  }
}

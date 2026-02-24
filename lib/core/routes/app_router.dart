import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/shell/presentation/pages/main_shell_page.dart';
import '../../features/patient/dashboard/presentation/pages/patient_dashboard_page.dart';
import '../../features/patient/medical_history/presentation/pages/medical_history_page.dart';
import '../../features/patient/access_management/presentation/pages/access_management_page.dart';
import '../../features/medecin/dashboard/presentation/pages/medecin_dashboard_page.dart';
import '../../features/medecin/search/presentation/pages/patient_search_page.dart';
import '../../features/medecin/patient_dossier/presentation/pages/patient_dossier_page.dart';

// Route names
class AppRoutes {
  static const splash = '/';
  static const login = '/login';

  // Patient routes
  static const patientDashboard = '/patient/dashboard';
  static const patientHistory = '/patient/history';
  static const patientAccess = '/patient/access';

  // Medecin routes
  static const medecinDashboard = '/medecin/dashboard';
  static const medecinSearch = '/medecin/search';
  static const medecinPatientDossier = '/medecin/patient/:patientId';

  static String patientDossierPath(String patientId) =>
      '/medecin/patient/$patientId';
}

final routerProvider = Provider<GoRouter>((ref) {
  // Listen to auth changes
  final authNotifier = ValueNotifier<AuthState?>(null);

  ref.listen<AuthState>(authProvider, (_, next) {
    authNotifier.value = next;
  });

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoading = authState.isLoading;
      final isAuthenticated = authState.isAuthenticated;
      final role = authState.role;

      final isSplash = state.matchedLocation == AppRoutes.splash;
      final isLoginPage = state.matchedLocation == AppRoutes.login;

      // Stay on splash while auth is being initialized
      if (isLoading) return null;

      // Not authenticated: redirect to login (from splash or any protected route)
      if (!isAuthenticated && !isLoginPage) {
        return AppRoutes.login;
      }

      // Authenticated: redirect from splash/login to appropriate dashboard
      if (isAuthenticated && (isSplash || isLoginPage)) {
        return _dashboardForRole(role);
      }

      // Prevent patients from accessing medecin routes and vice versa
      if (isAuthenticated) {
        final loc = state.matchedLocation;
        if (role == AuthRole.patient && loc.startsWith('/medecin')) {
          return AppRoutes.patientDashboard;
        }
        if (role == AuthRole.medecin && loc.startsWith('/patient')) {
          return AppRoutes.medecinDashboard;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: child,
            );
          },
        ),
      ),

      // === PATIENT SHELL ===
      ShellRoute(
        builder: (context, state, child) {
          return MainShellPage(role: AuthRole.patient, child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.patientDashboard,
            builder: (context, state) => const PatientDashboardPage(),
          ),
          GoRoute(
            path: AppRoutes.patientHistory,
            builder: (context, state) => const MedicalHistoryPage(),
          ),
          GoRoute(
            path: AppRoutes.patientAccess,
            builder: (context, state) => const AccessManagementPage(),
          ),
        ],
      ),

      // === MEDECIN SHELL ===
      ShellRoute(
        builder: (context, state, child) {
          return MainShellPage(role: AuthRole.medecin, child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.medecinDashboard,
            builder: (context, state) => const MedecinDashboardPage(),
          ),
          GoRoute(
            path: AppRoutes.medecinSearch,
            builder: (context, state) => const PatientSearchPage(),
          ),
          GoRoute(
            path: AppRoutes.medecinPatientDossier,
            builder: (context, state) {
              final patientId = state.pathParameters['patientId']!;
              return PatientDossierPage(patientId: patientId);
            },
          ),
        ],
      ),
    ],
  );
});

String _dashboardForRole(AuthRole role) {
  switch (role) {
    case AuthRole.patient:
      return AppRoutes.patientDashboard;
    case AuthRole.medecin:
      return AppRoutes.medecinDashboard;
    case AuthRole.admin:
    case AuthRole.manager:
    case AuthRole.unknown:
      return AppRoutes.login;
  }
}

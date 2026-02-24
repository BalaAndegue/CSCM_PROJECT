import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';
import '../../../../core/providers/api_client_provider.dart';

// Represents the auth state
enum AuthRole { patient, medecin, admin, manager, unknown }

class AuthState {
  const AuthState({
    this.token,
    this.role = AuthRole.unknown,
    this.isLoading = false,
    this.error,
  });

  final String? token;
  final AuthRole role;
  final bool isLoading;
  final String? error;

  bool get isAuthenticated => token != null;

  AuthState copyWith({
    String? token,
    AuthRole? role,
    bool? isLoading,
    String? error,
    bool clearToken = false,
    bool clearError = false,
  }) {
    return AuthState(
      token: clearToken ? null : (token ?? this.token),
      role: role ?? this.role,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._ref) : super(const AuthState());

  final Ref _ref;

  Future<void> init() async {
    // Signal loading so the router stays on splash
    state = state.copyWith(isLoading: true);

    try {
      final tokenStorage = _ref.read(tokenStorageProvider);
      final token = await tokenStorage.getAccessToken();
      final roleStr = await tokenStorage.getUserRole();

      if (token != null && roleStr != null) {
        final role = _parseRole(roleStr);
        // Update the API client with the token
        _ref.read(apiClientProvider).addDefaultHeader('Authorization', 'Bearer $token');
        state = AuthState(token: token, role: role);
      } else {
        // No stored session → go unauthenticated, triggers redirect to login
        state = const AuthState();
      }
    } catch (_) {
      state = const AuthState();
    }
  }

  Future<bool> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final authApi = AuthentificationApi(_ref.read(apiClientProvider));
      final response = await authApi.login(
        LoginRequest(email: email, motDePasse: password),
      );

      if (response?.data == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Réponse invalide du serveur',
        );
        return false;
      }

      final data = response!.data!;
      final token = data['accessToken']?.toString() ??
          data['token']?.toString() ??
          data['access_token']?.toString();
      final refreshToken = data['refreshToken']?.toString() ??
          data['refresh_token']?.toString();

      if (token == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Token non trouvé dans la réponse',
        );
        return false;
      }

      // Decode JWT to extract role
      final role = _extractRoleFromToken(token);

      // Persist tokens
      final tokenStorage = _ref.read(tokenStorageProvider);
      await tokenStorage.saveTokens(
        accessToken: token,
        refreshToken: refreshToken,
        role: role.name,
      );

      // Configure API client
      _ref.read(apiClientProvider).addDefaultHeader('Authorization', 'Bearer $token');

      state = AuthState(token: token, role: role);
      return true;
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _parseApiError(e),
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erreur de connexion. Vérifiez votre réseau.',
      );
      return false;
    }
  }

  Future<void> logout() async {
    try {
      final token = state.token;
      if (token != null) {
        final authApi = AuthentificationApi(_ref.read(apiClientProvider));
        await authApi.logout('Bearer $token');
      }
    } catch (_) {
      // Logout even if API call fails
    } finally {
      await _ref.read(tokenStorageProvider).clearAll();
      _ref.read(apiClientProvider).defaultHeaderMap.remove('Authorization');
      state = const AuthState();
    }
  }

  AuthRole _extractRoleFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return AuthRole.unknown;
      final payload = parts[1];
      final normalized = base64.normalize(payload);
      final decoded = utf8.decode(base64.decode(normalized));
      final json = jsonDecode(decoded) as Map<String, dynamic>;

      // Spring Boot typically puts role in "role" or "roles" or "authorities"
      final role = json['role']?.toString() ??
          json['roles']?.toString() ??
          (json['authorities'] is List
              ? (json['authorities'] as List).first?.toString()
              : null);

      return _parseRole(role ?? '');
    } catch (_) {
      return AuthRole.unknown;
    }
  }

  AuthRole _parseRole(String role) {
    final upper = role.toUpperCase();
    if (upper.contains('PATIENT')) return AuthRole.patient;
    if (upper.contains('MEDECIN')) return AuthRole.medecin;
    if (upper.contains('ADMIN')) return AuthRole.admin;
    if (upper.contains('MANAGER')) return AuthRole.manager;
    return AuthRole.unknown;
  }

  String _parseApiError(ApiException e) {
    if (e.code == 401) return 'Email ou mot de passe incorrect';
    if (e.code == 403) return 'Accès refusé';
    if (e.code == 404) return 'Compte introuvable';
    if (e.code == 429) return 'Trop de tentatives. Réessayez plus tard.';
    if (e.code >= 500) return 'Erreur serveur. Réessayez plus tard.';
    return e.message ?? 'Une erreur est survenue';
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carnet_medical_api/api.dart';

const _tokenKey = 'auth_access_token';
const _refreshTokenKey = 'auth_refresh_token';
const _userRoleKey = 'user_role';

class TokenStorage {
  TokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> saveTokens({
    required String accessToken,
    required String? refreshToken,
    required String role,
  }) async {
    await Future.wait([
      _storage.write(key: _tokenKey, value: accessToken),
      if (refreshToken != null)
        _storage.write(key: _refreshTokenKey, value: refreshToken),
      _storage.write(key: _userRoleKey, value: role),
    ]);
  }

  Future<String?> getAccessToken() => _storage.read(key: _tokenKey);
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);
  Future<String?> getUserRole() => _storage.read(key: _userRoleKey);

  Future<void> clearAll() async {
    await Future.wait([
      _storage.delete(key: _tokenKey),
      _storage.delete(key: _refreshTokenKey),
      _storage.delete(key: _userRoleKey),
    ]);
  }
}

// Providers
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage(ref.watch(secureStorageProvider));
});

// ⚠️  Ajuste cette adresse selon ton environnement :
//   - Émulateur Android  : 'http://10.0.2.2:8080/api'
//   - Vrai téléphone     : 'http://<IP_LAN_PC>:8080/api'  ex: 'http://192.168.1.42:8080/api'
const _apiBasePath = 'http://192.168.1.135:8080/api';

final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient(basePath: _apiBasePath);
  return client;
});

// Configures the ApiClient with the stored Bearer token
final authenticatedApiClientProvider = FutureProvider<ApiClient>((ref) async {
  final tokenStorage = ref.watch(tokenStorageProvider);
  final token = await tokenStorage.getAccessToken();
  final client = ref.watch(apiClientProvider);
  if (token != null) {
    client.addDefaultHeader('Authorization', 'Bearer $token');
  }
  return client;
});

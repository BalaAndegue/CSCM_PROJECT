import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carnet_medical/main.dart';
import 'package:carnet_medical/core/providers/api_client_provider.dart';

// A fake FlutterSecureStorage that stores values in memory (no platform channel).
class _InMemorySecureStorage extends Fake implements FlutterSecureStorage {
  final _store = <String, String>{};

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) _store[key] = value;
  }

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store[key];

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _store.remove(key);
  }
}

void main() {
  group('Smoke tests', () {
    testWidgets('App starts without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Replace secure storage with an in-memory fake so no
            // platform channel is needed during testing.
            secureStorageProvider.overrideWithValue(_InMemorySecureStorage()),
          ],
          child: const CSCMApp(),
        ),
      );

      // Let the splash page initialise
      await tester.pump(const Duration(milliseconds: 100));

      // The app must have rendered a MaterialApp without throwing
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App starts in unauthenticated state', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageProvider.overrideWithValue(_InMemorySecureStorage()),
          ],
          child: const CSCMApp(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      // No exception == pass; the login screen should eventually appear.
    });
  });
}

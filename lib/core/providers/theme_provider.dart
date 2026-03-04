import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider global pour le mode thème de l'application.
/// Persister dans SharedPreferences si souhaité, ici en mémoire.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

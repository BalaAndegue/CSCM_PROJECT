import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // === PRIMARY BRAND (Bleu médical moderne) ===
  static const Color primary = Color(0xFF1E6FD9);
  static const Color primaryLight = Color(0xFF5B9AF4);
  static const Color primaryDark = Color(0xFF0D4DA1);
  static const Color primaryContainer = Color(0xFFD6E8FF);
  static const Color primaryDarkContainer = Color(0xFF1A3F7A);

  // === SECONDARY (Vert aqua santé) ===
  static const Color secondary = Color(0xFF00A896);
  static const Color secondaryLight = Color(0xFF33C4B5);
  static const Color secondaryDark = Color(0xFF007268);
  static const Color secondaryContainer = Color(0xFFB2F0EA);
  static const Color secondaryDarkContainer = Color(0xFF005A54);

  // === ACCENT (Lavande douce – confiance) ===
  static const Color accent = Color(0xFF7C6FF7);
  static const Color accentContainer = Color(0xFFE8E5FF);

  // === SEMANTIC ===
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFFF6B6B);
  static const Color errorDark = Color(0xFFB71C1C);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color errorDarkContainer = Color(0xFF780000);

  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFF4CAF50);
  static const Color successContainer = Color(0xFFC8E6C9);

  static const Color warning = Color(0xFFF57F17);
  static const Color warningLight = Color(0xFFFFCA28);
  static const Color warningContainer = Color(0xFFFFF8E1);

  static const Color info = Color(0xFF0288D1);
  static const Color infoContainer = Color(0xFFE1F5FE);

  // === SURFACE – LIGHT MODE ===
  static const Color surfaceLight = Color(0xFFF8FAFF);
  static const Color onSurfaceLight = Color(0xFF0F172A);
  static const Color surfaceVariantLight = Color(0xFFF1F5FF);
  static const Color onSurfaceVariantLight = Color(0xFF64748B);
  static const Color outlineLight = Color(0xFFCBD5E1);
  static const Color outlineVariantLight = Color(0xFFE8EEFF);

  // === SURFACE – DARK MODE ===
  static const Color surfaceDark = Color(0xFF0B1120);
  static const Color onSurfaceDark = Color(0xFFE2E8F5);
  static const Color surfaceVariantDark = Color(0xFF131D30);
  static const Color onSurfaceVariantDark = Color(0xFF94A3B8);
  static const Color outlineDark = Color(0xFF2A3A58);
  static const Color outlineVariantDark = Color(0xFF1E2D45);
  static const Color cardDark = Color(0xFF101C32);

  // === GLASSMORPHISM ===
  static Color glassSurface(bool isDark) =>
      isDark ? const Color(0x1AFFFFFF) : const Color(0xCCFFFFFF);
  static Color glassBorder(bool isDark) =>
      isDark ? const Color(0x33FFFFFF) : const Color(0xB3FFFFFF);

  // === GRADIENT PRESETS ===
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E6FD9), Color(0xFF5B9AF4)],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D4DA1), Color(0xFF1E6FD9), Color(0xFF7C6FF7)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE8F0FF), Color(0xFFF5F0FF)],
  );

  static const LinearGradient darkHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D1B3E), Color(0xFF1A2F5A), Color(0xFF251A4A)],
    stops: [0.0, 0.5, 1.0],
  );

  // === ROLE COLORS ===
  static const Color patientColor = Color(0xFF1E6FD9);
  static const Color medecinColor = Color(0xFF00A896);
  static const Color adminColor = Color(0xFF7C6FF7);
  static const Color managerColor = Color(0xFFF57F17);

  // === HEALTH SEMANTIC COLORS ===
  static const Color heartRate = Color(0xFFE53935);
  static const Color oxygen = Color(0xFF1E6FD9);
  static const Color bloodPressure = Color(0xFF7C6FF7);
  static const Color temperature = Color(0xFFF57F17);
}

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF050505);
  static const surface = Color(0xFF0E0E0E);
  static const surfaceLow = Color(0xFF151515);
  static const surfaceHigh = Color(0xFF1B1B1D);
  static const surfaceHighest = Color(0xFF242428);
  static const surfaceBright = Color(0xFF2B2C31);
  static const foreground = Color(0xFFF5F7FB);
  static const foregroundMuted = Color(0xFFAAAAB3);
  static const foregroundSoft = Color(0xFF7E818D);

  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceLow = Color(0xFFF7F9FC);
  static const lightSurfaceHigh = Color(0xFFEEF3F9);
  static const lightSurfaceHighest = Color(0xFFE4EBF5);
  static const lightSurfaceBright = Color(0xFFD8E1EE);
  static const lightForeground = Color(0xFF121826);
  static const lightForegroundMuted = Color(0xFF5A6577);
  static const lightForegroundSoft = Color(0xFF7D8797);

  static const electricBlue = Color(0xFF466DFF);
  static const electricBlueDim = Color(0xFF3452D1);
  static const neonGreen = Color(0xFF1E9A4A);
  static const neonGreenSoft = Color(0xFF1F4C17);
  static const vividOrange = Color(0xFFE36C36);
  static const vividOrangeSoft = Color(0xFF4A241A);
  static const crimson = Color(0xFFFF5E66);

  static const outline = Color(0x33FFFFFF);
  static const ghostOutline = Color(0x1FFFFFFF);
  static const shadow = Color(0x66000000);

  static const glass = Color(0xB31A1A1D);
  static const cardGradientStart = Color(0xFF171719);
  static const cardGradientEnd = Color(0xFF111113);

  static Gradient backgroundGradientFor(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF090909), Color(0xFF0E0E0E), Color(0xFF121214)],
      );
    }

    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFF9FBFE), Color(0xFFF3F7FC), Color(0xFFEAF1F9)],
    );
  }

  static const primaryButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [electricBlueDim, electricBlue],
  );

  static const greenPanelGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF12200F), Color(0xFF111313)],
  );

  static const orangePanelGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF291710), Color(0xFF151313)],
  );

  static const bluePanelGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF101826), Color(0xFF151516)],
  );

  static Color glassFor(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xB31A1A1D)
        : const Color(0xEFFFFFFF);
  }

  static Color ghostOutlineFor(Brightness brightness) {
    return brightness == Brightness.dark
        ? ghostOutline
        : const Color(0x160F172A);
  }

  static Color shadowFor(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0x66000000)
        : const Color(0x140F172A);
  }

  static Color softFillFor(Brightness brightness) {
    return brightness == Brightness.dark
        ? white.withValues(alpha: 0.09)
        : lightForeground.withValues(alpha: 0.06);
  }

  static Color progressTrackFor(Brightness brightness) {
    return brightness == Brightness.dark
        ? white.withValues(alpha: 0.10)
        : lightForeground.withValues(alpha: 0.10);
  }
}

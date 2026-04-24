import 'package:flutter/material.dart';
import 'package:forge/app/theme/app_colors.dart';

class AppTypography {
  const AppTypography._();

  static TextTheme textTheme(Brightness brightness) {
    final baseColor = brightness == Brightness.dark
        ? AppColors.foreground
        : const Color(0xFF101114);
    final mutedColor = brightness == Brightness.dark
        ? AppColors.foregroundMuted
        : const Color(0xFF4D5562);

    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        height: 0.95,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.8,
        color: baseColor,
      ),
      displayMedium: TextStyle(
        fontSize: 38,
        height: 0.98,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.4,
        color: baseColor,
      ),
      displaySmall: TextStyle(
        fontSize: 30,
        height: 1,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.0,
        color: baseColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        height: 1.05,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        color: baseColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: baseColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        color: baseColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: baseColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.45,
        fontWeight: FontWeight.w400,
        color: baseColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w400,
        color: baseColor,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        height: 1.35,
        fontWeight: FontWeight.w400,
        color: mutedColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
        color: baseColor,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: mutedColor,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.4,
        color: mutedColor,
      ),
    );
  }
}

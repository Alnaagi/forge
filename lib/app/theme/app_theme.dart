import 'package:flutter/material.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_radii.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/app/theme/app_typography.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    return _base(Brightness.light);
  }

  static ThemeData dark() {
    return _base(Brightness.dark);
  }

  static ThemeData _base(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = isDark
        ? const ColorScheme.dark(
            primary: AppColors.electricBlue,
            onPrimary: AppColors.white,
            secondary: AppColors.neonGreen,
            onSecondary: AppColors.white,
            tertiary: AppColors.vividOrange,
            onTertiary: AppColors.white,
            error: AppColors.crimson,
            onError: AppColors.white,
            surface: AppColors.surface,
            onSurface: AppColors.foreground,
            outline: AppColors.outline,
            shadow: AppColors.shadow,
            surfaceTint: AppColors.electricBlue,
          ).copyWith(
            surfaceContainerLowest: AppColors.black,
            surfaceContainerLow: AppColors.surfaceLow,
            surfaceContainer: AppColors.surfaceHigh,
            surfaceContainerHigh: AppColors.surfaceHighest,
            surfaceContainerHighest: AppColors.surfaceBright,
            onSurfaceVariant: AppColors.foregroundMuted,
          )
        : const ColorScheme.light(
            primary: AppColors.electricBlue,
            onPrimary: AppColors.white,
            secondary: AppColors.neonGreen,
            onSecondary: AppColors.white,
            tertiary: AppColors.vividOrange,
            onTertiary: AppColors.white,
            error: AppColors.crimson,
            onError: AppColors.white,
            surface: AppColors.lightSurfaceLow,
            onSurface: AppColors.lightForeground,
            outline: Color(0x220F172A),
            shadow: Color(0x140F172A),
            surfaceTint: AppColors.electricBlue,
          ).copyWith(
            surfaceContainerLowest: AppColors.white,
            surfaceContainerLow: AppColors.lightSurface,
            surfaceContainer: AppColors.lightSurfaceLow,
            surfaceContainerHigh: AppColors.lightSurfaceHigh,
            surfaceContainerHighest: AppColors.lightSurfaceHighest,
            onSurfaceVariant: AppColors.lightForegroundMuted,
          );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: AppTypography.textTheme(brightness),
      dividerColor: Colors.transparent,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.textTheme(brightness).titleLarge,
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLow,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.card),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.input),
          textStyle: AppTypography.textTheme(brightness).labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          minimumSize: const Size.fromHeight(52),
          side: BorderSide(color: scheme.outline.withValues(alpha: 0.12)),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.input),
          textStyle: AppTypography.textTheme(brightness).labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        hintStyle: TextStyle(color: scheme.onSurfaceVariant),
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
        prefixIconColor: scheme.secondary,
        suffixIconColor: scheme.onSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(color: scheme.primary, width: 1.3),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        selectedColor: scheme.secondary,
        disabledColor: scheme.surfaceContainer,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        shape: const StadiumBorder(),
        side: BorderSide.none,
        labelStyle: TextStyle(color: scheme.onSurface),
        secondaryLabelStyle: TextStyle(color: scheme.onSecondary),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        contentTextStyle: TextStyle(color: scheme.onSurface),
        shape: RoundedRectangleBorder(borderRadius: AppRadii.input),
        behavior: SnackBarBehavior.floating,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        height: 84,
        elevation: 0,
        indicatorColor: scheme.secondary.withValues(
          alpha: isDark ? 0.18 : 0.14,
        ),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final color = states.contains(WidgetState.selected)
              ? scheme.secondary
              : scheme.onSurfaceVariant;
          return AppTypography.textTheme(
            brightness,
          ).labelSmall!.copyWith(color: color);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final color = states.contains(WidgetState.selected)
              ? scheme.secondary
              : scheme.onSurfaceVariant;
          return IconThemeData(color: color, size: 24);
        }),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.sheet),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_radii.dart';
import 'package:forge/app/theme/app_spacing.dart';

class AppPanel extends StatelessWidget {
  const AppPanel({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.gradient,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    final body = DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        gradient: _resolvedGradient(context),
        borderRadius: AppRadii.card,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowFor(brightness),
            blurRadius: brightness == Brightness.dark ? 22 : 18,
            offset: Offset(0, brightness == Brightness.dark ? 14 : 10),
          ),
        ],
        border: Border.all(color: AppColors.ghostOutlineFor(brightness)),
      ),
      child: Padding(padding: padding, child: child),
    );

    if (onTap == null) {
      return body;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(borderRadius: AppRadii.card, onTap: onTap, child: body),
    );
  }

  Gradient? _resolvedGradient(BuildContext context) {
    if (gradient == null) {
      return null;
    }

    if (Theme.of(context).brightness == Brightness.dark) {
      return gradient;
    }

    final base = Theme.of(context).colorScheme.surfaceContainerLow;
    Color blend(Color color) {
      return Color.alphaBlend(color.withValues(alpha: 0.14), base);
    }

    final resolvedGradient = gradient!;
    if (resolvedGradient is LinearGradient) {
      return LinearGradient(
        begin: resolvedGradient.begin,
        end: resolvedGradient.end,
        colors: resolvedGradient.colors.map(blend).toList(growable: false),
        stops: resolvedGradient.stops,
        tileMode: resolvedGradient.tileMode,
        transform: resolvedGradient.transform,
      );
    }

    if (resolvedGradient is RadialGradient) {
      return RadialGradient(
        center: resolvedGradient.center,
        radius: resolvedGradient.radius,
        colors: resolvedGradient.colors.map(blend).toList(growable: false),
        stops: resolvedGradient.stops,
        tileMode: resolvedGradient.tileMode,
        focal: resolvedGradient.focal,
        focalRadius: resolvedGradient.focalRadius,
        transform: resolvedGradient.transform,
      );
    }

    if (resolvedGradient is SweepGradient) {
      return SweepGradient(
        center: resolvedGradient.center,
        startAngle: resolvedGradient.startAngle,
        endAngle: resolvedGradient.endAngle,
        colors: resolvedGradient.colors.map(blend).toList(growable: false),
        stops: resolvedGradient.stops,
        tileMode: resolvedGradient.tileMode,
        transform: resolvedGradient.transform,
      );
    }

    return resolvedGradient;
  }
}

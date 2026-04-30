import 'package:flutter/material.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/app/core/widgets/app_page_header.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.title,
    required this.child,
    this.subtitle,
    this.eyebrow,
    this.actions,
    this.floatingActionButton,
    this.padding,
    this.showHeader = true,
    super.key,
  });

  final String title;
  final Widget child;
  final String? subtitle;
  final String? eyebrow;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry? padding;
  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: floatingActionButton,
      appBar: actions == null || actions!.isEmpty
          ? null
          : AppBar(actions: actions),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradientFor(brightness),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -40,
              child: _GlowOrb(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.10),
                size: 220,
              ),
            ),
            Positioned(
              top: 180,
              left: -60,
              child: _GlowOrb(
                color: Theme.of(
                  context,
                ).colorScheme.secondary.withValues(alpha: 0.08),
                size: 180,
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                    padding ??
                    const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                      AppSpacing.xl,
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showHeader)
                      AppPageHeader(
                        eyebrow: eyebrow,
                        title: title,
                        subtitle: subtitle,
                      ),
                    if (showHeader) const SizedBox(height: AppSpacing.lg),
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_radii.dart';
import 'package:forge/app/theme/app_spacing.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.glassFor(brightness),
          borderRadius: AppRadii.card,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowFor(
                brightness,
              ).withValues(alpha: brightness == Brightness.dark ? 0.32 : 0.12),
              blurRadius: brightness == Brightness.dark ? 28 : 20,
              offset: Offset(0, brightness == Brightness.dark ? 16 : 10),
            ),
          ],
          border: Border.all(color: AppColors.ghostOutlineFor(brightness)),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.fitness_center),
              label: 'Workouts',
            ),
            NavigationDestination(
              icon: Icon(Icons.restaurant_menu),
              label: 'Nutrition',
            ),
            NavigationDestination(
              icon: Icon(Icons.show_chart),
              label: 'Progress',
            ),
            NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/theme/app_spacing.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: title,
      subtitle:
          'Premium shell in place. Real behavior stays honest until this milestone starts.',
      child: ListView(
        children: [
          AppPanel(
            child: AppEmptyState(
              icon: Icons.auto_awesome_mosaic_outlined,
              title: '$title is staged next',
              message: description,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What is ready now',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'The navigation shell, theme system, and existing local-first foundations are already wired so this surface can pick up real data safely when its milestone begins.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

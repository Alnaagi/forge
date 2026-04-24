import 'package:flutter/material.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';

class RestTimerCard extends StatelessWidget {
  const RestTimerCard({
    required this.remainingSeconds,
    required this.isRunning,
    required this.onPause,
    required this.onResume,
    required this.onReset,
    super.key,
  });

  final int remainingSeconds;
  final bool isRunning;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');

    return AppPanel(
      gradient: AppColors.orangePanelGradient,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.tertiary.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.timer_outlined,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rest Timer',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  '$minutes:$seconds',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Text(
                  isRunning ? 'Running' : 'Paused',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          FilledButton.tonalIcon(
            onPressed: isRunning ? onPause : onResume,
            icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
            label: Text(isRunning ? 'Pause' : 'Resume'),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton(onPressed: onReset, icon: const Icon(Icons.replay)),
        ],
      ),
    );
  }
}

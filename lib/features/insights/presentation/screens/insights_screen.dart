import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/insight_providers.dart';
import 'package:forge/domain/entities/insight.dart';
import 'package:forge/features/insights/presentation/controllers/insight_action_resolver.dart';
import 'package:forge/shared/enums/insight_severity.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightsAsync = ref.watch(activeInsightsProvider);

    return AppScaffold(
      title: 'Active Insights',
      eyebrow: 'Evidence First',
      subtitle:
          'These are the live deterministic signals Forge is currently acting on. Each one shows the why, the evidence, and the clearest next move.',
      actions: [
        IconButton(
          tooltip: 'Refresh insights',
          onPressed: () => ref.read(insightsControllerProvider).refresh(),
          icon: const Icon(Icons.refresh),
        ),
      ],
      child: insightsAsync.when(
        data: (insights) {
          if (insights.isEmpty) {
            return const AppPanel(
              child: AppEmptyState(
                icon: Icons.tips_and_updates_outlined,
                title: 'No active insights right now',
                message:
                    'Once Forge sees a clear deterministic signal, it will show up here with evidence and a suggested action.',
              ),
            );
          }

          return ListView(
            children: [
              for (final insight in insights) ...[
                _InsightCard(insight: insight),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          );
        },
        error: (error, stackTrace) => AppErrorState(message: error.toString()),
        loading: () => const AppLoadingView(label: 'Loading active insights'),
      ),
    );
  }
}

class _InsightCard extends ConsumerWidget {
  const _InsightCard({required this.insight});

  final Insight insight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evidence = _decodeEvidence(insight.evidenceJson);
    final actions = resolveInsightActions(insight);
    final accent = switch (insight.severity) {
      InsightSeverity.low => AppColors.electricBlue,
      InsightSeverity.medium => AppColors.vividOrange,
      InsightSeverity.high => AppColors.crimson,
    };

    return AppPanel(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          accent.withValues(alpha: 0.14),
          Theme.of(context).colorScheme.surfaceContainerLow,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insight.title,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(color: accent),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${insight.category.name} | ${insight.severity.name} severity | ${(insight.confidence * 100).round()}% confidence',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Dismiss insight',
                onPressed: () async {
                  await ref
                      .read(insightsControllerProvider)
                      .dismissInsight(insight.id);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            insight.shortMessage,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            insight.fullExplanation,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Suggested action',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            insight.suggestedAction,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (actions.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final action in actions.asMap().entries)
                  action.key == 0
                      ? FilledButton.icon(
                          onPressed: () => executeInsightAction(
                            context: context,
                            ref: ref,
                            action: action.value,
                          ),
                          icon: Icon(action.value.icon),
                          label: Text(action.value.label),
                        )
                      : OutlinedButton.icon(
                          onPressed: () => executeInsightAction(
                            context: context,
                            ref: ref,
                            action: action.value,
                          ),
                          icon: Icon(action.value.icon),
                          label: Text(action.value.label),
                        ),
              ],
            ),
          ],
          if (evidence.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text('Evidence', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: evidence.entries
                  .map(
                    (entry) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softFillFor(
                          Theme.of(context).brightness,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${_humanizeKey(entry.key)}: ${entry.value}',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ],
        ],
      ),
    );
  }
}

Map<String, dynamic> _decodeEvidence(String rawJson) {
  try {
    final decoded = jsonDecode(rawJson);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
  } catch (_) {
    return const {};
  }
  return const {};
}

String _humanizeKey(String key) {
  return key
      .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
      .replaceAll('_', ' ')
      .trim();
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/health_sync_providers.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/domain/entities/health_profile.dart';
import 'package:forge/domain/entities/health_status_log.dart';
import 'package:forge/features/health/presentation/controllers/health_overview_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:forge/shared/enums/health_entry_type.dart';

class HealthStatusScreen extends ConsumerStatefulWidget {
  const HealthStatusScreen({
    this.initialEntryTypeName,
    this.openComposer = false,
    super.key,
  });

  final String? initialEntryTypeName;
  final bool openComposer;

  @override
  ConsumerState<HealthStatusScreen> createState() => _HealthStatusScreenState();
}

class _HealthStatusScreenState extends ConsumerState<HealthStatusScreen> {
  final _searchController = TextEditingController();
  bool _didHandleInitialComposer = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !widget.openComposer || _didHandleInitialComposer) {
        return;
      }
      _didHandleInitialComposer = true;
      _openLogDialog(_parseType(widget.initialEntryTypeName));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(healthProfileProvider);
    final logsAsync = ref.watch(healthStatusLogsProvider);
    final overview = ref.watch(healthOverviewProvider);
    final healthSyncOverview = ref
        .watch(healthSyncOverviewProvider)
        .valueOrNull;

    if (profileAsync.hasError) {
      return AppScaffold(
        title: 'Health',
        eyebrow: 'Recovery',
        child: AppErrorState(message: profileAsync.error.toString()),
      );
    }
    if (logsAsync.hasError) {
      return AppScaffold(
        title: 'Health',
        eyebrow: 'Recovery',
        child: AppErrorState(message: logsAsync.error.toString()),
      );
    }
    if (profileAsync.isLoading || logsAsync.isLoading) {
      return const AppScaffold(
        title: 'Health',
        eyebrow: 'Recovery',
        child: AppLoadingView(label: 'Loading health timeline'),
      );
    }

    final filteredLogs = overview.logs
        .where((log) {
          final query = _searchController.text.trim().toLowerCase();
          if (query.isEmpty) {
            return true;
          }
          final haystack = [
            log.title,
            ...log.symptomTags,
            log.bodyArea ?? '',
            log.possibleTrigger ?? '',
            log.notes ?? '',
          ].join(' ').toLowerCase();
          return haystack.contains(query);
        })
        .toList(growable: false);

    return AppScaffold(
      title: 'Health',
      eyebrow: 'Recovery',
      subtitle:
          'Track symptoms, mood, pain, and injuries over time so Forge can surface trigger patterns and food cautions without pretending to diagnose you.',
      actions: [
        IconButton(
          tooltip: 'Edit health profile',
          onPressed: () => _openProfileDialog(overview.profile),
          icon: const Icon(Icons.medical_information_outlined),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            _openLogDialog(_parseType(widget.initialEntryTypeName)),
        icon: const Icon(Icons.add),
        label: const Text('Log Health'),
      ),
      child: ListView(
        children: [
          AppPanel(
            gradient: AppColors.orangePanelGradient,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overview.activeLogs.isEmpty
                      ? 'No active health flags'
                      : '${overview.activeLogs.length} active health flags',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  overview.profile == null
                      ? 'Add allergies, medications, and long-term issues so nutrition checks can watch for obvious conflicts.'
                      : 'Check-in cadence: every ${overview.profile!.checkInCadenceHours} hours. Forge already uses this to plan health check reminders on supported Android builds.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _openLogDialog(HealthEntryType.symptom),
                      icon: const Icon(Icons.monitor_heart_outlined),
                      label: const Text('Log Symptom'),
                    ),
                    FilledButton.tonalIcon(
                      onPressed: () => _openLogDialog(HealthEntryType.mood),
                      icon: const Icon(Icons.bedtime_outlined),
                      label: const Text('Log Mood'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _openLogDialog(HealthEntryType.pain),
                      icon: const Icon(Icons.healing_outlined),
                      label: const Text('Pain / Injury'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () =>
                          context.pushNamed(RouteNames.integrations),
                      icon: const Icon(Icons.sync_outlined),
                      label: Text(
                        healthSyncOverview?.lastSyncAt == null
                            ? 'Connect Health'
                            : 'Health Sync',
                      ),
                    ),
                  ],
                ),
                if (healthSyncOverview?.hasImportedData ?? false) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    healthSyncOverview?.todaySteps == null
                        ? 'Health Connect data is available for recovery context.'
                        : '${healthSyncOverview!.todaySteps} synced steps are already in today\'s imported health stream.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (overview.generalAdvice.isNotEmpty) ...[
            AppPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Guidance',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final line in overview.generalAdvice)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: Text(
                        '- $line',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          AppPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pattern Watch',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'This is a trigger journal, not a diagnosis engine. It helps you spot repeated symptoms and repeated triggers over time.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.md),
                _PatternRow(
                  title: 'Repeated Symptoms',
                  items: overview.commonSymptoms,
                  emptyLabel: 'No patterns yet',
                  accent: AppColors.electricBlue,
                ),
                const SizedBox(height: AppSpacing.md),
                _PatternRow(
                  title: 'Repeated Triggers',
                  items: overview.commonTriggers,
                  emptyLabel: 'No triggers logged yet',
                  accent: AppColors.vividOrange,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPanel(
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search symptoms, triggers, body area, or notes',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (filteredLogs.isEmpty)
            const AppPanel(
              child: AppEmptyState(
                icon: Icons.health_and_safety_outlined,
                title: 'No health timeline entries yet',
                message:
                    'Start logging symptoms, mood, pain, or injuries so Forge can build recovery context and trigger patterns.',
              ),
            )
          else
            for (final log in filteredLogs) ...[
              AppPanel(
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
                                log.title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                '${log.type.label} - Severity ${log.severity}/5',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: AppSpacing.xxs),
                              Text(
                                _formatTimeline(log),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              tooltip: 'Edit health log',
                              onPressed: () => _openLogDialog(log.type, log),
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              tooltip: 'Delete health log',
                              onPressed: () => _deleteLog(log),
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (log.symptomTags.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        children: log.symptomTags
                            .map((tag) => _HealthChip(label: tag))
                            .toList(growable: false),
                      ),
                    ],
                    if (log.bodyArea != null ||
                        log.possibleTrigger != null ||
                        log.energyLevel != null ||
                        (log.notes ?? '').trim().isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      if (log.bodyArea != null)
                        Text(
                          'Body area: ${log.bodyArea!}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      if (log.possibleTrigger != null)
                        Text(
                          'Possible trigger: ${log.possibleTrigger!}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      if (log.energyLevel != null)
                        Text(
                          'Energy: ${log.energyLevel}/5',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      if ((log.notes ?? '').trim().isNotEmpty)
                        Text(
                          log.notes!.trim(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
        ],
      ),
    );
  }

  Future<void> _openProfileDialog(HealthProfile? existingProfile) async {
    final conditionsController = TextEditingController(
      text: existingProfile?.healthConditions.join('\n') ?? '',
    );
    final medicationsController = TextEditingController(
      text: existingProfile?.medications.join('\n') ?? '',
    );
    final allergiesController = TextEditingController(
      text: existingProfile?.allergies.join('\n') ?? '',
    );
    final notesController = TextEditingController(
      text: existingProfile?.notes ?? '',
    );
    var cadenceHours = existingProfile?.checkInCadenceHours ?? 8;

    final didSave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Health Profile'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: conditionsController,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Health conditions',
                        helperText: 'One per line or comma-separated',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: medicationsController,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Medications',
                        helperText: 'One per line or comma-separated',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: allergiesController,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Allergies',
                        helperText: 'One per line or comma-separated',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DropdownButtonFormField<int>(
                      initialValue: cadenceHours,
                      decoration: const InputDecoration(
                        labelText: 'Check-in cadence',
                      ),
                      items: const [4, 8, 12, 24]
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text('Every $value hours'),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() => cadenceHours = value);
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: notesController,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Profile notes',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    await ref
                        .read(healthTrackingControllerProvider)
                        .saveHealthProfile(
                          existingProfile: existingProfile,
                          healthConditions: conditionsController.text,
                          medications: medicationsController.text,
                          allergies: allergiesController.text,
                          notes: notesController.text,
                          checkInCadenceHours: cadenceHours,
                        );
                    if (!dialogContext.mounted) {
                      return;
                    }
                    Navigator.of(dialogContext).pop(true);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    conditionsController.dispose();
    medicationsController.dispose();
    allergiesController.dispose();
    notesController.dispose();

    if (didSave != true || !mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Health profile updated.')));
  }

  Future<void> _openLogDialog(
    HealthEntryType initialType, [
    HealthStatusLog? existingLog,
  ]) async {
    final titleController = TextEditingController(
      text: existingLog?.title ?? '',
    );
    final tagsController = TextEditingController(
      text: existingLog?.symptomTags.join(', ') ?? '',
    );
    final bodyAreaController = TextEditingController(
      text: existingLog?.bodyArea ?? '',
    );
    final triggerController = TextEditingController(
      text: existingLog?.possibleTrigger ?? '',
    );
    final notesController = TextEditingController(
      text: existingLog?.notes ?? '',
    );

    var selectedType = existingLog?.type ?? initialType;
    var severity = existingLog?.severity ?? 3;
    var energyLevel = existingLog?.energyLevel ?? 3;
    var includeEnergy =
        existingLog?.energyLevel != null ||
        selectedType == HealthEntryType.mood;
    var startedAt =
        existingLog?.startedAt ?? existingLog?.loggedAt ?? DateTime.now();
    var loggedAt = existingLog?.loggedAt ?? DateTime.now();
    var resolved = existingLog?.resolvedAt != null;
    var resolvedAt = existingLog?.resolvedAt;

    final didSave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                existingLog == null
                    ? 'Log Health Status'
                    : 'Edit Health Status',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<HealthEntryType>(
                      initialValue: selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Entry type',
                      ),
                      items: HealthEntryType.values
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type.label),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          selectedType = value;
                          if (selectedType == HealthEntryType.mood) {
                            includeEnergy = true;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        helperText:
                            'Examples: Migraine, Stomach pain, Low energy',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: tagsController,
                      decoration: const InputDecoration(
                        labelText: 'Symptoms / tags',
                        helperText: 'Comma-separated',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: bodyAreaController,
                      decoration: const InputDecoration(labelText: 'Body area'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: triggerController,
                      decoration: const InputDecoration(
                        labelText: 'Possible trigger',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: _ValueStepper(
                            label: 'Severity',
                            value: severity,
                            onChanged: (value) =>
                                setState(() => severity = value),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            value: includeEnergy,
                            title: const Text('Energy'),
                            onChanged: (value) =>
                                setState(() => includeEnergy = value),
                          ),
                        ),
                      ],
                    ),
                    if (includeEnergy)
                      _ValueStepper(
                        label: 'Energy level',
                        value: energyLevel,
                        onChanged: (value) =>
                            setState(() => energyLevel = value),
                      ),
                    const SizedBox(height: AppSpacing.md),
                    _DateTimeRow(
                      label: 'Started',
                      value: startedAt,
                      onChanged: (value) => setState(() => startedAt = value),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _DateTimeRow(
                      label: 'Logged',
                      value: loggedAt,
                      onChanged: (value) => setState(() => loggedAt = value),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: resolved,
                      title: const Text('Resolved'),
                      onChanged: (value) => setState(() {
                        resolved = value;
                        resolvedAt ??= loggedAt;
                      }),
                    ),
                    if (resolved)
                      _DateTimeRow(
                        label: 'Resolved',
                        value: resolvedAt ?? loggedAt,
                        onChanged: (value) =>
                            setState(() => resolvedAt = value),
                      ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: notesController,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(labelText: 'Notes'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    try {
                      await ref
                          .read(healthTrackingControllerProvider)
                          .saveHealthLog(
                            existingLog: existingLog,
                            type: selectedType,
                            title: titleController.text,
                            severity: severity,
                            loggedAt: loggedAt,
                            startedAt: startedAt,
                            resolvedAt: resolved
                                ? resolvedAt ?? loggedAt
                                : null,
                            energyLevel: includeEnergy ? energyLevel : null,
                            bodyArea: bodyAreaController.text,
                            symptomTags: tagsController.text,
                            possibleTrigger: triggerController.text,
                            notes: notesController.text,
                          );
                    } on StateError catch (error) {
                      if (!dialogContext.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(
                        dialogContext,
                      ).showSnackBar(SnackBar(content: Text(error.message)));
                      return;
                    }
                    if (!dialogContext.mounted) {
                      return;
                    }
                    Navigator.of(dialogContext).pop(true);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    titleController.dispose();
    tagsController.dispose();
    bodyAreaController.dispose();
    triggerController.dispose();
    notesController.dispose();

    if (didSave != true || !mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existingLog == null
              ? 'Health status logged.'
              : 'Health status updated.',
        ),
      ),
    );
  }

  Future<void> _deleteLog(HealthStatusLog log) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Health Log'),
          content: Text('Remove "${log.title}" from your health timeline?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
    if (confirmed != true) {
      return;
    }

    await ref.read(healthTrackingControllerProvider).deleteHealthLog(log.id);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Health log removed.')));
  }
}

class _PatternRow extends StatelessWidget {
  const _PatternRow({
    required this.title,
    required this.items,
    required this.emptyLabel,
    required this.accent,
  });

  final String title;
  final List<HealthPatternCount> items;
  final String emptyLabel;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        if (items.isEmpty)
          Text(emptyLabel, style: Theme.of(context).textTheme.bodySmall)
        else
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: items
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${item.label} (${item.count})',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                )
                .toList(growable: false),
          ),
      ],
    );
  }
}

class _HealthChip extends StatelessWidget {
  const _HealthChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.softFillFor(Theme.of(context).brightness),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}

class _ValueStepper extends StatelessWidget {
  const _ValueStepper({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        IconButton(
          onPressed: value > 1 ? () => onChanged(value - 1) : null,
          icon: const Icon(Icons.remove_circle_outline),
        ),
        Text('$value'),
        IconButton(
          onPressed: value < 5 ? () => onChanged(value + 1) : null,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}

class _DateTimeRow extends StatelessWidget {
  const _DateTimeRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$label: ${_formatDateTime(value)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextButton(
          onPressed: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: value,
              firstDate: DateTime(2020),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (pickedDate == null || !context.mounted) {
              return;
            }
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(value),
            );
            if (pickedTime == null) {
              return;
            }
            onChanged(
              DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              ),
            );
          },
          child: const Text('Change'),
        ),
      ],
    );
  }
}

HealthEntryType _parseType(String? rawValue) {
  for (final type in HealthEntryType.values) {
    if (type.name == rawValue) {
      return type;
    }
  }
  return HealthEntryType.symptom;
}

String _formatTimeline(HealthStatusLog log) {
  final parts = <String>['Logged ${_formatDateTime(log.loggedAt)}'];
  if (log.startedAt != null) {
    parts.add('Started ${_formatDateTime(log.startedAt!)}');
  }
  if (log.resolvedAt != null) {
    parts.add('Resolved ${_formatDateTime(log.resolvedAt!)}');
  } else {
    parts.add('Still active');
  }
  return parts.join(' - ');
}

String _formatDateTime(DateTime value) {
  final local = value.toLocal();
  final hour = local.hour == 0
      ? 12
      : (local.hour > 12 ? local.hour - 12 : local.hour);
  final minute = local.minute.toString().padLeft(2, '0');
  final period = local.hour >= 12 ? 'PM' : 'AM';
  return '${local.month}/${local.day}/${local.year} $hour:$minute $period';
}

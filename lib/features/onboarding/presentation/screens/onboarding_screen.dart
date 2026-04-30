import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/goal_providers.dart';
import 'package:forge/application/providers/profile_providers.dart';
import 'package:forge/application/providers/settings_providers.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/goal.dart';
import 'package:forge/domain/entities/user_profile.dart';
import 'package:forge/domain/entities/workout_template.dart';
import 'package:forge/domain/entities/workout_template_item.dart';
import 'package:forge/domain/services/body_baseline_service.dart';
import 'package:forge/domain/services/goal_recommendation_service.dart';
import 'package:forge/features/body_metrics/presentation/controllers/body_progress_controller.dart';
import 'package:forge/features/goals/presentation/controllers/goal_settings_controller.dart';
import 'package:forge/features/templates/presentation/controllers/template_list_controller.dart';
import 'package:forge/features/health/presentation/controllers/health_overview_controller.dart';
import 'package:forge/shared/enums/activity_level.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/goal_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/unit_system/unit_converter.dart';
import 'package:forge/shared/value_objects/macro_target.dart';
import 'package:forge/shared/value_objects/measurement_value.dart';
import 'package:forge/shared/value_objects/weight_value.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _nameController = TextEditingController();
  final _conditionsController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _notesController = TextEditingController();
  final _currentWeightController = TextEditingController();
  final _goalWeightController = TextEditingController();
  final _heightController = TextEditingController();
  final _waistController = TextEditingController();
  final _bodyFatController = TextEditingController();
  bool _initialized = false;
  bool _saving = false;
  bool _healthContextExpanded = false;
  WeightUnit _weightUnit = WeightUnit.kilograms;
  BodyMetricUnit _bodyMetricUnit = BodyMetricUnit.centimeters;
  ActivityLevel _activityLevel = ActivityLevel.moderatelyActive;
  GoalType _goalType = GoalType.maintain;
  int _checkInCadenceHours = 8;
  static const _unitConverter = UnitConverter();
  static const _baselineService = BodyBaselineService();
  static const _goalRecommendationService = GoalRecommendationService();

  @override
  void dispose() {
    _nameController.dispose();
    _conditionsController.dispose();
    _medicationsController.dispose();
    _allergiesController.dispose();
    _notesController.dispose();
    _currentWeightController.dispose();
    _goalWeightController.dispose();
    _heightController.dispose();
    _waistController.dispose();
    _bodyFatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(currentUserProfileProvider);
    final healthProfileAsync = ref.watch(healthProfileProvider);
    final activeGoalAsync = ref.watch(activeGoalProvider);
    final selectedThemeMode =
        ref.watch(themeModePreferenceProvider).valueOrNull ?? ThemeMode.system;
    final selectedLanguage =
        ref.watch(languagePreferenceProvider).valueOrNull ??
        AppLanguage.english;

    return AppScaffold(
      title: 'Onboarding',
      eyebrow: 'Forge',
      subtitle:
          'Set your units and health context so Forge can keep logs local-first and surface better cautions during training and nutrition.',
      showHeader: true,
      child: profileAsync.when(
        data: (profile) {
          final healthProfile = healthProfileAsync.valueOrNull;
          if (!_initialized) {
            _initialized = true;
            _nameController.text = profile?.displayName ?? '';
            _weightUnit = profile?.preferredWeightUnit ?? WeightUnit.kilograms;
            _bodyMetricUnit =
                profile?.preferredBodyMetricUnit ?? BodyMetricUnit.centimeters;
            _heightController.text = profile?.height == null
                ? ''
                : _formatDouble(profile!.height!.originalValue);
            _activityLevel =
                profile?.activityLevel ?? ActivityLevel.moderatelyActive;
            final activeGoal = activeGoalAsync.valueOrNull;
            _goalType = activeGoal?.type ?? GoalType.maintain;
            _goalWeightController.text = activeGoal?.targetWeight == null
                ? ''
                : _formatDouble(activeGoal!.targetWeight!.originalValue);
            _conditionsController.text =
                healthProfile?.healthConditions.join('\n') ?? '';
            _medicationsController.text =
                healthProfile?.medications.join('\n') ?? '';
            _allergiesController.text =
                healthProfile?.allergies.join('\n') ?? '';
            _notesController.text = healthProfile?.notes ?? '';
            _checkInCadenceHours = healthProfile?.checkInCadenceHours ?? 8;
            _healthContextExpanded =
                _conditionsController.text.trim().isNotEmpty ||
                _medicationsController.text.trim().isNotEmpty ||
                _allergiesController.text.trim().isNotEmpty ||
                _notesController.text.trim().isNotEmpty;
          }
          final goalRecommendation = _goalRecommendationService
              .recommendationFor(
                goalType: _goalType,
                activityLevel: _activityLevel,
              );

          return ListView(
            children: [
              AppPanel(
                gradient: AppColors.bluePanelGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Setup',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<WeightUnit>(
                            initialValue: _weightUnit,
                            decoration: const InputDecoration(
                              labelText: 'Weight unit',
                            ),
                            items: WeightUnit.values
                                .map(
                                  (unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit.symbol),
                                  ),
                                )
                                .toList(growable: false),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() => _weightUnit = value);
                            },
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: DropdownButtonFormField<BodyMetricUnit>(
                            initialValue: _bodyMetricUnit,
                            decoration: const InputDecoration(
                              labelText: 'Body metric unit',
                            ),
                            items: BodyMetricUnit.values
                                .map(
                                  (unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit.symbol),
                                  ),
                                )
                                .toList(growable: false),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() => _bodyMetricUnit = value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Preferences',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Choose how Forge should look while you set up. Arabic is saved as a preference now; full Arabic translation comes later.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SegmentedButton<ThemeMode>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.system,
                          icon: Icon(Icons.settings_suggest_outlined),
                          label: Text('System'),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.light,
                          icon: Icon(Icons.light_mode_outlined),
                          label: Text('Light'),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.dark,
                          icon: Icon(Icons.dark_mode_outlined),
                          label: Text('Dark'),
                        ),
                      ],
                      selected: {selectedThemeMode},
                      onSelectionChanged: (selection) {
                        ref
                            .read(themeModeControllerProvider)
                            .setThemeMode(selection.first);
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SegmentedButton<AppLanguage>(
                      showSelectedIcon: false,
                      segments: AppLanguage.values
                          .map(
                            (language) => ButtonSegment<AppLanguage>(
                              value: language,
                              icon: Icon(
                                language == AppLanguage.arabic
                                    ? Icons.translate_outlined
                                    : Icons.language_outlined,
                              ),
                              label: Text(language.label),
                            ),
                          )
                          .toList(growable: false),
                      selected: {selectedLanguage},
                      onSelectionChanged: (selection) {
                        ref
                            .read(languagePreferenceControllerProvider)
                            .setLanguage(selection.first);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppPanel(
                gradient: AppColors.orangePanelGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Starting Baseline',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'These numbers create your first progress checkpoint and help Forge calculate useful baselines like BMI and waist-to-height ratio.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _ResponsiveFields(
                      children: [
                        TextField(
                          controller: _currentWeightController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            labelText: 'Current weight (${_weightUnit.symbol})',
                          ),
                        ),
                        TextField(
                          controller: _goalWeightController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Goal weight (${_weightUnit.symbol})',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _ResponsiveFields(
                      children: [
                        TextField(
                          controller: _heightController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            labelText: 'Height (${_bodyMetricUnit.symbol})',
                          ),
                        ),
                        TextField(
                          controller: _waistController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            labelText:
                                'Waist (${_bodyMetricUnit.symbol}, optional)',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _ResponsiveFields(
                      children: [
                        TextField(
                          controller: _bodyFatController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Body fat % (optional)',
                          ),
                        ),
                        DropdownButtonFormField<ActivityLevel>(
                          initialValue: _activityLevel,
                          decoration: const InputDecoration(
                            labelText: 'Activity level',
                          ),
                          items: ActivityLevel.values
                              .map(
                                (level) => DropdownMenuItem(
                                  value: level,
                                  child: Text(level.label),
                                ),
                              )
                              .toList(growable: false),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() => _activityLevel = value);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DropdownButtonFormField<GoalType>(
                      initialValue: _goalType,
                      decoration: const InputDecoration(labelText: 'Goal type'),
                      items: GoalType.values
                          .map(
                            (goalType) => DropdownMenuItem(
                              value: goalType,
                              child: Text(goalTypeLabel(goalType)),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() => _goalType = value);
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _GoalPlanPreview(recommendation: goalRecommendation),
                    const SizedBox(height: AppSpacing.md),
                    _BaselinePreview(
                      metrics: _calculateBaselinePreview(),
                      activityLevel: _activityLevel,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppPanel(
                gradient: AppColors.greenPanelGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => setState(
                        () => _healthContextExpanded = !_healthContextExpanded,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.xs,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Health Context (optional)',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    _healthContextExpanded
                                        ? 'Add cautions if they matter for training or food choices.'
                                        : 'Tap to add conditions, medications, allergies, and check-in cadence.',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              _healthContextExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'This is for caution flags and logging context, not a diagnosis engine.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _conditionsController,
                            minLines: 2,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              labelText: 'Health issues / conditions',
                              helperText: 'One per line or comma-separated',
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _medicationsController,
                            minLines: 2,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              labelText: 'Medications',
                              helperText: 'One per line or comma-separated',
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _allergiesController,
                            minLines: 2,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              labelText: 'Allergies',
                              helperText: 'One per line or comma-separated',
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          DropdownButtonFormField<int>(
                            initialValue: _checkInCadenceHours,
                            decoration: const InputDecoration(
                              labelText: 'Health check cadence',
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
                              setState(() => _checkInCadenceHours = value);
                            },
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _notesController,
                            minLines: 2,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              labelText: 'Important notes',
                            ),
                          ),
                        ],
                      ),
                      crossFadeState: _healthContextExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 180),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: _saving
                    ? null
                    : () => _handleSave(
                        existingProfile: profile,
                        existingGoal: activeGoalAsync.valueOrNull,
                      ),
                child: Text(_saving ? 'Saving...' : 'Save and Enter Forge'),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> _handleSave({
    required UserProfile? existingProfile,
    required Goal? existingGoal,
  }) async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter your name to continue.')),
      );
      return;
    }
    final currentWeight = _tryParseNullable(_currentWeightController.text);
    final goalWeight = _tryParseNullable(_goalWeightController.text);
    final height = _tryParseNullable(_heightController.text);
    final waist = _tryParseNullable(_waistController.text);
    final bodyFat = _tryParseNullable(_bodyFatController.text);
    if (_hasNonPositive(currentWeight, goalWeight, height, waist) ||
        (bodyFat != null && (bodyFat <= 0 || bodyFat > 100))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check your baseline numbers.')),
      );
      return;
    }

    setState(() => _saving = true);
    final now = DateTime.now();
    final uuid = const UuidService();
    final profile = UserProfile(
      id: existingProfile?.id ?? 'user-${uuid.next()}',
      displayName: _nameController.text.trim(),
      preferredWeightUnit: _weightUnit,
      preferredBodyMetricUnit: _bodyMetricUnit,
      height: height == null
          ? existingProfile?.height
          : MeasurementValue(
              originalValue: height,
              originalUnit: _bodyMetricUnit,
              canonicalCentimeters: _unitConverter.toCentimeters(
                height,
                _bodyMetricUnit,
              ),
            ),
      activityLevel: _activityLevel,
      createdAt: existingProfile?.createdAt ?? now,
      updatedAt: now,
    );

    await ref.read(profileRepositoryProvider).saveProfile(profile);
    if (currentWeight != null || waist != null || bodyFat != null) {
      await ref
          .read(bodyMetricsControllerProvider)
          .saveBodyLog(
            weightValue: currentWeight,
            weightUnit: currentWeight == null ? null : _weightUnit,
            waistValue: waist,
            waistUnit: waist == null ? null : _bodyMetricUnit,
            bodyFatPercentage: bodyFat,
            notes: 'Starting baseline from onboarding',
            loggedAt: now,
          );
    }
    if (goalWeight != null) {
      await ref
          .read(goalRepositoryProvider)
          .saveGoal(
            Goal(
              id: existingGoal?.id ?? 'goal-${uuid.next()}',
              type: _goalType,
              title: existingGoal?.title ?? 'Starting target',
              targetWeight: WeightValue(
                originalValue: goalWeight,
                originalUnit: _weightUnit,
                canonicalKilograms: _unitConverter.toKilograms(
                  goalWeight,
                  _weightUnit,
                ),
              ),
              macroTarget:
                  existingGoal?.macroTarget ??
                  const MacroTarget(
                    calories: 0,
                    proteinGrams: 0,
                    carbsGrams: 0,
                    fatGrams: 0,
                  ),
              isActive: true,
              startedAt: existingGoal?.startedAt ?? now,
              endedAt: existingGoal?.endedAt,
              createdAt: existingGoal?.createdAt ?? now,
              updatedAt: now,
            ),
          );
      ref.invalidate(activeGoalProvider);
    }
    await _saveRecommendedTemplate(goalType: _goalType, now: now);
    ref.invalidate(currentUserProfileProvider);
    ref.invalidate(hasCompletedOnboardingProvider);
    await ref
        .read(healthTrackingControllerProvider)
        .saveHealthProfile(
          existingProfile: ref.read(healthProfileProvider).valueOrNull,
          healthConditions: _conditionsController.text,
          medications: _medicationsController.text,
          allergies: _allergiesController.text,
          notes: _notesController.text,
          checkInCadenceHours: _checkInCadenceHours,
        );

    if (!mounted) {
      return;
    }

    setState(() => _saving = false);
    context.goNamed(RouteNames.home);
  }

  Future<void> _saveRecommendedTemplate({
    required GoalType goalType,
    required DateTime now,
  }) async {
    final recommendation = _goalRecommendationService.recommendationFor(
      goalType: goalType,
      activityLevel: _activityLevel,
    );
    final repository = ref.read(workoutRepositoryProvider);
    final templateId = 'goal-preset-${goalType.name}';
    final existingTemplate = await repository.getTemplate(templateId);
    final createdAt = existingTemplate?.createdAt ?? now;

    await repository.saveTemplate(
      WorkoutTemplate(
        id: templateId,
        name: recommendation.templateName,
        notes: recommendation.templateNotes,
        createdAt: createdAt,
        updatedAt: now,
      ),
    );
    await repository.replaceTemplateItems(
      templateId,
      recommendation.exercises
          .asMap()
          .entries
          .map(
            (entry) => WorkoutTemplateItem(
              id: 'goal-preset-${goalType.name}-${entry.value.exerciseId}',
              templateId: templateId,
              exerciseId: entry.value.exerciseId,
              orderIndex: entry.key,
              targetSets: entry.value.sets,
              targetReps: entry.value.reps,
              notes: entry.value.notes,
              createdAt: createdAt,
              updatedAt: now,
            ),
          )
          .toList(growable: false),
    );
    ref.invalidate(workoutTemplatesProvider);
  }

  BodyBaselineMetrics _calculateBaselinePreview() {
    final currentWeight = _tryParseNullable(_currentWeightController.text);
    final height = _tryParseNullable(_heightController.text);
    final waist = _tryParseNullable(_waistController.text);

    return _baselineService.calculate(
      weightKilograms: currentWeight == null
          ? null
          : _unitConverter.toKilograms(currentWeight, _weightUnit),
      heightCentimeters: height == null
          ? null
          : _unitConverter.toCentimeters(height, _bodyMetricUnit),
      waistCentimeters: waist == null
          ? null
          : _unitConverter.toCentimeters(waist, _bodyMetricUnit),
    );
  }
}

class _ResponsiveFields extends StatelessWidget {
  const _ResponsiveFields({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 420) {
          return Column(
            children: [
              for (var index = 0; index < children.length; index++) ...[
                children[index],
                if (index != children.length - 1)
                  const SizedBox(height: AppSpacing.md),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (var index = 0; index < children.length; index++) ...[
              Expanded(child: children[index]),
              if (index != children.length - 1)
                const SizedBox(width: AppSpacing.md),
            ],
          ],
        );
      },
    );
  }
}

class _BaselinePreview extends StatelessWidget {
  const _BaselinePreview({required this.metrics, required this.activityLevel});

  final BodyBaselineMetrics metrics;
  final ActivityLevel activityLevel;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final bmiAccent = _bmiAccent(metrics.bmi);
    final waistAccent = _waistAccent(metrics.waistToHeightRatio);
    final activityAccent = _activityAccent(activityLevel);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.softFillFor(brightness),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.ghostOutlineFor(brightness)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.electricBlue.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.speed_outlined, size: 20),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Baseline Preview',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _PreviewGauge(
            icon: Icons.monitor_weight_outlined,
            label: 'BMI',
            value: metrics.bmi == null
                ? 'Add weight + height'
                : '${metrics.bmi!.toStringAsFixed(1)} | ${metrics.bmiLabel}',
            progress: _bmiProgress(metrics.bmi),
            accent: bmiAccent,
          ),
          const SizedBox(height: AppSpacing.sm),
          _PreviewGauge(
            icon: Icons.straighten_outlined,
            label: 'Waist / height',
            value: metrics.waistToHeightRatio == null
                ? 'Optional: add waist + height'
                : '${metrics.waistToHeightRatio!.toStringAsFixed(2)} | ${metrics.waistToHeightLabel}',
            progress: _waistProgress(metrics.waistToHeightRatio),
            accent: waistAccent,
          ),
          const SizedBox(height: AppSpacing.sm),
          _PreviewGauge(
            icon: Icons.local_fire_department_outlined,
            label: 'Activity',
            value: activityLevel.description,
            progress: _activityProgress(activityLevel),
            accent: activityAccent,
          ),
        ],
      ),
    );
  }
}

class _GoalPlanPreview extends StatelessWidget {
  const _GoalPlanPreview({required this.recommendation});

  final GoalRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.electricBlue.withValues(alpha: 0.22),
            AppColors.neonGreen.withValues(alpha: 0.13),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.ghostOutlineFor(brightness)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.neonGreen.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.auto_awesome_outlined, size: 20),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  recommendation.headline,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _PlanLine(
            icon: Icons.restaurant_menu_outlined,
            label: 'Diet focus',
            value: recommendation.dietFocus,
          ),
          const SizedBox(height: AppSpacing.sm),
          _PlanLine(
            icon: Icons.fitness_center_outlined,
            label: 'Workout preset',
            value:
                '${recommendation.templateName}: ${recommendation.trainingFocus}',
          ),
        ],
      ),
    );
  }
}

class _PlanLine extends StatelessWidget {
  const _PlanLine({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.electricBlue),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800),
                ),
                TextSpan(text: value),
              ],
            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _PreviewGauge extends StatelessWidget {
  const _PreviewGauge({
    required this.icon,
    required this.label,
    required this.value,
    required this.progress,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final String value;
  final double progress;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.glassFor(brightness),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const Icon(Icons.arrow_forward, size: 14),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(value, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: AppColors.progressTrackFor(brightness),
                    valueColor: AlwaysStoppedAnimation<Color>(accent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color _bmiAccent(double? bmi) {
  if (bmi == null) {
    return AppColors.electricBlue;
  }
  if (bmi >= 18.5 && bmi < 25) {
    return AppColors.neonGreen;
  }
  if (bmi < 30) {
    return AppColors.vividOrange;
  }
  return AppColors.crimson;
}

Color _waistAccent(double? ratio) {
  if (ratio == null) {
    return AppColors.electricBlue;
  }
  if (ratio < 0.50) {
    return AppColors.neonGreen;
  }
  if (ratio < 0.60) {
    return AppColors.vividOrange;
  }
  return AppColors.crimson;
}

Color _activityAccent(ActivityLevel activityLevel) {
  return switch (activityLevel) {
    ActivityLevel.sedentary => AppColors.vividOrange,
    ActivityLevel.lightlyActive => AppColors.electricBlue,
    ActivityLevel.moderatelyActive => AppColors.neonGreen,
    ActivityLevel.veryActive || ActivityLevel.athlete => AppColors.crimson,
  };
}

double _bmiProgress(double? bmi) {
  if (bmi == null) {
    return 0.08;
  }
  return (bmi / 40).clamp(0.05, 1).toDouble();
}

double _waistProgress(double? ratio) {
  if (ratio == null) {
    return 0.08;
  }
  return (ratio / 0.70).clamp(0.05, 1).toDouble();
}

double _activityProgress(ActivityLevel activityLevel) {
  final index = ActivityLevel.values.indexOf(activityLevel) + 1;
  return index / ActivityLevel.values.length;
}

double? _tryParseNullable(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return null;
  }
  return double.tryParse(trimmed);
}

bool _hasNonPositive(
  double? first,
  double? second,
  double? third,
  double? fourth,
) {
  return [
    first,
    second,
    third,
    fourth,
  ].any((value) => value != null && value <= 0);
}

String _formatDouble(double value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(1);
}

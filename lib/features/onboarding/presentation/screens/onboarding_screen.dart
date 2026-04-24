import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/profile_providers.dart';
import 'package:forge/domain/entities/user_profile.dart';
import 'package:forge/features/health/presentation/controllers/health_overview_controller.dart';
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';
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
  bool _initialized = false;
  bool _saving = false;
  WeightUnit _weightUnit = WeightUnit.kilograms;
  BodyMetricUnit _bodyMetricUnit = BodyMetricUnit.centimeters;
  int _checkInCadenceHours = 8;

  @override
  void dispose() {
    _nameController.dispose();
    _conditionsController.dispose();
    _medicationsController.dispose();
    _allergiesController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(currentUserProfileProvider);
    final healthProfileAsync = ref.watch(healthProfileProvider);

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
            _conditionsController.text =
                healthProfile?.healthConditions.join('\n') ?? '';
            _medicationsController.text =
                healthProfile?.medications.join('\n') ?? '';
            _allergiesController.text =
                healthProfile?.allergies.join('\n') ?? '';
            _notesController.text = healthProfile?.notes ?? '';
            _checkInCadenceHours = healthProfile?.checkInCadenceHours ?? 8;
          }

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
                gradient: AppColors.greenPanelGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Health Context',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
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
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: _saving ? null : () => _handleSave(profile),
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

  Future<void> _handleSave(UserProfile? existingProfile) async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter your name to continue.')),
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
      createdAt: existingProfile?.createdAt ?? now,
      updatedAt: now,
    );

    await ref.read(profileRepositoryProvider).saveProfile(profile);
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
}

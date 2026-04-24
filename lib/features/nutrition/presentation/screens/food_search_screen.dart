import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_search_field.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/health_providers.dart';
import 'package:forge/features/health/presentation/controllers/health_overview_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/food_search_controller.dart';
import 'package:forge/features/nutrition/presentation/widgets/nutrition_formatters.dart';
import 'package:go_router/go_router.dart';

class FoodSearchScreen extends ConsumerStatefulWidget {
  const FoodSearchScreen({this.initialMealType, super.key});

  final String? initialMealType;

  @override
  ConsumerState<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends ConsumerState<FoodSearchScreen> {
  late final TextEditingController _queryController;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resultsAsync = ref.watch(foodSearchResultsProvider);
    final healthOverview = ref.watch(healthOverviewProvider);
    final cautionService = ref.watch(healthCautionServiceProvider);

    return AppScaffold(
      title: 'Log Food',
      subtitle:
          'Search your local cache first, then bring in assistive remote results you can correct and trust locally.',
      child: Column(
        children: [
          AppPanel(
            gradient: AppColors.greenPanelGradient,
            child: Column(
              children: [
                AppSearchField(
                  controller: _queryController,
                  hintText: 'Search foods, brands, or scan a barcode',
                  onChanged: (value) =>
                      ref.read(foodSearchQueryProvider.notifier).state = value,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => context.pushNamed(
                          RouteNames.barcodeLookup,
                          queryParameters: {
                            if (widget.initialMealType != null)
                              'mealType': widget.initialMealType!,
                          },
                        ),
                        icon: const Icon(Icons.qr_code_scanner),
                        label: const Text('Barcode'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => context.pushNamed(
                          RouteNames.foodEditor,
                          queryParameters: {
                            if (widget.initialMealType != null)
                              'mealType': widget.initialMealType!,
                          },
                        ),
                        child: const Text('Create Food'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: resultsAsync.when(
              data: (foods) {
                if (foods.isEmpty) {
                  return Center(
                    child: AppPanel(
                      child: AppEmptyState(
                        icon: Icons.restaurant_menu_outlined,
                        title: 'No food matches yet',
                        message:
                            'Try a barcode scan or create a trusted local food entry.',
                        action: FilledButton.tonal(
                          onPressed: () => context.pushNamed(
                            RouteNames.barcodeLookup,
                            queryParameters: {
                              if (widget.initialMealType != null)
                                'mealType': widget.initialMealType!,
                            },
                          ),
                          child: const Text('Try Barcode'),
                        ),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final detail = foods[index];
                    final guidance = cautionService.evaluateFood(
                      foodName: detail.food.name,
                      profile: healthOverview.profile,
                      activeLogs: healthOverview.activeLogs,
                    );
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: AppPanel(
                        gradient: index.isEven
                            ? AppColors.greenPanelGradient
                            : null,
                        onTap: () => context.pushNamed(
                          RouteNames.mealLog,
                          queryParameters: {
                            'foodId': detail.food.id,
                            if (widget.initialMealType != null)
                              'mealType': widget.initialMealType!,
                          },
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detail.food.name,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    NutritionFormatters.foodSubtitle(detail),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  if (guidance.hasAnySignals) ...[
                                    const SizedBox(height: AppSpacing.sm),
                                    if (guidance.alerts.isNotEmpty)
                                      ...guidance.alerts.map(
                                        (alert) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: AppSpacing.xxs,
                                          ),
                                          child: Text(
                                            '${alert.title}: ${alert.message}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: AppColors.crimson,
                                                ),
                                          ),
                                        ),
                                      ),
                                    if (guidance.supportiveNotes.isNotEmpty)
                                      ...guidance.supportiveNotes.map(
                                        (note) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: AppSpacing.xxs,
                                          ),
                                          child: Text(
                                            note,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: AppColors.neonGreen,
                                                ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${detail.food.caloriesPer100g}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge,
                                ),
                                Text(
                                  'kcal',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined),
                                  onPressed: () => context.pushNamed(
                                    RouteNames.foodEditor,
                                    queryParameters: {
                                      'foodId': detail.food.id,
                                      if (widget.initialMealType != null)
                                        'mealType': widget.initialMealType!,
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) => Center(
                child: AppPanel(
                  child: AppErrorState(message: error.toString()),
                ),
              ),
              loading: () => const AppLoadingView(label: 'Searching foods'),
            ),
          ),
        ],
      ),
    );
  }
}

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
                            _FoodPicture(foodName: detail.food.name),
                            const SizedBox(width: AppSpacing.md),
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

class _FoodPicture extends StatelessWidget {
  const _FoodPicture({required this.foodName});

  final String foodName;

  @override
  Widget build(BuildContext context) {
    final visual = _FoodVisual.fromName(foodName);

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            visual.color.withValues(alpha: 0.95),
            visual.color.withValues(alpha: 0.45),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: visual.color.withValues(alpha: 0.22),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -12,
            child: Icon(
              visual.backgroundIcon,
              size: 58,
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
          Center(
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.18),
              ),
              child: Icon(visual.icon, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodVisual {
  const _FoodVisual({
    required this.icon,
    required this.backgroundIcon,
    required this.color,
  });

  final IconData icon;
  final IconData backgroundIcon;
  final Color color;

  static _FoodVisual fromName(String name) {
    final normalized = name.toLowerCase();

    if (_containsAny(normalized, ['banana', 'fruit', 'apple', 'berries'])) {
      return const _FoodVisual(
        icon: Icons.eco_outlined,
        backgroundIcon: Icons.local_florist_outlined,
        color: Color(0xFFF2B84B),
      );
    }
    if (_containsAny(normalized, [
      'broccoli',
      'vegetable',
      'salad',
      'greens',
    ])) {
      return const _FoodVisual(
        icon: Icons.grass_outlined,
        backgroundIcon: Icons.spa_outlined,
        color: Color(0xFF21A67A),
      );
    }
    if (_containsAny(normalized, [
      'chicken',
      'beef',
      'tuna',
      'salmon',
      'fish',
    ])) {
      return const _FoodVisual(
        icon: Icons.restaurant_outlined,
        backgroundIcon: Icons.dinner_dining_outlined,
        color: Color(0xFFE36C61),
      );
    }
    if (_containsAny(normalized, [
      'rice',
      'oats',
      'potato',
      'bread',
      'pasta',
    ])) {
      return const _FoodVisual(
        icon: Icons.rice_bowl_outlined,
        backgroundIcon: Icons.bakery_dining_outlined,
        color: Color(0xFF7C9BFF),
      );
    }
    if (_containsAny(normalized, [
      'egg',
      'yogurt',
      'milk',
      'whey',
      'protein',
    ])) {
      return const _FoodVisual(
        icon: Icons.egg_alt_outlined,
        backgroundIcon: Icons.fitness_center_outlined,
        color: Color(0xFF9A7CFF),
      );
    }
    if (_containsAny(normalized, ['oil', 'avocado', 'nuts', 'butter'])) {
      return const _FoodVisual(
        icon: Icons.opacity_outlined,
        backgroundIcon: Icons.water_drop_outlined,
        color: Color(0xFFD9A441),
      );
    }

    return const _FoodVisual(
      icon: Icons.restaurant_menu_outlined,
      backgroundIcon: Icons.fastfood_outlined,
      color: Color(0xFF2F80ED),
    );
  }

  static bool _containsAny(String value, List<String> needles) {
    return needles.any(value.contains);
  }
}

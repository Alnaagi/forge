import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/application/providers/nutrition_providers.dart';
import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/domain/entities/meal_entry.dart';
import 'package:forge/features/nutrition/presentation/controllers/meal_log_controller.dart';
import 'package:forge/features/nutrition/presentation/widgets/nutrition_formatters.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:forge/shared/enums/meal_type.dart';
import 'package:go_router/go_router.dart';

class MealLogScreen extends ConsumerStatefulWidget {
  const MealLogScreen({
    this.foodId,
    this.mealEntryId,
    this.initialMealTypeName,
    super.key,
  }) : assert(
         foodId != null || mealEntryId != null,
         'Either foodId or mealEntryId is required.',
       );

  final String? foodId;
  final String? mealEntryId;
  final String? initialMealTypeName;

  @override
  ConsumerState<MealLogScreen> createState() => _MealLogScreenState();
}

class _MealLogScreenState extends ConsumerState<MealLogScreen> {
  late final Future<_MealLogInitialData?> _initialDataFuture;
  final _quantityController = TextEditingController(text: '1');
  final _notesController = TextEditingController();
  MealType _mealType = MealType.breakfast;
  FoodQuantityUnit _quantityUnit = FoodQuantityUnit.grams;
  bool _isSaving = false;
  bool _didSeedForm = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialMealTypeName != null) {
      _mealType = MealType.values.firstWhere(
        (value) => value.name == widget.initialMealTypeName,
        orElse: () => MealType.breakfast,
      );
    }
    _initialDataFuture = _loadInitialData();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.mealEntryId == null ? 'Log Meal' : 'Edit Meal',
      eyebrow: 'Nutrition',
      subtitle:
          'Quick quantity logging with original quantity preserved and canonical values resolved underneath.',
      child: FutureBuilder<_MealLogInitialData?>(
        future: _initialDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppErrorState(message: snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingView(label: 'Loading meal details');
          }

          final initialData = snapshot.data;
          if (initialData == null) {
            return const AppPanel(
              child: AppEmptyState(
                icon: Icons.search_off,
                title: 'Meal not found',
                message:
                    'This food may have been removed or not saved locally yet.',
              ),
            );
          }
          final detail = initialData.foodDetail;

          final availableUnits = <FoodQuantityUnit>[
            FoodQuantityUnit.grams,
            if (detail.portions.any(
              (portion) => portion.unit == FoodQuantityUnit.milliliters,
            ))
              FoodQuantityUnit.milliliters,
            if (detail.portions.any(
              (portion) => portion.unit == FoodQuantityUnit.serving,
            ))
              FoodQuantityUnit.serving,
            if (detail.portions.any(
              (portion) => portion.unit == FoodQuantityUnit.slice,
            ))
              FoodQuantityUnit.slice,
            if (detail.portions.any(
              (portion) => portion.unit == FoodQuantityUnit.unit,
            ))
              FoodQuantityUnit.unit,
          ];

          if (!availableUnits.contains(_quantityUnit)) {
            _quantityUnit = availableUnits.first;
          }
          if (!_didSeedForm) {
            final existingEntry = initialData.existingEntry;
            if (existingEntry != null) {
              _mealType = existingEntry.mealType;
              _quantityUnit = existingEntry.quantity.originalUnit;
              _quantityController.text = existingEntry.quantity.originalValue
                  .toStringAsFixed(
                    existingEntry.quantity.originalValue ==
                            existingEntry.quantity.originalValue.roundToDouble()
                        ? 0
                        : 1,
                  );
              _notesController.text = existingEntry.notes ?? '';
            }
            _didSeedForm = true;
          }

          return ListView(
            children: [
              AppPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.food.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      NutritionFormatters.foodSubtitle(detail),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meal slot',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: MealType.values
                          .map(
                            (mealType) => ChoiceChip(
                              label: Text(mealType.name),
                              selected: _mealType == mealType,
                              onSelected: (_) =>
                                  setState(() => _mealType = mealType),
                            ),
                          )
                          .toList(growable: false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantity',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _quantityController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Amount',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<FoodQuantityUnit>(
                            initialValue: _quantityUnit,
                            decoration: const InputDecoration(
                              labelText: 'Unit',
                            ),
                            items: availableUnits
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
                              setState(() => _quantityUnit = value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [1, 2, 3]
                          .map(
                            (value) => ActionChip(
                              label: Text('$value ${_quantityUnit.symbol}'),
                              onPressed: () {
                                _quantityController.text = value.toString();
                              },
                            ),
                          )
                          .toList(growable: false),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _notesController,
                      decoration: const InputDecoration(labelText: 'Notes'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _isSaving ? null : () => _handleSave(detail),
                child: Text(
                  _isSaving
                      ? 'Saving...'
                      : widget.mealEntryId == null
                      ? 'Log Food'
                      : 'Save Changes',
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<_MealLogInitialData?> _loadInitialData() async {
    final repository = ref.read(nutritionRepositoryProvider);

    if (widget.mealEntryId != null) {
      final mealEntryDetail = await repository.getMealEntryDetail(
        widget.mealEntryId!,
      );
      if (mealEntryDetail == null) {
        return null;
      }
      final foodDetail = await repository.getFoodDetail(
        mealEntryDetail.food.id,
      );
      if (foodDetail == null) {
        return null;
      }
      return _MealLogInitialData(
        foodDetail: foodDetail,
        existingEntry: mealEntryDetail.entry,
      );
    }

    final foodDetail = await repository.getFoodDetail(widget.foodId!);
    if (foodDetail == null) {
      return null;
    }
    return _MealLogInitialData(foodDetail: foodDetail);
  }

  Future<void> _handleSave(FoodDetail detail) async {
    final quantityValue = double.tryParse(_quantityController.text.trim());
    if (quantityValue == null || quantityValue <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter a valid quantity.')));
      return;
    }

    setState(() => _isSaving = true);
    try {
      final controller = ref.read(mealLogControllerProvider);
      final existingEntry = (await _initialDataFuture)?.existingEntry;
      if (existingEntry == null) {
        await controller.logFood(
          foodDetail: detail,
          mealType: _mealType,
          quantityValue: quantityValue,
          quantityUnit: _quantityUnit,
          notes: _notesController.text,
        );
      } else {
        await controller.updateMealEntry(
          existingEntry: existingEntry,
          foodDetail: detail,
          mealType: _mealType,
          quantityValue: quantityValue,
          quantityUnit: _quantityUnit,
          notes: _notesController.text,
        );
      }
    } on StateError catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.message)));
      setState(() => _isSaving = false);
      return;
    }
    setState(() => _isSaving = false);

    if (!mounted) {
      return;
    }
    context.pop();
  }
}

class _MealLogInitialData {
  const _MealLogInitialData({required this.foodDetail, this.existingEntry});

  final FoodDetail foodDetail;
  final MealEntry? existingEntry;
}

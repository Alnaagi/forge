import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/application/providers/nutrition_providers.dart';
import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/features/nutrition/presentation/controllers/food_editor_controller.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:go_router/go_router.dart';

class FoodEditorScreen extends ConsumerStatefulWidget {
  const FoodEditorScreen({
    this.foodId,
    this.initialBarcode,
    this.mealTypeName,
    super.key,
  });

  final String? foodId;
  final String? initialBarcode;
  final String? mealTypeName;

  @override
  ConsumerState<FoodEditorScreen> createState() => _FoodEditorScreenState();
}

class _FoodEditorScreenState extends ConsumerState<FoodEditorScreen> {
  late final Future<FoodDetail?> _initialDetail;
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  final _servingController = TextEditingController();
  final _sliceController = TextEditingController();
  final _unitController = TextEditingController();
  final _milliliterController = TextEditingController();
  bool _initialized = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _initialDetail = widget.foodId == null
        ? Future.value(null)
        : ref.read(nutritionRepositoryProvider).getFoodDetail(widget.foodId!);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _barcodeController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _servingController.dispose();
    _sliceController.dispose();
    _unitController.dispose();
    _milliliterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.foodId == null ? 'Create Food' : 'Edit Food',
      eyebrow: 'Nutrition',
      subtitle:
          'Correct remote data or build trusted local foods with portion definitions for quick logging later.',
      child: FutureBuilder<FoodDetail?>(
        future: _initialDetail,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppErrorState(message: snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingView(label: 'Loading food editor');
          }

          final detail = snapshot.data;
          if (!_initialized) {
            _initialized = true;
            _barcodeController.text =
                widget.initialBarcode ?? detail?.food.barcode ?? '';
            _nameController.text = detail?.food.name ?? '';
            _brandController.text = detail?.food.brandName ?? '';
            _caloriesController.text = detail == null
                ? ''
                : detail.food.caloriesPer100g.toString();
            _proteinController.text = detail == null
                ? ''
                : detail.food.proteinPer100g.toString();
            _carbsController.text = detail == null
                ? ''
                : detail.food.carbsPer100g.toString();
            _fatController.text = detail == null
                ? ''
                : detail.food.fatPer100g.toString();

            for (final portion in detail?.portions ?? const []) {
              switch (portion.unit) {
                case FoodQuantityUnit.serving:
                  _servingController.text =
                      portion.canonicalGrams?.toString() ?? '';
                  break;
                case FoodQuantityUnit.slice:
                  _sliceController.text =
                      portion.canonicalGrams?.toString() ?? '';
                  break;
                case FoodQuantityUnit.unit:
                  _unitController.text =
                      portion.canonicalGrams?.toString() ?? '';
                  break;
                case FoodQuantityUnit.milliliters:
                  _milliliterController.text =
                      portion.canonicalGrams?.toString() ?? '';
                  break;
                case FoodQuantityUnit.grams:
                  break;
              }
            }
          }

          return ListView(
            children: [
              AppPanel(
                gradient: AppColors.bluePanelGradient,
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Food name'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _brandController,
                      decoration: const InputDecoration(labelText: 'Brand'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _barcodeController,
                      decoration: const InputDecoration(labelText: 'Barcode'),
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
                      'Macros per 100 g',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _NumberField(
                          controller: _caloriesController,
                          label: 'Calories',
                        ),
                        _NumberField(
                          controller: _proteinController,
                          label: 'Protein',
                        ),
                        _NumberField(
                          controller: _carbsController,
                          label: 'Carbs',
                        ),
                        _NumberField(controller: _fatController, label: 'Fat'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppPanel(
                gradient: AppColors.greenPanelGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Portion Definitions',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Optional local conversions for servings, slices, units, and milliliters.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _NumberField(
                          controller: _servingController,
                          label: 'g per serving',
                        ),
                        _NumberField(
                          controller: _sliceController,
                          label: 'g per slice',
                        ),
                        _NumberField(
                          controller: _unitController,
                          label: 'g per unit',
                        ),
                        _NumberField(
                          controller: _milliliterController,
                          label: 'g per 1 ml',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _isSaving ? null : _handleSave,
                child: Text(_isSaving ? 'Saving...' : 'Save Food'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _handleSave() async {
    final calories = int.tryParse(_caloriesController.text.trim());
    final protein = double.tryParse(_proteinController.text.trim());
    final carbs = double.tryParse(_carbsController.text.trim());
    final fat = double.tryParse(_fatController.text.trim());

    if (_nameController.text.trim().isEmpty ||
        calories == null ||
        protein == null ||
        carbs == null ||
        fat == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a name and valid macro values.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    final detail = await ref
        .read(foodEditorControllerProvider)
        .save(
          foodId: widget.foodId,
          barcode: _barcodeController.text,
          name: _nameController.text,
          brandName: _brandController.text,
          caloriesPer100g: calories,
          proteinPer100g: protein,
          carbsPer100g: carbs,
          fatPer100g: fat,
          gramsPerServing: double.tryParse(_servingController.text.trim()),
          gramsPerSlice: double.tryParse(_sliceController.text.trim()),
          gramsPerUnit: double.tryParse(_unitController.text.trim()),
          gramsPerMilliliter: double.tryParse(
            _milliliterController.text.trim(),
          ),
        );
    setState(() => _isSaving = false);

    if (!mounted) {
      return;
    }

    if (widget.mealTypeName != null) {
      context.goNamed(
        RouteNames.mealLog,
        queryParameters: {
          'foodId': detail.food.id,
          'mealType': widget.mealTypeName!,
        },
      );
      return;
    }

    context.pop();
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

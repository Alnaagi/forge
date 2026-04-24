import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/nutrition_providers.dart';
import 'package:forge/domain/entities/food_detail.dart';
import 'package:forge/domain/entities/saved_meal_detail.dart';
import 'package:forge/domain/entities/saved_meal_item.dart';
import 'package:forge/features/nutrition/presentation/controllers/saved_meals_controller.dart';
import 'package:forge/shared/enums/food_quantity_unit.dart';
import 'package:go_router/go_router.dart';

class SavedMealEditorScreen extends ConsumerStatefulWidget {
  const SavedMealEditorScreen({required this.savedMealId, super.key});

  final String savedMealId;

  @override
  ConsumerState<SavedMealEditorScreen> createState() =>
      _SavedMealEditorScreenState();
}

class _SavedMealEditorScreenState extends ConsumerState<SavedMealEditorScreen> {
  late final Future<_SavedMealEditorData?> _initialDataFuture;
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  bool _didInitialize = false;
  bool _isSaving = false;
  List<_EditableSavedMealItem> _items = const [];

  @override
  void initState() {
    super.initState();
    _initialDataFuture = _loadInitialData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Edit Saved Meal',
      eyebrow: 'Nutrition',
      subtitle:
          'Tune the reusable meal template without losing your original quantity units underneath.',
      child: FutureBuilder<_SavedMealEditorData?>(
        future: _initialDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppErrorState(message: snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingView(label: 'Loading saved meal');
          }

          final data = snapshot.data;
          if (data == null) {
            return const AppPanel(
              child: AppEmptyState(
                icon: Icons.bookmark_remove_outlined,
                title: 'Saved meal not found',
                message: 'This saved meal may have been removed locally.',
              ),
            );
          }

          if (!_didInitialize) {
            _didInitialize = true;
            _nameController.text = data.detail.savedMeal.name;
            _notesController.text = data.detail.savedMeal.notes ?? '';
            _items = data.items;
          }

          return ListView(
            children: [
              AppPanel(
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Meal name'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _notesController,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        hintText: 'Optional note for this saved meal',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final entry in _items) ...[
                AppPanel(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.foodDetail.food.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              '${_formatAmount(entry.quantityValue)} ${entry.quantityUnit.symbol}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            if ((entry.notes ?? '').trim().isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                entry.notes!.trim(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Edit item',
                        onPressed: () => _editItem(entry),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                      IconButton(
                        tooltip: 'Remove item',
                        onPressed: () => _removeItem(entry),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: _isSaving ? null : () => _handleSave(data.detail),
                child: Text(_isSaving ? 'Saving...' : 'Save Saved Meal'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<_SavedMealEditorData?> _loadInitialData() async {
    final repository = ref.read(nutritionRepositoryProvider);
    final detail = await repository.getSavedMealDetail(widget.savedMealId);
    if (detail == null) {
      return null;
    }

    final items = <_EditableSavedMealItem>[];
    for (final savedItem in detail.items) {
      final foodDetail = await repository.getFoodDetail(savedItem.food.id);
      if (foodDetail == null) {
        continue;
      }
      items.add(
        _EditableSavedMealItem(
          itemId: savedItem.item.id,
          foodDetail: foodDetail,
          savedMealItem: savedItem.item,
          quantityValue: savedItem.item.quantity.originalValue,
          quantityUnit: savedItem.item.quantity.originalUnit,
          notes: savedItem.item.notes,
        ),
      );
    }

    return _SavedMealEditorData(detail: detail, items: items);
  }

  Future<void> _editItem(_EditableSavedMealItem item) async {
    final amountController = TextEditingController(
      text: _formatAmount(item.quantityValue),
    );
    final notesController = TextEditingController(text: item.notes ?? '');
    var selectedUnit = item.quantityUnit;
    final availableUnits = _availableUnits(item.foodDetail);

    final updated = await showDialog<_EditableSavedMealItem>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(item.foodDetail.food.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(labelText: 'Amount'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DropdownButtonFormField<FoodQuantityUnit>(
                    initialValue: selectedUnit,
                    decoration: const InputDecoration(labelText: 'Unit'),
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
                      setState(() => selectedUnit = value);
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: notesController,
                    minLines: 1,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Notes'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    final amount = double.tryParse(
                      amountController.text.trim(),
                    );
                    if (amount == null || amount <= 0) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(
                          content: Text('Enter a valid quantity.'),
                        ),
                      );
                      return;
                    }
                    Navigator.of(dialogContext).pop(
                      item.copyWith(
                        quantityValue: amount,
                        quantityUnit: selectedUnit,
                        notes: notesController.text.trim().isEmpty
                            ? null
                            : notesController.text.trim(),
                      ),
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    amountController.dispose();
    notesController.dispose();

    if (updated == null) {
      return;
    }

    setState(() {
      _items = [
        for (final current in _items)
          if (current.itemId == updated.itemId) updated else current,
      ];
    });
  }

  Future<void> _handleSave(SavedMealDetail existingDetail) async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a name for the saved meal.')),
      );
      return;
    }
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keep at least one item in the saved meal.'),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);
    await ref
        .read(savedMealsControllerProvider)
        .updateSavedMeal(
          existingSavedMeal: existingDetail.savedMeal,
          name: _nameController.text,
          notes: _notesController.text,
          items: _items
              .map(
                (item) => SavedMealItemDraft(
                  item: item.savedMealItem,
                  foodDetail: item.foodDetail,
                  quantityValue: item.quantityValue,
                  quantityUnit: item.quantityUnit,
                  notes: item.notes,
                ),
              )
              .toList(growable: false),
        );
    setState(() => _isSaving = false);

    if (!mounted) {
      return;
    }
    context.pop();
  }

  Future<void> _removeItem(_EditableSavedMealItem item) async {
    if (_items.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Delete the whole saved meal instead of removing the last item.',
          ),
        ),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove Saved Meal Item'),
          content: Text(
            'Remove ${item.foodDetail.food.name} from this saved meal?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
    if (confirmed != true) {
      return;
    }

    setState(() {
      _items = _items
          .where((current) => current.itemId != item.itemId)
          .toList(growable: false);
    });
  }

  List<FoodQuantityUnit> _availableUnits(FoodDetail detail) {
    return <FoodQuantityUnit>[
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
  }
}

class _SavedMealEditorData {
  const _SavedMealEditorData({required this.detail, required this.items});

  final SavedMealDetail detail;
  final List<_EditableSavedMealItem> items;
}

class _EditableSavedMealItem {
  const _EditableSavedMealItem({
    required this.itemId,
    required this.foodDetail,
    required this.savedMealItem,
    required this.quantityValue,
    required this.quantityUnit,
    this.notes,
  });

  final String itemId;
  final FoodDetail foodDetail;
  final SavedMealItem savedMealItem;
  final double quantityValue;
  final FoodQuantityUnit quantityUnit;
  final String? notes;

  _EditableSavedMealItem copyWith({
    double? quantityValue,
    FoodQuantityUnit? quantityUnit,
    Object? notes = _savedMealItemSentinel,
  }) {
    return _EditableSavedMealItem(
      itemId: itemId,
      foodDetail: foodDetail,
      savedMealItem: savedMealItem,
      quantityValue: quantityValue ?? this.quantityValue,
      quantityUnit: quantityUnit ?? this.quantityUnit,
      notes: identical(notes, _savedMealItemSentinel)
          ? this.notes
          : notes as String?,
    );
  }
}

const _savedMealItemSentinel = Object();

String _formatAmount(double value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(1);
}

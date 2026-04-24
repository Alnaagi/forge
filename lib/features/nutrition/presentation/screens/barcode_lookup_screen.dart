import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/app/core/widgets/app_search_field.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/features/nutrition/presentation/controllers/barcode_lookup_controller.dart';
import 'package:forge/features/nutrition/presentation/widgets/barcode_scanner_sheet.dart';
import 'package:forge/features/nutrition/presentation/widgets/nutrition_formatters.dart';
import 'package:go_router/go_router.dart';

class BarcodeLookupScreen extends ConsumerStatefulWidget {
  const BarcodeLookupScreen({this.initialMealType, super.key});

  final String? initialMealType;

  @override
  ConsumerState<BarcodeLookupScreen> createState() =>
      _BarcodeLookupScreenState();
}

class _BarcodeLookupScreenState extends ConsumerState<BarcodeLookupScreen> {
  late final TextEditingController _barcodeController;

  @override
  void initState() {
    super.initState();
    _barcodeController = TextEditingController();
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barcode = ref.watch(barcodeLookupQueryProvider);
    final resultAsync = ref.watch(barcodeLookupResultProvider);

    return AppScaffold(
      title: 'Barcode',
      subtitle:
          'Resolve local matches fast, then fall back to assistive remote lookup or trusted manual creation.',
      child: ListView(
        children: [
          AppPanel(
            gradient: AppColors.bluePanelGradient,
            child: Column(
              children: [
                AppSearchField(
                  controller: _barcodeController,
                  hintText: 'Enter or scan barcode',
                  onSubmitted: (_) => _lookup(),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _lookup,
                        icon: const Icon(Icons.qr_code),
                        label: const Text('Lookup Barcode'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _openScanner,
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text('Open Scanner'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          resultAsync.when(
            data: (detail) {
              if (barcode.trim().isEmpty) {
                return const AppPanel(
                  child: AppEmptyState(
                    icon: Icons.qr_code_scanner_outlined,
                    title: 'Ready to scan or type',
                    message:
                        'Enter a barcode to resolve a trusted local food, a cached barcode, or an assistive remote result.',
                  ),
                );
              }
              if (detail == null) {
                return AppPanel(
                  child: AppEmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: 'Barcode not found',
                    message:
                        'No local or assistive remote match found yet. Create a food once and Forge will remember this barcode locally.',
                    action: FilledButton(
                      onPressed: () => context.pushNamed(
                        RouteNames.foodEditor,
                        queryParameters: {
                          'barcode': barcode,
                          if (widget.initialMealType != null)
                            'mealType': widget.initialMealType!,
                        },
                      ),
                      child: const Text('Create Food For Barcode'),
                    ),
                  ),
                );
              }

              return AppPanel(
                gradient: AppColors.greenPanelGradient,
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
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            NutritionFormatters.foodSubtitle(detail),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              );
            },
            error: (error, stackTrace) =>
                AppPanel(child: AppErrorState(message: error.toString())),
            loading: () => barcode.trim().isEmpty
                ? const SizedBox.shrink()
                : const AppPanel(
                    child: SizedBox(
                      height: 120,
                      child: AppLoadingView(label: 'Resolving barcode'),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _lookup() {
    final submitted = ref
        .read(barcodeLookupControllerProvider)
        .submit(_barcodeController.text.trim());
    if (!submitted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid UPC/EAN barcode.')),
      );
    }
  }

  Future<void> _openScanner() async {
    final result = await showModalBottomSheet<BarcodeScannerResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const BarcodeScannerSheet(),
    );

    if (!mounted || result == null) {
      return;
    }

    switch (result.reason) {
      case BarcodeScannerDismissReason.scanned:
        final scannedValue = result.barcode ?? '';
        _barcodeController.text = scannedValue;
        final submitted = ref
            .read(barcodeLookupControllerProvider)
            .submit(scannedValue);
        if (!submitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('That scan did not produce a valid food barcode.'),
            ),
          );
        }
        break;
      case BarcodeScannerDismissReason.cancelled:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Scanner closed.')));
        break;
      case BarcodeScannerDismissReason.permissionDenied:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera permission was denied.')),
        );
        break;
      case BarcodeScannerDismissReason.unsupported:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Barcode scanning is not supported on this device.'),
          ),
        );
        break;
      case BarcodeScannerDismissReason.error:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Scanner error. Try entering the barcode manually.'),
          ),
        );
        break;
    }
  }
}

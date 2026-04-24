import 'package:flutter/material.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

enum BarcodeScannerDismissReason {
  scanned,
  cancelled,
  permissionDenied,
  unsupported,
  error,
}

class BarcodeScannerResult {
  const BarcodeScannerResult({required this.reason, this.barcode});

  final BarcodeScannerDismissReason reason;
  final String? barcode;
}

class BarcodeScannerSheet extends StatefulWidget {
  const BarcodeScannerSheet({super.key});

  @override
  State<BarcodeScannerSheet> createState() => _BarcodeScannerSheetState();
}

class _BarcodeScannerSheetState extends State<BarcodeScannerSheet> {
  late final MobileScannerController _controller;
  bool _hasClosed = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      autoZoom: true,
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: const [
        BarcodeFormat.ean13,
        BarcodeFormat.ean8,
        BarcodeFormat.upcA,
        BarcodeFormat.upcE,
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.lg,
        ),
        child: AppPanel(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.72,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Scan Barcode',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _close(
                        const BarcodeScannerResult(
                          reason: BarcodeScannerDismissReason.cancelled,
                        ),
                      ),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Point the camera at a UPC or EAN code.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: MobileScanner(
                      controller: _controller,
                      fit: BoxFit.cover,
                      placeholderBuilder: (context) => ColoredBox(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLow,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      overlayBuilder: (context, constraints) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.electricBlue.withValues(
                                    alpha: 0.65,
                                  ),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.all(AppSpacing.md),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: AppSpacing.sm,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.glassFor(
                                    Theme.of(context).brightness,
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: const Text(
                                  'Hold steady for a quick lock',
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      errorBuilder: (context, error) {
                        final reason = switch (error.errorCode) {
                          MobileScannerErrorCode.permissionDenied =>
                            BarcodeScannerDismissReason.permissionDenied,
                          MobileScannerErrorCode.unsupported =>
                            BarcodeScannerDismissReason.unsupported,
                          _ => BarcodeScannerDismissReason.error,
                        };
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 48,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  reason ==
                                          BarcodeScannerDismissReason
                                              .permissionDenied
                                      ? 'Camera permission is required'
                                      : 'Scanner unavailable',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  error.errorCode.message,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                FilledButton(
                                  onPressed: () => _close(
                                    BarcodeScannerResult(reason: reason),
                                  ),
                                  child: const Text('Close Scanner'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      onDetect: _handleDetect,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleDetect(BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue?.trim();
      if (value != null && value.isNotEmpty) {
        _close(
          BarcodeScannerResult(
            reason: BarcodeScannerDismissReason.scanned,
            barcode: value,
          ),
        );
        return;
      }
    }
  }

  void _close(BarcodeScannerResult result) {
    if (_hasClosed || !mounted) {
      return;
    }
    _hasClosed = true;
    Navigator.of(context).pop(result);
  }
}

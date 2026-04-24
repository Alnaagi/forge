import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:forge/app/theme/app_colors.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/shared/value_objects/trend_point.dart';

class TrendSparkline extends StatelessWidget {
  const TrendSparkline({
    required this.points,
    required this.color,
    this.height = 88,
    this.emptyLabel = 'More logs unlock the trend.',
    super.key,
  });

  final List<TrendPoint> points;
  final Color color;
  final double height;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (points.length < 2) {
      return Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.softFillFor(brightness),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          emptyLabel,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height,
          child: CustomPaint(
            painter: _TrendSparklinePainter(
              points: points,
              color: color,
              brightness: brightness,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Expanded(
              child: Text(
                points.first.label,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            Text(
              points.last.label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ],
    );
  }
}

class _TrendSparklinePainter extends CustomPainter {
  const _TrendSparklinePainter({
    required this.points,
    required this.color,
    required this.brightness,
  });

  final List<TrendPoint> points;
  final Color color;
  final Brightness brightness;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2 || size.isEmpty) {
      return;
    }

    final minValue = points.map((point) => point.value).reduce(math.min);
    final maxValue = points.map((point) => point.value).reduce(math.max);
    final range = maxValue - minValue;
    final resolvedRange = range == 0 ? 1.0 : range;
    const horizontalPadding = 4.0;
    const verticalPadding = 10.0;
    final usableWidth = math.max(size.width - (horizontalPadding * 2), 1);
    final usableHeight = math.max(size.height - (verticalPadding * 2), 1);

    final offsets = <Offset>[];
    for (var index = 0; index < points.length; index++) {
      final x = horizontalPadding + (usableWidth * index / (points.length - 1));
      final normalizedY = (points[index].value - minValue) / resolvedRange;
      final y = size.height - verticalPadding - (normalizedY * usableHeight);
      offsets.add(Offset(x, y));
    }

    final gridPaint = Paint()
      ..color = AppColors.ghostOutlineFor(brightness)
      ..strokeWidth = 1;
    for (var step = 1; step <= 2; step++) {
      final y = size.height * step / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final linePath = Path()..moveTo(offsets.first.dx, offsets.first.dy);
    for (final offset in offsets.skip(1)) {
      linePath.lineTo(offset.dx, offset.dy);
    }

    final fillPath = Path.from(linePath)
      ..lineTo(offsets.last.dx, size.height)
      ..lineTo(offsets.first.dx, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: brightness == Brightness.dark ? 0.22 : 0.16),
          color.withValues(alpha: 0.02),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(linePath, linePaint);

    final highlightPaint = Paint()..color = color;
    canvas.drawCircle(offsets.last, 4, highlightPaint);
    canvas.drawCircle(
      offsets.last,
      8,
      Paint()
        ..color = color.withValues(
          alpha: brightness == Brightness.dark ? 0.16 : 0.12,
        ),
    );
  }

  @override
  bool shouldRepaint(covariant _TrendSparklinePainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.color != color ||
        oldDelegate.brightness != brightness;
  }
}

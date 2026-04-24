import 'package:forge/shared/value_objects/weight_value.dart';

class WorkoutFormatters {
  const WorkoutFormatters._();

  static String weight(WeightValue? value) {
    if (value == null) {
      return '-';
    }
    return '${_trim(value.originalValue)} ${value.originalUnit.symbol}';
  }

  static String kilograms(double value) {
    return '${_trim(value)} kg';
  }

  static String duration(DateTime start, DateTime? end) {
    final duration = (end ?? DateTime.now()).difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  static String shortDateTime(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '${value.year}-$month-$day $hour:$minute';
  }

  static String _trim(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }
}

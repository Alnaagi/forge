import 'package:forge/shared/value_objects/date_range.dart';

abstract class AnalyticsRepository {
  Future<double> getTotalVolume(DateRange range);
  Future<double?> getLatestBodyWeightKilograms();
}

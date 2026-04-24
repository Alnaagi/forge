import 'package:forge/domain/repositories/analytics_repository.dart';
import 'package:forge/shared/value_objects/date_range.dart';

class GetHomeDashboard {
  const GetHomeDashboard(this._repository);

  final AnalyticsRepository _repository;

  Future<double> totalVolume(DateRange range) {
    return _repository.getTotalVolume(range);
  }
}

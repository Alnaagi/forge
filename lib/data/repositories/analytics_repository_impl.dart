import 'package:forge/data/local/db/daos/analytics_dao.dart';
import 'package:forge/domain/repositories/analytics_repository.dart';
import 'package:forge/shared/value_objects/date_range.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  const AnalyticsRepositoryImpl(this._dao);

  final AnalyticsDao _dao;

  @override
  Future<double?> getLatestBodyWeightKilograms() {
    return _dao.getLatestBodyWeightKilograms();
  }

  @override
  Future<double> getTotalVolume(DateRange range) {
    return _dao.getTotalVolume(range);
  }
}

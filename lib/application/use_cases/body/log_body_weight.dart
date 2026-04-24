import 'package:forge/domain/entities/body_log.dart';
import 'package:forge/domain/repositories/body_metrics_repository.dart';

class LogBodyWeight {
  const LogBodyWeight(this._repository);

  final BodyMetricsRepository _repository;

  Future<void> call(BodyLog bodyLog) {
    return _repository.saveBodyLog(bodyLog);
  }
}

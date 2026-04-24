import 'package:forge/domain/entities/insight.dart';
import 'package:forge/domain/repositories/insight_repository.dart';

class GenerateInsights {
  const GenerateInsights(this._repository);

  final InsightRepository _repository;

  Future<List<Insight>> call() {
    return _repository.getActiveInsights();
  }
}

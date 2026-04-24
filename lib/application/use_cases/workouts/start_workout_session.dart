import 'package:forge/domain/entities/workout_session.dart';
import 'package:forge/domain/repositories/workout_repository.dart';

class StartWorkoutSession {
  const StartWorkoutSession(this._repository);

  final WorkoutRepository _repository;

  Future<WorkoutSession> call({String? templateId}) {
    return _repository.startSession(templateId: templateId);
  }
}

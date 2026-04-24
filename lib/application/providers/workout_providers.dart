import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/exercise_dao.dart';
import 'package:forge/data/local/db/daos/workout_dao.dart';
import 'package:forge/data/repositories/exercise_repository_impl.dart';
import 'package:forge/data/repositories/workout_repository_impl.dart';
import 'package:forge/domain/repositories/exercise_repository.dart';
import 'package:forge/domain/repositories/workout_repository.dart';
import 'package:forge/domain/services/e1rm_service.dart';
import 'package:forge/domain/services/pr_detection_service.dart';
import 'package:forge/domain/services/volume_service.dart';
import 'package:forge/domain/services/workout_metrics_service.dart';
import 'package:forge/shared/unit_system/unit_converter.dart';

final uuidServiceProvider = Provider<UuidService>((ref) {
  return const UuidService();
});

final unitConverterProvider = Provider<UnitConverter>((ref) {
  return const UnitConverter();
});

final e1rmServiceProvider = Provider<E1rmService>((ref) {
  return const E1rmService();
});

final volumeServiceProvider = Provider<VolumeService>((ref) {
  return const VolumeService();
});

final prDetectionServiceProvider = Provider<PrDetectionService>((ref) {
  return const PrDetectionService();
});

final workoutMetricsServiceProvider = Provider<WorkoutMetricsService>((ref) {
  return WorkoutMetricsService(
    unitConverter: ref.watch(unitConverterProvider),
    e1rmService: ref.watch(e1rmServiceProvider),
    volumeService: ref.watch(volumeServiceProvider),
    prDetectionService: ref.watch(prDetectionServiceProvider),
  );
});

final exerciseDaoProvider = Provider<ExerciseDao>((ref) {
  return ExerciseDao(ref.watch(appDatabaseProvider));
});

final workoutDaoProvider = Provider<WorkoutDao>((ref) {
  return WorkoutDao(ref.watch(appDatabaseProvider));
});

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  return ExerciseRepositoryImpl(ref.watch(exerciseDaoProvider));
});

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  return WorkoutRepositoryImpl(ref.watch(workoutDaoProvider));
});

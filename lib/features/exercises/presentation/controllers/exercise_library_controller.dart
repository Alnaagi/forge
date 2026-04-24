import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/exercise.dart';

final exerciseSearchQueryProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final exerciseLibraryProvider = FutureProvider.autoDispose<List<Exercise>>((
  ref,
) async {
  final repository = ref.watch(exerciseRepositoryProvider);
  final query = ref.watch(exerciseSearchQueryProvider).trim();
  return repository.getAll(query: query.isEmpty ? null : query);
});

final customExerciseControllerProvider =
    AsyncNotifierProvider.autoDispose<CustomExerciseController, void>(
      CustomExerciseController.new,
    );

class CustomExerciseController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<Exercise> create({
    required String name,
    required String primaryMuscleGroup,
    String? notes,
  }) async {
    state = const AsyncLoading();
    final repository = ref.read(exerciseRepositoryProvider);
    final uuid = ref.read(uuidServiceProvider);
    final now = DateTime.now();

    final exercise = Exercise(
      id: 'exercise-${uuid.next()}',
      name: name.trim(),
      primaryMuscleGroup: primaryMuscleGroup.trim(),
      isBuiltIn: false,
      notes: notes?.trim().isEmpty ?? true ? null : notes!.trim(),
      createdAt: now,
      updatedAt: now,
    );

    await repository.upsert(exercise);
    ref.invalidate(exerciseLibraryProvider);
    state = const AsyncData(null);
    return exercise;
  }
}

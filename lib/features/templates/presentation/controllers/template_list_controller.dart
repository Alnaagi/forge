import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/workout_template_detail.dart';

final workoutTemplatesProvider =
    FutureProvider.autoDispose<List<WorkoutTemplateDetail>>((ref) async {
      return ref.watch(workoutRepositoryProvider).getTemplateDetails();
    });

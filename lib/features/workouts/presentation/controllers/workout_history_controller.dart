import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/workout_history_item.dart';
import 'package:forge/domain/entities/workout_session_detail.dart';

final workoutHistoryProvider =
    FutureProvider.autoDispose<List<WorkoutHistoryItem>>((ref) async {
      return ref.watch(workoutRepositoryProvider).getHistoryItems();
    });

final workoutSessionDetailProvider = FutureProvider.autoDispose
    .family<WorkoutSessionDetail?, String>((ref, sessionId) async {
      return ref.watch(workoutRepositoryProvider).getSessionDetail(sessionId);
    });

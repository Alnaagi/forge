import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/settings_providers.dart';
import 'package:forge/application/providers/sync_providers.dart';
import 'package:forge/features/body_metrics/presentation/controllers/body_progress_controller.dart';
import 'package:forge/features/exercises/presentation/controllers/exercise_library_controller.dart';
import 'package:forge/features/nutrition/presentation/controllers/saved_meals_controller.dart';
import 'package:forge/features/templates/presentation/controllers/template_list_controller.dart';

final restoreImportControllerProvider =
    AsyncNotifierProvider.autoDispose<RestoreImportController, void>(
      RestoreImportController.new,
    );

class RestoreImportController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<String> importBackup(String installationId) async {
    state = const AsyncLoading();
    try {
      final result = await ref
          .read(syncRepositoryProvider)
          .importRemoteBackup(installationId);
      ref.invalidate(remoteBackupSummariesProvider);
      ref.invalidate(syncOverviewProvider);
      ref.invalidate(bodyLogsProvider);
      ref.invalidate(savedMealsProvider);
      ref.invalidate(workoutTemplatesProvider);
      ref.invalidate(exerciseLibraryProvider);
      ref.invalidate(themeModePreferenceProvider);
      ref.invalidate(dashboardSectionOrderProvider);
      state = const AsyncData(null);
      return 'Import finished with ${result.importedCount} imported item${result.importedCount == 1 ? '' : 's'} and ${result.skippedCount} skipped item${result.skippedCount == 1 ? '' : 's'}.';
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}

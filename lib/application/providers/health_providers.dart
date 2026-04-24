import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/health_tracking_dao.dart';
import 'package:forge/data/repositories/health_repository_impl.dart';
import 'package:forge/domain/repositories/health_repository.dart';
import 'package:forge/domain/services/health_caution_service.dart';

final healthUuidServiceProvider = Provider<UuidService>((ref) {
  return const UuidService();
});

final healthTrackingDaoProvider = Provider<HealthTrackingDao>((ref) {
  return HealthTrackingDao(ref.watch(appDatabaseProvider));
});

final healthRepositoryProvider = Provider<HealthRepository>((ref) {
  return HealthRepositoryImpl(ref.watch(healthTrackingDaoProvider));
});

final healthCautionServiceProvider = Provider<HealthCautionService>((ref) {
  return const HealthCautionService();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/services/uuid_service.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/body_metrics_dao.dart';
import 'package:forge/data/repositories/body_metrics_repository_impl.dart';
import 'package:forge/domain/repositories/body_metrics_repository.dart';
import 'package:forge/shared/unit_system/unit_converter.dart';

final bodyMetricsUuidServiceProvider = Provider<UuidService>((ref) {
  return const UuidService();
});

final bodyMetricsUnitConverterProvider = Provider<UnitConverter>((ref) {
  return const UnitConverter();
});

final bodyMetricsDaoProvider = Provider<BodyMetricsDao>((ref) {
  return BodyMetricsDao(ref.watch(appDatabaseProvider));
});

final bodyMetricsRepositoryProvider = Provider<BodyMetricsRepository>((ref) {
  return BodyMetricsRepositoryImpl(ref.watch(bodyMetricsDaoProvider));
});

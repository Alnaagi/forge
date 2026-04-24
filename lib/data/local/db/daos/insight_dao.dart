import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/shared/enums/insight_status.dart';

class InsightDao {
  const InsightDao(this.database);

  final AppDatabase database;

  Future<List<InsightsTableData>> getActiveInsights() {
    return (database.select(database.insightsTable)
          ..where((table) => table.status.equalsValue(InsightStatus.active))
          ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
        .get();
  }

  Future<List<InsightsTableData>> getAllInsights() {
    return (database.select(
      database.insightsTable,
    )..orderBy([(table) => OrderingTerm.desc(table.updatedAt)])).get();
  }

  Future<void> upsert(InsightsTableCompanion companion) {
    return database
        .into(database.insightsTable)
        .insertOnConflictUpdate(companion);
  }

  Future<void> updateStatus({
    required String insightId,
    required InsightStatus status,
  }) {
    return (database.update(
      database.insightsTable,
    )..where((table) => table.id.equals(insightId))).write(
      InsightsTableCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

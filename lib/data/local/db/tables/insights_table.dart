import 'package:drift/drift.dart';
import 'package:forge/shared/enums/insight_category.dart';
import 'package:forge/shared/enums/insight_severity.dart';
import 'package:forge/shared/enums/insight_status.dart';

class InsightsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get category => textEnum<InsightCategory>()();
  TextColumn get severity => textEnum<InsightSeverity>()();
  TextColumn get status => textEnum<InsightStatus>()();
  TextColumn get title => text().withLength(min: 1, max: 160)();
  TextColumn get shortMessage => text().withLength(min: 1, max: 280)();
  TextColumn get fullExplanation => text()();
  TextColumn get evidenceJson => text()();
  RealColumn get confidence => real()();
  TextColumn get suggestedAction => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

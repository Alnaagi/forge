import 'package:drift/drift.dart';
import 'package:forge/shared/enums/sync_source.dart';

class HealthSyncRecordsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get source => textEnum<SyncSource>()();
  TextColumn get recordType => text().withLength(min: 1, max: 80)();
  TextColumn get externalId => text().withLength(min: 1, max: 128).nullable()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get recordedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'UNIQUE(source, record_type, external_id)',
  ];
}

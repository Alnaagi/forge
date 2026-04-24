import 'package:drift/drift.dart';
import 'package:forge/shared/enums/sync_source.dart';

class FoodsTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 160)();
  TextColumn get brandName => text().withLength(min: 1, max: 120).nullable()();
  TextColumn get barcode => text().withLength(min: 1, max: 64).nullable()();
  IntColumn get caloriesPer100g => integer()();
  RealColumn get proteinPer100g => real()();
  RealColumn get carbsPer100g => real()();
  RealColumn get fatPer100g => real()();
  TextColumn get source => textEnum<SyncSource>()();
  BoolColumn get isUserEdited => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE(barcode)'];
}

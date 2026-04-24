import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forge/app/app.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/profile_dao.dart';
import 'package:forge/data/local/db/app_database.dart' as db;
import 'package:forge/shared/enums/body_metric_unit.dart';
import 'package:forge/shared/enums/weight_unit.dart';

void main() {
  late db.AppDatabase database;

  setUp(() {
    database = db.AppDatabase.test(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('returns existing users to the home dashboard', (tester) async {
    final now = DateTime(2026, 4, 22, 10);
    await ProfileDao(database).upsertProfile(
      db.UsersTableCompanion.insert(
        id: 'user-1',
        displayName: 'Mohamed',
        preferredWeightUnit: WeightUnit.kilograms,
        preferredBodyMetricUnit: BodyMetricUnit.centimeters,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: const ForgeApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('HELLO, ELITE'), findsOneWidget);
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Save and Enter Forge'), findsNothing);
  });

  testWidgets('goal management remains reachable from the More tab', (
    tester,
  ) async {
    final now = DateTime(2026, 4, 22, 10);
    await ProfileDao(database).upsertProfile(
      db.UsersTableCompanion.insert(
        id: 'user-1',
        displayName: 'Mohamed',
        preferredWeightUnit: WeightUnit.kilograms,
        preferredBodyMetricUnit: BodyMetricUnit.centimeters,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: const ForgeApp(),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('More').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Goals'));
    await tester.pumpAndSettle();

    expect(find.text('Set Active Goal'), findsOneWidget);
  });

  testWidgets('backup and sync remains reachable from the More tab', (
    tester,
  ) async {
    final now = DateTime(2026, 4, 22, 10);
    await ProfileDao(database).upsertProfile(
      db.UsersTableCompanion.insert(
        id: 'user-1',
        displayName: 'Mohamed',
        preferredWeightUnit: WeightUnit.kilograms,
        preferredBodyMetricUnit: BodyMetricUnit.centimeters,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: const ForgeApp(),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('More').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Backup & Sync'));
    await tester.pumpAndSettle();

    expect(find.text('Account Status'), findsOneWidget);
  });

  testWidgets('restore import remains reachable from Backup & Sync', (
    tester,
  ) async {
    final now = DateTime(2026, 4, 22, 10);
    await ProfileDao(database).upsertProfile(
      db.UsersTableCompanion.insert(
        id: 'user-1',
        displayName: 'Mohamed',
        preferredWeightUnit: WeightUnit.kilograms,
        preferredBodyMetricUnit: BodyMetricUnit.centimeters,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: const ForgeApp(),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('More').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Backup & Sync'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Browse Restore Imports'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Browse Restore Imports'));
    await tester.pumpAndSettle();

    expect(
      find.text('Cloud backup is not configured in this build'),
      findsOneWidget,
    );
  });

  testWidgets('Health Connect privacy entry is visible from Integrations', (
    tester,
  ) async {
    final now = DateTime(2026, 4, 22, 10);
    await ProfileDao(database).upsertProfile(
      db.UsersTableCompanion.insert(
        id: 'user-1',
        displayName: 'Mohamed',
        preferredWeightUnit: WeightUnit.kilograms,
        preferredBodyMetricUnit: BodyMetricUnit.centimeters,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: const ForgeApp(),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('More').last);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Integrations'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Integrations'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Privacy & Permissions'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    expect(find.text('Privacy & Permissions'), findsOneWidget);
  });
}

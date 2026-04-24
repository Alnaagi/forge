import 'package:forge/data/local/db/app_database.dart';

class ProfileDao {
  const ProfileDao(this.database);

  final AppDatabase database;

  Future<UsersTableData?> getProfile() {
    return database.select(database.usersTable).getSingleOrNull();
  }

  Future<void> upsertProfile(UsersTableCompanion companion) {
    return database.into(database.usersTable).insertOnConflictUpdate(companion);
  }
}

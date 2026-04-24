import 'package:forge/data/local/db/daos/reminder_dao.dart';
import 'package:forge/data/local/db/mappers/reminder_mapper.dart';
import 'package:forge/domain/entities/reminder.dart';
import 'package:forge/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  const ReminderRepositoryImpl(this._dao);

  final ReminderDao _dao;

  @override
  Future<List<Reminder>> getAll() async {
    final rows = await _dao.getAll();
    return rows.map((row) => row.toDomain()).toList(growable: false);
  }

  @override
  Future<void> save(Reminder reminder) {
    return _dao.upsert(reminder.toCompanion());
  }

  @override
  Future<void> delete(String reminderId) {
    return _dao.deleteById(reminderId);
  }
}

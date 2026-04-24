import 'package:forge/data/local/db/daos/profile_dao.dart';
import 'package:forge/data/local/db/mappers/profile_mapper.dart';
import 'package:forge/domain/entities/user_profile.dart';
import 'package:forge/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._dao);

  final ProfileDao _dao;

  @override
  Future<UserProfile?> getProfile() async {
    final row = await _dao.getProfile();
    return row?.toDomain();
  }

  @override
  Future<void> saveProfile(UserProfile profile) {
    return _dao.upsertProfile(profile.toCompanion());
  }
}

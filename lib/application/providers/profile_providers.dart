import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/data/local/db/app_database_provider.dart';
import 'package:forge/data/local/db/daos/profile_dao.dart';
import 'package:forge/data/repositories/profile_repository_impl.dart';
import 'package:forge/domain/entities/user_profile.dart';
import 'package:forge/domain/repositories/profile_repository.dart';

final profileDaoProvider = Provider<ProfileDao>((ref) {
  return ProfileDao(ref.watch(appDatabaseProvider));
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.watch(profileDaoProvider));
});

final currentUserProfileProvider = FutureProvider<UserProfile?>((ref) {
  return ref.watch(profileRepositoryProvider).getProfile();
});

final hasCompletedOnboardingProvider = FutureProvider<bool>((ref) async {
  final profile = await ref.watch(currentUserProfileProvider.future);
  return profile != null && profile.displayName.trim().isNotEmpty;
});

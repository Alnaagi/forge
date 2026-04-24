import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/services/cloud_backup_client.dart';
import 'package:forge/application/services/cloud_auth_client.dart';
import 'package:forge/data/repositories/auth_repository_impl.dart';
import 'package:forge/domain/entities/auth_session_state.dart';
import 'package:forge/domain/repositories/auth_repository.dart';

final cloudAuthConfigProvider = Provider<CloudAuthConfig>((ref) {
  return CloudAuthConfig.fromEnvironment();
});

final cloudAuthClientProvider = Provider<CloudAuthClient>((ref) {
  final config = ref.watch(cloudAuthConfigProvider);
  if (!config.isConfigured) {
    return const DisabledCloudAuthClient();
  }
  return SupabaseCloudAuthClient(config);
});

final cloudBackupClientProvider = Provider<CloudBackupClient>((ref) {
  final config = ref.watch(cloudAuthConfigProvider);
  if (!config.isConfigured) {
    return const DisabledCloudBackupClient();
  }
  return SupabaseCloudBackupClient(config);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(cloudAuthClientProvider));
});

final authSessionStateProvider = StreamProvider<AuthSessionState>((ref) {
  return ref.watch(authRepositoryProvider).watchSessionState();
});

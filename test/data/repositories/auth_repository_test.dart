import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:forge/application/services/cloud_auth_client.dart';
import 'package:forge/data/repositories/auth_repository_impl.dart';

void main() {
  test('stays guest-first when cloud auth is not configured', () async {
    final repository = AuthRepositoryImpl(const DisabledCloudAuthClient());

    final session = await repository.getSessionState();

    expect(session.isBackendConfigured, isFalse);
    expect(session.isSignedIn, isFalse);
  });

  test('maps signed in cloud accounts into auth session state', () async {
    final client = _FakeCloudAuthClient(
      isConfigured: true,
      account: const CloudAuthAccount(
        id: 'account-1',
        email: 'forge@example.com',
      ),
    );
    final repository = AuthRepositoryImpl(client);

    final session = await repository.getSessionState();

    expect(session.isBackendConfigured, isTrue);
    expect(session.isSignedIn, isTrue);
    expect(session.accountId, 'account-1');
    expect(session.email, 'forge@example.com');
  });
}

class _FakeCloudAuthClient implements CloudAuthClient {
  _FakeCloudAuthClient({required this.isConfigured, this.account});

  @override
  final bool isConfigured;

  CloudAuthAccount? account;

  @override
  CloudAuthAccount? get currentAccount => account;

  @override
  Stream<CloudAuthAccount?> authStateChanges() {
    return Stream<CloudAuthAccount?>.value(account);
  }

  @override
  Future<CloudAuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return CloudAuthResult(account: account);
  }

  @override
  Future<CloudAuthResult> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return CloudAuthResult(account: account);
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<void> updateUserMetadata(Map<String, dynamic> data) async {}
}

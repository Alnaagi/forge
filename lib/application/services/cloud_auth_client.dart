import 'package:supabase_flutter/supabase_flutter.dart';

class CloudAuthConfig {
  const CloudAuthConfig({
    required this.supabaseUrl,
    required this.supabasePublishableKey,
  });

  factory CloudAuthConfig.fromEnvironment() {
    return const CloudAuthConfig(
      supabaseUrl: String.fromEnvironment('FORGE_SUPABASE_URL'),
      supabasePublishableKey: String.fromEnvironment(
        'FORGE_SUPABASE_PUBLISHABLE_KEY',
      ),
    );
  }

  final String supabaseUrl;
  final String supabasePublishableKey;

  bool get isConfigured =>
      supabaseUrl.trim().isNotEmpty &&
      supabasePublishableKey.trim().isNotEmpty;
}

class CloudAuthAccount {
  const CloudAuthAccount({required this.id, this.email});

  final String id;
  final String? email;
}

class CloudAuthResult {
  const CloudAuthResult({
    this.account,
    this.requiresEmailConfirmation = false,
  });

  final CloudAuthAccount? account;
  final bool requiresEmailConfirmation;
}

abstract class CloudAuthClient {
  bool get isConfigured;
  CloudAuthAccount? get currentAccount;
  Stream<CloudAuthAccount?> authStateChanges();
  Future<CloudAuthResult> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<CloudAuthResult> signInWithEmail({
    required String email,
    required String password,
  });
  Future<void> updateUserMetadata(Map<String, dynamic> data);
  Future<void> signOut();
}

class SupabaseCloudAuthClient implements CloudAuthClient {
  const SupabaseCloudAuthClient(this._config);

  final CloudAuthConfig _config;

  SupabaseClient get _client => Supabase.instance.client;

  @override
  bool get isConfigured => _config.isConfigured;

  @override
  CloudAuthAccount? get currentAccount {
    if (!isConfigured) {
      return null;
    }
    final user = _client.auth.currentUser;
    if (user == null) {
      return null;
    }
    return CloudAuthAccount(id: user.id, email: user.email);
  }

  @override
  Stream<CloudAuthAccount?> authStateChanges() {
    if (!isConfigured) {
      return Stream<CloudAuthAccount?>.value(null);
    }
    return _client.auth.onAuthStateChange.map((event) {
      final user = event.session?.user ?? _client.auth.currentUser;
      if (user == null) {
        return null;
      }
      return CloudAuthAccount(id: user.id, email: user.email);
    });
  }

  @override
  Future<CloudAuthResult> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    if (!isConfigured) {
      return const CloudAuthResult();
    }

    final response = await _client.auth.signUp(email: email, password: password);
    final user = response.user;
    return CloudAuthResult(
      account: user == null ? null : CloudAuthAccount(id: user.id, email: user.email),
      requiresEmailConfirmation: response.session == null,
    );
  }

  @override
  Future<CloudAuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (!isConfigured) {
      return const CloudAuthResult();
    }

    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    return CloudAuthResult(
      account: user == null ? null : CloudAuthAccount(id: user.id, email: user.email),
    );
  }

  @override
  Future<void> updateUserMetadata(Map<String, dynamic> data) async {
    if (!isConfigured || currentAccount == null) {
      return;
    }
    await _client.auth.updateUser(UserAttributes(data: data));
  }

  @override
  Future<void> signOut() async {
    if (!isConfigured) {
      return;
    }
    await _client.auth.signOut();
  }
}

class DisabledCloudAuthClient implements CloudAuthClient {
  const DisabledCloudAuthClient();

  @override
  bool get isConfigured => false;

  @override
  CloudAuthAccount? get currentAccount => null;

  @override
  Stream<CloudAuthAccount?> authStateChanges() {
    return Stream<CloudAuthAccount?>.value(null);
  }

  @override
  Future<CloudAuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return const CloudAuthResult();
  }

  @override
  Future<CloudAuthResult> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return const CloudAuthResult();
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<void> updateUserMetadata(Map<String, dynamic> data) async {}
}

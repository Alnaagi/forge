import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/services/cloud_auth_client.dart';
import 'package:forge/app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeOptionalSupabase();
  runApp(const ProviderScope(child: ForgeApp()));
}

Future<void> _initializeOptionalSupabase() async {
  final config = CloudAuthConfig.fromEnvironment();
  if (!config.isConfigured) {
    return;
  }

  await Supabase.initialize(
    url: config.supabaseUrl,
    anonKey: config.supabasePublishableKey,
  );
}

class Env {
  const Env._();

  static const appName = 'Forge';
  static const databaseName = 'forge.sqlite';
  static const supabaseUrl = String.fromEnvironment('FORGE_SUPABASE_URL');
  static const supabasePublishableKey = String.fromEnvironment(
    'FORGE_SUPABASE_PUBLISHABLE_KEY',
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/reminder_providers.dart';
import 'package:forge/application/services/reminder_destination_resolver.dart';
import 'package:forge/application/providers/settings_providers.dart';
import 'package:forge/app/router/app_router.dart';
import 'package:forge/app/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class ForgeApp extends ConsumerWidget {
  const ForgeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModePreferenceProvider).valueOrNull;
    ref.watch(reminderSyncProvider);
    ref.listen<AsyncValue<String?>>(initialReminderTapProvider, (_, next) {
      next.whenData((payload) {
        if (payload == null || payload.isEmpty) {
          return;
        }
        _openReminderDestination(router, payload);
      });
    });
    ref.listen<AsyncValue<String>>(reminderTapEventsProvider, (_, next) {
      next.whenData((payload) {
        if (payload.isEmpty) {
          return;
        }
        _openReminderDestination(router, payload);
      });
    });

    return MaterialApp.router(
      title: 'Forge',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode ?? ThemeMode.system,
      routerConfig: router,
    );
  }
}

void _openReminderDestination(GoRouter router, String payload) {
  final location = resolveReminderDestination(payload);
  WidgetsBinding.instance.addPostFrameCallback((_) {
    router.go(location);
  });
}

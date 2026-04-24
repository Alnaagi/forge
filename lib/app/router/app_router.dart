import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/profile_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:forge/app/app_shell.dart';
import 'package:forge/app/router/route_names.dart';
import 'package:forge/app/router/route_paths.dart';
import 'package:forge/features/analytics/presentation/screens/analytics_home_screen.dart';
import 'package:forge/features/body_metrics/presentation/screens/body_progress_screen.dart';
import 'package:forge/features/dashboard/presentation/screens/home_dashboard_screen.dart';
import 'package:forge/features/exercises/presentation/screens/create_custom_exercise_screen.dart';
import 'package:forge/features/exercises/presentation/screens/exercise_library_screen.dart';
import 'package:forge/features/goals/presentation/screens/goal_settings_screen.dart';
import 'package:forge/features/health/presentation/screens/health_status_screen.dart';
import 'package:forge/features/insights/presentation/screens/insights_screen.dart';
import 'package:forge/features/more/presentation/screens/more_screen.dart';
import 'package:forge/features/more/presentation/screens/integrations_screen.dart';
import 'package:forge/features/more/presentation/screens/reports_screen.dart';
import 'package:forge/features/health_sync/presentation/screens/health_connect_privacy_screen.dart';
import 'package:forge/features/nutrition/presentation/screens/barcode_lookup_screen.dart';
import 'package:forge/features/nutrition/presentation/screens/food_editor_screen.dart';
import 'package:forge/features/nutrition/presentation/screens/food_search_screen.dart';
import 'package:forge/features/nutrition/presentation/screens/meal_log_screen.dart';
import 'package:forge/features/nutrition/presentation/screens/nutrition_home_screen.dart';
import 'package:forge/features/nutrition/presentation/screens/saved_meal_editor_screen.dart';
import 'package:forge/features/nutrition/presentation/screens/saved_meals_screen.dart';
import 'package:forge/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:forge/features/settings/presentation/screens/settings_screen.dart';
import 'package:forge/features/settings/presentation/screens/backup_sync_screen.dart';
import 'package:forge/features/settings/presentation/screens/restore_import_screen.dart';
import 'package:forge/features/templates/presentation/screens/template_builder_screen.dart';
import 'package:forge/features/templates/presentation/screens/template_list_screen.dart';
import 'package:forge/features/workouts/presentation/screens/live_workout_screen.dart';
import 'package:forge/features/workouts/presentation/screens/workout_history_screen.dart';
import 'package:forge/features/workouts/presentation/screens/workout_session_detail_screen.dart';
import 'package:forge/features/workouts/presentation/screens/workouts_home_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final defaultRouteName =
      WidgetsBinding.instance.platformDispatcher.defaultRouteName;
  final router = GoRouter(
    initialLocation: resolveInitialAppLocation(defaultRouteName),
    redirect: (context, state) async {
      final hasCompletedOnboarding = await ref.read(
        hasCompletedOnboardingProvider.future,
      );
      return resolveAppRedirect(
        hasCompletedOnboarding: hasCompletedOnboarding,
        matchedLocation: state.matchedLocation,
      );
    },
    routes: [
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.home,
                name: RouteNames.home,
                builder: (context, state) => const HomeDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.workouts,
                name: RouteNames.workouts,
                builder: (context, state) => const WorkoutsHomeScreen(),
                routes: [
                  GoRoute(
                    path: 'live/:sessionId',
                    name: RouteNames.liveWorkout,
                    builder: (context, state) => LiveWorkoutScreen(
                      sessionId: state.pathParameters['sessionId']!,
                    ),
                  ),
                  GoRoute(
                    path: 'history',
                    name: RouteNames.workoutHistory,
                    builder: (context, state) => const WorkoutHistoryScreen(),
                  ),
                  GoRoute(
                    path: 'session/:sessionId',
                    name: RouteNames.workoutDetail,
                    builder: (context, state) => WorkoutSessionDetailScreen(
                      sessionId: state.pathParameters['sessionId']!,
                    ),
                  ),
                  GoRoute(
                    path: 'exercises',
                    name: RouteNames.exerciseLibrary,
                    builder: (context, state) => const ExerciseLibraryScreen(),
                    routes: [
                      GoRoute(
                        path: 'create',
                        name: RouteNames.createCustomExercise,
                        builder: (context, state) =>
                            const CreateCustomExerciseScreen(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'templates',
                    name: RouteNames.templateList,
                    builder: (context, state) => const TemplateListScreen(),
                    routes: [
                      GoRoute(
                        path: 'builder',
                        name: RouteNames.templateBuilder,
                        builder: (context, state) => TemplateBuilderScreen(
                          templateId: state.uri.queryParameters['templateId'],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.nutrition,
                name: RouteNames.nutrition,
                builder: (context, state) => const NutritionHomeScreen(),
                routes: [
                  GoRoute(
                    path: 'search',
                    name: RouteNames.foodSearch,
                    builder: (context, state) => FoodSearchScreen(
                      initialMealType: state.uri.queryParameters['mealType'],
                    ),
                  ),
                  GoRoute(
                    path: 'barcode',
                    name: RouteNames.barcodeLookup,
                    builder: (context, state) => BarcodeLookupScreen(
                      initialMealType: state.uri.queryParameters['mealType'],
                    ),
                  ),
                  GoRoute(
                    path: 'food',
                    name: RouteNames.foodEditor,
                    builder: (context, state) => FoodEditorScreen(
                      foodId: state.uri.queryParameters['foodId'],
                      initialBarcode: state.uri.queryParameters['barcode'],
                      mealTypeName: state.uri.queryParameters['mealType'],
                    ),
                  ),
                  GoRoute(
                    path: 'log',
                    name: RouteNames.mealLog,
                    builder: (context, state) => MealLogScreen(
                      foodId: state.uri.queryParameters['foodId'],
                      mealEntryId: state.uri.queryParameters['mealEntryId'],
                      initialMealTypeName:
                          state.uri.queryParameters['mealType'],
                    ),
                  ),
                  GoRoute(
                    path: 'saved-meals',
                    name: RouteNames.savedMeals,
                    builder: (context, state) => const SavedMealsScreen(),
                    routes: [
                      GoRoute(
                        path: 'edit/:savedMealId',
                        name: RouteNames.savedMealEditor,
                        builder: (context, state) => SavedMealEditorScreen(
                          savedMealId: state.pathParameters['savedMealId']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.progress,
                name: RouteNames.progress,
                builder: (context, state) => const BodyProgressScreen(),
                routes: [
                  GoRoute(
                    path: 'health',
                    name: RouteNames.healthStatus,
                    builder: (context, state) => HealthStatusScreen(
                      initialEntryTypeName:
                          state.uri.queryParameters['entryType'],
                      openComposer:
                          state.uri.queryParameters['compose'] == 'true',
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.more,
                name: RouteNames.more,
                builder: (context, state) => const MoreScreen(),
                routes: [
                  GoRoute(
                    path: 'settings',
                    name: RouteNames.settings,
                    builder: (context, state) => const SettingsScreen(),
                  ),
                  GoRoute(
                    path: 'backup-sync',
                    name: RouteNames.backupSync,
                    builder: (context, state) => const BackupSyncScreen(),
                    routes: [
                      GoRoute(
                        path: 'restore-import',
                        name: RouteNames.restoreImport,
                        builder: (context, state) =>
                            const RestoreImportScreen(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'goals',
                    name: RouteNames.goals,
                    builder: (context, state) => const GoalSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'integrations',
                    name: RouteNames.integrations,
                    builder: (context, state) => const IntegrationsScreen(),
                    routes: [
                      GoRoute(
                        path: 'health-connect-privacy',
                        name: RouteNames.healthConnectPrivacy,
                        builder: (context, state) =>
                            const HealthConnectPrivacyScreen(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'reports',
                    name: RouteNames.reports,
                    builder: (context, state) => const ReportsScreen(),
                  ),
                  GoRoute(
                    path: 'analytics',
                    name: RouteNames.analytics,
                    builder: (context, state) => const AnalyticsHomeScreen(),
                  ),
                  GoRoute(
                    path: 'insights',
                    name: RouteNames.insights,
                    builder: (context, state) => const InsightsScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.listen(hasCompletedOnboardingProvider, (_, __) => router.refresh());
  ref.onDispose(router.dispose);
  return router;
});

String? resolveAppRedirect({
  required bool hasCompletedOnboarding,
  required String matchedLocation,
}) {
  final isOnboarding = matchedLocation == RoutePaths.onboarding;
  final isPrivacyRationale = matchedLocation == RoutePaths.healthConnectPrivacy;
  if (isPrivacyRationale) {
    return null;
  }
  if (!hasCompletedOnboarding && !isOnboarding) {
    return RoutePaths.onboarding;
  }
  if (hasCompletedOnboarding && isOnboarding) {
    return RoutePaths.home;
  }
  return null;
}

String resolveInitialAppLocation(String? defaultRouteName) {
  final routeName = defaultRouteName?.trim();
  if (routeName == RoutePaths.healthConnectPrivacy) {
    return RoutePaths.healthConnectPrivacy;
  }
  return RoutePaths.home;
}

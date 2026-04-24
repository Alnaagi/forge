import 'package:forge/app/router/route_paths.dart';

String resolveReminderDestination(String payload) {
  if (payload.startsWith('smart-health-checkin-') ||
      payload == 'smart-health-review') {
    return '${RoutePaths.healthStatus}?compose=true';
  }

  return switch (payload) {
    'smart-water-recovery' => RoutePaths.nutrition,
    'smart-nutrition-goal' => RoutePaths.nutrition,
    'smart-training-check' => RoutePaths.workouts,
    'smart-body-checkin' => RoutePaths.progress,
    'smart-membership-renewal' => RoutePaths.settings,
    _ => RoutePaths.home,
  };
}

import 'package:flutter_test/flutter_test.dart';
import 'package:forge/app/router/app_router.dart';
import 'package:forge/app/router/route_paths.dart';

void main() {
  group('resolveAppRedirect', () {
    test('sends first-run users to onboarding from app routes', () {
      expect(
        resolveAppRedirect(
          hasCompletedOnboarding: false,
          matchedLocation: RoutePaths.home,
        ),
        RoutePaths.onboarding,
      );
      expect(
        resolveAppRedirect(
          hasCompletedOnboarding: false,
          matchedLocation: RoutePaths.nutrition,
        ),
        RoutePaths.onboarding,
      );
    });

    test('allows onboarding route during first run', () {
      expect(
        resolveAppRedirect(
          hasCompletedOnboarding: false,
          matchedLocation: RoutePaths.onboarding,
        ),
        isNull,
      );
    });

    test('returns completed users home when they revisit onboarding', () {
      expect(
        resolveAppRedirect(
          hasCompletedOnboarding: true,
          matchedLocation: RoutePaths.onboarding,
        ),
        RoutePaths.home,
      );
    });

    test('allows Health Connect privacy route even before onboarding', () {
      expect(
        resolveAppRedirect(
          hasCompletedOnboarding: false,
          matchedLocation: RoutePaths.healthConnectPrivacy,
        ),
        isNull,
      );
    });
  });

  group('resolveInitialAppLocation', () {
    test('uses Health Connect privacy route when requested by Android', () {
      expect(
        resolveInitialAppLocation(RoutePaths.healthConnectPrivacy),
        RoutePaths.healthConnectPrivacy,
      );
    });

    test('falls back to home for normal launches', () {
      expect(resolveInitialAppLocation('/'), RoutePaths.home);
      expect(resolveInitialAppLocation(null), RoutePaths.home);
    });
  });
}

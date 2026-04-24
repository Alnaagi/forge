import 'package:flutter_test/flutter_test.dart';
import 'package:forge/application/services/reminder_destination_resolver.dart';
import 'package:forge/app/router/route_paths.dart';

void main() {
  group('resolveReminderDestination', () {
    test('routes health check-ins to the health composer', () {
      expect(
        resolveReminderDestination('smart-health-checkin-10-00'),
        '${RoutePaths.healthStatus}?compose=true',
      );
    });

    test('routes membership reminder to settings', () {
      expect(
        resolveReminderDestination('smart-membership-renewal'),
        RoutePaths.settings,
      );
    });

    test('routes unknown payloads home safely', () {
      expect(resolveReminderDestination('smart-unknown'), RoutePaths.home);
    });
  });
}

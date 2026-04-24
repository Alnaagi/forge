import 'package:flutter_test/flutter_test.dart';
import 'package:forge/application/providers/settings_providers.dart';

void main() {
  group('GymMembershipStatus', () {
    test('flags the last 3 days as a warning window', () {
      final status = GymMembershipStatus.fromSettings(
        GymMembershipSettings(startDate: DateTime(2026, 4, 1), cycleDays: 30),
        now: DateTime(2026, 4, 28),
      );

      expect(status.daysRemaining, 3);
      expect(status.isWarning, isTrue);
      expect(status.isNearEnd, isFalse);
      expect(status.isExpired, isFalse);
    });

    test('marks the cycle expired once the renewal date is reached', () {
      final status = GymMembershipStatus.fromSettings(
        GymMembershipSettings(startDate: DateTime(2026, 4, 1), cycleDays: 30),
        now: DateTime(2026, 5, 1),
      );

      expect(status.daysRemaining, 0);
      expect(status.isExpired, isTrue);
    });
  });

  group('parseDashboardSectionOrder', () {
    test('restores defaults for missing sections and ignores duplicates', () {
      final order = parseDashboardSectionOrder(
        'healthWatch,quickRoutes,healthWatch,unknown',
      );

      expect(order.first, DashboardSection.healthWatch);
      expect(order[1], DashboardSection.quickRoutes);
      expect(order, containsAll(defaultDashboardSectionOrder));
      expect(
        order
            .where((section) => section == DashboardSection.healthWatch)
            .length,
        1,
      );
    });
  });
}

import 'dart:io';
import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:forge/application/services/reminder_notification_scheduler.dart';
import 'package:forge/domain/entities/reminder.dart';
import 'package:forge/shared/enums/reminder_type.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

ReminderNotificationScheduler createReminderNotificationSchedulerImpl() {
  return _MobileReminderNotificationScheduler();
}

class _MobileReminderNotificationScheduler
    implements ReminderNotificationScheduler {
  _MobileReminderNotificationScheduler();

  static const _channel = AndroidNotificationChannel(
    'forge_smart_reminders',
    'Forge Smart Reminders',
    description: 'Reminders generated from Forge insights and health cadence.',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  final StreamController<String> _tapEventsController =
      StreamController<String>.broadcast();

  bool _isInitialized = false;
  String? _initialTapPayload;

  bool get _isSupportedPlatform => Platform.isAndroid;

  @override
  Stream<String> get tapEvents => _tapEventsController.stream;

  @override
  Future<void> initialize() async {
    if (_isInitialized || !_isSupportedPlatform) {
      _isInitialized = true;
      return;
    }

    tz_data.initializeTimeZones();
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    } catch (_) {
      tz.setLocalLocation(tz.local);
    }

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      _initialTapPayload = launchDetails?.notificationResponse?.payload;
    }

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload == null || payload.isEmpty) {
          return;
        }
        _tapEventsController.add(payload);
      },
    );

    final androidImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidImplementation?.createNotificationChannel(_channel);
    _isInitialized = true;
  }

  @override
  Future<ReminderNotificationDeliveryStatus> getStatus() async {
    await initialize();
    if (!_isSupportedPlatform) {
      return const ReminderNotificationDeliveryStatus(
        isSupported: false,
        areNotificationsEnabled: false,
        scheduledReminderCount: 0,
      );
    }

    final androidImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final areNotificationsEnabled =
        await androidImplementation?.areNotificationsEnabled() ?? false;
    final pendingRequests = await _plugin.pendingNotificationRequests();
    final smartCount = pendingRequests
        .where((request) => (request.payload ?? '').startsWith('smart-'))
        .length;

    return ReminderNotificationDeliveryStatus(
      isSupported: true,
      areNotificationsEnabled: areNotificationsEnabled,
      scheduledReminderCount: smartCount,
    );
  }

  @override
  Future<bool> requestPermissions() async {
    await initialize();
    if (!_isSupportedPlatform) {
      return false;
    }

    final androidImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    return await androidImplementation?.requestNotificationsPermission() ??
        false;
  }

  @override
  Future<String?> consumeInitialTapPayload() async {
    await initialize();
    final payload = _initialTapPayload;
    _initialTapPayload = null;
    return payload;
  }

  @override
  Future<void> syncSmartReminders(List<Reminder> reminders) async {
    await initialize();
    if (!_isSupportedPlatform) {
      return;
    }

    final smartReminders = reminders
        .where((reminder) => reminder.id.startsWith('smart-'))
        .toList(growable: false);
    final reminderIds = smartReminders.map((reminder) => reminder.id).toSet();

    final pendingRequests = await _plugin.pendingNotificationRequests();
    for (final pendingRequest in pendingRequests) {
      final payload = pendingRequest.payload ?? '';
      if (!payload.startsWith('smart-') || reminderIds.contains(payload)) {
        continue;
      }
      await _plugin.cancel(_notificationIdFor(payload));
    }

    for (final reminder in smartReminders) {
      final notificationId = _notificationIdFor(reminder.id);
      if (!reminder.isEnabled) {
        await _plugin.cancel(notificationId);
        continue;
      }

      await _plugin.zonedSchedule(
        notificationId,
        reminder.title,
        _bodyForReminder(reminder),
        _nextInstance(reminder.timeOfDay),
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
            category: _categoryFor(reminder.type),
            ticker: reminder.title,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: reminder.id,
      );
    }
  }

  @override
  void dispose() {
    _tapEventsController.close();
  }

  tz.TZDateTime _nextInstance(String timeOfDay) {
    final now = tz.TZDateTime.now(tz.local);
    final parts = timeOfDay.split(':');
    final hour = parts.isNotEmpty ? int.tryParse(parts.first) ?? 9 : 9;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;

    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  int _notificationIdFor(String rawId) {
    var hash = 0x811c9dc5;
    for (final codeUnit in rawId.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x01000193) & 0x7fffffff;
    }
    return hash;
  }

  String _bodyForReminder(Reminder reminder) {
    return switch (reminder.type) {
      ReminderType.water => 'Open Forge and log a quick hydration check-in.',
      ReminderType.meal =>
        'Open Forge and tighten up your nutrition target for today.',
      ReminderType.workout =>
        'Open Forge and review the next training move before the day drifts.',
      ReminderType.weighIn =>
        'Open Forge and capture a body progress check-in.',
      ReminderType.sleep =>
        'Open Forge and protect tonight\'s recovery window.',
      ReminderType.progressCheck =>
        'Open Forge and review your current progress or health status.',
    };
  }

  AndroidNotificationCategory _categoryFor(ReminderType type) {
    return switch (type) {
      ReminderType.water => AndroidNotificationCategory.reminder,
      ReminderType.meal => AndroidNotificationCategory.reminder,
      ReminderType.workout => AndroidNotificationCategory.workout,
      ReminderType.weighIn => AndroidNotificationCategory.status,
      ReminderType.sleep => AndroidNotificationCategory.reminder,
      ReminderType.progressCheck => AndroidNotificationCategory.status,
    };
  }
}

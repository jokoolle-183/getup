import 'dart:async';
import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:getup/main.dart';
import 'package:getup/ring.dart';
import 'package:permission_handler/permission_handler.dart';

StreamSubscription<AlarmSettings>? ringStream;

class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({super.key});

  @override
  State<AlarmListScreen> createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  late List<AlarmSettings> alarms;
  @override
  void initState() {
    super.initState();
    loadAlarms();
    checkAndroidNotificationPermission();
    _isAndroidPermissionGranted();
    checkAndroidScheduleExactAlarmPermission();
    ignoreBatteryOptimizationsPermission();
    openBatteryOptimizationSettings();
    ringStream ??= Alarm.ringStream.stream.listen((AlarmSettings data) {
      navigateToRingScreen(data);
    });
  }

  @override
  void dispose() {
    ringStream?.cancel();
    super.dispose();
  }

  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not '}granted',
      );
    }
  }

  void _requestPermissions() async {
    PermissionStatus status = await Permission.activityRecognition.request();

    if (status.isGranted) {
      print('Permission GRANTED');
    } else {
      // Handle the case when permission is not granted
      print('Permission not granted');
    }
  }

  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    alarmPrint('Schedule exact alarm permission: $status.');
    if (status.isDenied) {
      alarmPrint('Requesting schedule exact alarm permission...');
      final res = await Permission.scheduleExactAlarm.request();
      alarmPrint(
        'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted',
      );
    }
  }

  Future<void> ignoreBatteryOptimizationsPermission() async {
    final status = await Permission.ignoreBatteryOptimizations.status;
    alarmPrint('Ignore battery optimization permission: $status.');
    if (status.isDenied) {
      alarmPrint('Requesting schedule exact alarm permission...');
      final res = await Permission.ignoreBatteryOptimizations.request();
      alarmPrint(
        'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted',
      );
    }
  }

  void openBatteryOptimizationSettings() {
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
        data:
            'package:com.example.getup', // Replace YOUR_PACKAGE_NAME with your app's package name
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );

      intent.launch().catchError((e) {
        print("Error launching battery optimization settings: $e");
      });
    }
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.pushNamed(
      context,
      RingAlarmScreen.routeName,
      arguments: alarmSettings,
    ).then((value) => loadAlarms());
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Next alarm: Alarm ${alarms.firstOrNull?.id} at ${alarms.firstOrNull?.dateTime}',
        ),
      ),
    );
  }
}

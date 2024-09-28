import 'dart:async';
import 'dart:io';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_item.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_item_card.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_list_cubit.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_list_state.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';
import 'package:walk_it_up/presentation/create_new_alarm/create_new_alarm_screen.dart';
import 'package:walk_it_up/presentation/edit_alarm/edit_alarm_screen.dart';
import 'package:walk_it_up/main.dart';
import 'package:walk_it_up/presentation/ring_alarm/ring_alarm_screen.dart';

StreamSubscription<AlarmSettings>? ringStream;

class AlarmListScreen extends StatefulWidget {
  static const routeName = '/alarm-list';
  const AlarmListScreen({super.key});

  @override
  State<AlarmListScreen> createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  @override
  void initState() {
    super.initState();
    checkAndroidNotificationPermission();
    _isAndroidPermissionGranted();
    checkAndroidScheduleExactAlarmPermission();
    _requestPermissions();
    // ignoreBatteryOptimizationsPermission();
    // openBatteryOptimizationSettings();
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
      AndroidIntent intent = const AndroidIntent(
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
    );
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlarmListCubit(
        getIt.get<AlarmSetRepository>(),
        getIt.get<RegularAlarmRepository>(),
      ),
      child: BlocBuilder<AlarmListCubit, AlarmListState>(
        builder: (context, state) => Scaffold(
          body: Scaffold(
            body: Builder(
              builder: (context) {
                if (state.alarmItems.isEmpty) {
                  return const Center(
                    child: Text('No alarms have been set.'),
                  );
                } else {
                  return ListView.builder(
                      itemCount: state.alarmItems.length,
                      itemBuilder: (context, i) => AlarmItemCard(
                            alarmItem: state.alarmItems[i],
                            navigateToEditAlarm: navigateToEditAlarm,
                          ));
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => navigateToCreateNewAlarm()),
        ),
      ),
    );
  }

  Future<void> navigateToEditAlarm({AlarmItem? alarmItem}) async {
    await Navigator.pushNamed(
      context,
      EditAlarmScreen.routeName,
      arguments: alarmItem,
    );
  }

  Future<void> navigateToCreateNewAlarm() async {
    await Navigator.pushNamed(context, CreateNewAlarmScreen.route);
  }
}

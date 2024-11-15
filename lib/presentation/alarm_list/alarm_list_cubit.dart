import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';
import 'package:walk_it_up/main.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_item.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_list_state.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';

class AlarmListCubit extends Cubit<AlarmListState> {
  final AlarmSetRepository _alarmSetRepository;
  final RegularAlarmRepository _regularAlarmRepository;

  AlarmListCubit(
    this._alarmSetRepository,
    this._regularAlarmRepository,
  ) : super(AlarmListState.initial()) {
    loadAlarms();
    checkAllPermissions();
  }

  Future<void> checkAllPermissions() async {
    await checkAndroidNotificationPermission();
    await checkAndroidScheduleExactAlarmPermission();
    await _requestPermissions();
  }

  void loadAlarms() async {
    final alarms = await _regularAlarmRepository.getRegularAlarms();
    final alarmSets = await _alarmSetRepository.getAlarmSets();

    final regularAlarmItems = alarms
        .map(
          (alarm) => AlarmItem.regular(
            alarm.id,
            'Regular Alarm',
            DateFormat('HH:mm').format(alarm.alarmInstance.time),
          ),
        )
        .toList();

    final alarmSetItems = alarmSets
        .map((set) => AlarmItem.set(
              set.id,
              'Alarm Set',
              DateFormat('HH:mm').format(set.startTime),
              DateFormat('HH:mm').format(set.endTime),
            ))
        .toList();

    final alarmItems = [...regularAlarmItems, ...alarmSetItems];
    emit(state.copyWith(alarmItems: alarmItems, isLoading: false));
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

  Future<void> _requestPermissions() async {
    final status = await Permission.activityRecognition.status;

    if (status.isDenied) {}
    try {
      print("Requesting activity recognition permission...");
      final res = await Permission.activityRecognition.request();
      print("Activity recognition permission granted: ${status.isGranted}");
    } on Exception catch (e) {
      print("Exception caught: $e");
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
}

import 'dart:convert';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walk_it_up/data/alarm_details_model.dart';
import 'package:walk_it_up/constants.dart';
import 'package:walk_it_up/data/repository/alarm_repository.dart';
import 'package:walk_it_up/presentation/edit_alarm/durations.dart';
import 'package:walk_it_up/presentation/edit_alarm/edit_alarm_state.dart';

class EditAlarmCubit extends Cubit<EditAlarmState> {
  final int? alarmId;
  final AlarmRepository _alarmRepository;

  EditAlarmCubit(
    this._alarmRepository,
    this.alarmId,
  ) : super(EditAlarmState.initial()) {
    _loadInitial(alarmId: alarmId);
  }

  void selectFocusDuration(FocusDuration focusDuration) {
    emit(state.copyWith(focusDuration: focusDuration));
  }

  void selectFromTimeOfDay(TimeOfDay fromTimeOfDay) {
    emit(state.copyWith(fromTimeOfDay: fromTimeOfDay));
  }

  void selectToTimeOfDay(TimeOfDay toTimeOfDay) {
    emit(state.copyWith(toTimeOfDay: toTimeOfDay));
  }

  void _loadInitial({int? alarmId}) async {
    final prefs = await SharedPreferences.getInstance();
    final focusDurationIndex =
        prefs.getInt(FOCUS_DURATION_KEY) ?? FocusDuration.sixty.index;
    final fromTimeOfDay = await _getTimeOfDayFromPrefs(FROM_TIME_OF_DAY_KEY);
    final toTimeOfDay = await _getTimeOfDayFromPrefs(TO_TIME_OF_DAY_KEY);

    final alarmsJson = prefs.getString(ALARMS);
    AlarmDetails? nextAlarm;
    if (alarmsJson != null) {
      final alarms = decodeAlarmDetailsList(alarmsJson);
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
      nextAlarm = alarms.firstOrNull;
    }

    emit(state.copyWith(
      alarmId: alarmId,
      focusDuration: FocusDuration.values[focusDurationIndex],
      fromTimeOfDay: fromTimeOfDay,
      toTimeOfDay: toTimeOfDay,
      nextAlarm: nextAlarm,
    ));
  }

  void setAlarms() async {
    final FocusDuration focusDuration = state.focusDuration;
    final DateTime selectedFromTime =
        _convertTimeOfDayToDateTime(state.fromTimeOfDay);
    final DateTime selectedToTime =
        _convertTimeOfDayToDateTime(state.toTimeOfDay);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Duration difference = selectedToTime.difference(selectedFromTime);
    int occurrences = difference.inMinutes ~/ focusDuration.duration;
    List<AlarmDetails> list = [];

    for (int i = 0; i <= occurrences; i++) {
      DateTime newTime =
          selectedFromTime.add(Duration(minutes: focusDuration.duration * i));
      print("$newTime");
      final alarmDetails = AlarmDetails(
        id: UniqueKey().hashCode,
        dateTime: newTime,
        assetAudioPath: 'assets/perfect_alarm.mp3',
        loopAudio: true,
        vibrate: true,
        fadeDuration: 3.0,
        notificationTitle: 'Getup',
        notificationBody: 'Getcho ass up',
        enableNotificationOnKill: true,
      );
      list.add(alarmDetails);
    }

    list.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);

    if (list.isNotEmpty) {
      var nextAlarm = list.first;
      await Alarm.set(
        alarmSettings: AlarmSettings(
          id: nextAlarm.id,
          vibrate: false,
          dateTime: nextAlarm.dateTime,
          assetAudioPath: nextAlarm.assetAudioPath,
          notificationTitle: nextAlarm.notificationTitle,
          notificationBody: nextAlarm.notificationBody,
        ),
      );

      String encodedList = _encodeAlarmDetailsList(list);
      prefs.setString(ALARMS, encodedList);
      prefs.setInt(FOCUS_DURATION_KEY, state.focusDuration.index);
      prefs.setString(
          FROM_TIME_OF_DAY_KEY, timeOfDayToString(state.fromTimeOfDay));
      prefs.setString(TO_TIME_OF_DAY_KEY, timeOfDayToString(state.toTimeOfDay));
      emit(state.copyWith(nextAlarm: nextAlarm));
    }
  }

  void stopAllAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    await Alarm.stopAll();
    await prefs.remove(ALARMS);
    _loadInitial();
  }

  String _encodeAlarmDetailsList(List<AlarmDetails> alarms) {
    return jsonEncode(alarms.map((alarm) => alarm.toJson()).toList());
  }

  Future<TimeOfDay> _getTimeOfDayFromPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final timeString = prefs.getString(key);
    if (timeString != null) {
      final parts = timeString.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    }
    return TimeOfDay.fromDateTime(DateTime.now());
  }

  String timeOfDayToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  List<AlarmDetails> decodeAlarmDetailsList(String jsonString) {
    return (jsonDecode(jsonString) as List<dynamic>)
        .map<AlarmDetails>((item) => AlarmDetails.fromJson(item))
        .toList();
  }

  DateTime _convertTimeOfDayToDateTime(TimeOfDay timeOfDay, [DateTime? date]) {
    final currentDate = date ?? DateTime.now();
    return DateTime(currentDate.year, currentDate.month, currentDate.day,
        timeOfDay.hour, timeOfDay.minute);
  }
}

import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getup/alarm_details.dart';
import 'package:getup/constants.dart';
import 'package:getup/edit_alarm/durations.dart';
import 'package:getup/edit_alarm/edit_alarm_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAlarmCubit extends Cubit<EditAlarmState> {
  EditAlarmCubit() : super(EditAlarmState.initial()) {
    _loadInitial();
  }

  void _loadInitial() async {
    final prefs = await SharedPreferences.getInstance();
    final focusDurationIndex =
        prefs.getInt(FOCUS_DURATION_KEY) ?? FocusDuration.sixty.index;
    final breakDurationIndex =
        prefs.getInt(BREAK_DURATION_KEY) ?? BreakDuration.ten.index;
    final fromDate = await getDateTimeFromPrefs(FROM_DATE_KEY);
    final toDate = await getDateTimeFromPrefs(TO_DATE_KEY);
    final alarmsJson = prefs.getString(ALARMS);

    AlarmDetails? nextAlarm;
    if (alarmsJson != null) {
      final alarms = decodeAlarmDetailsList(alarmsJson);
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
      nextAlarm = alarms.first;
    }
    emit(state.copyWith(
      focusDuration: FocusDuration.values[focusDurationIndex],
      breakDuration: BreakDuration.values[breakDurationIndex],
      fromDate: fromDate,
      toDate: toDate,
      nextAlarm: nextAlarm,
    ));
  }

  void selectFocusDuration(FocusDuration focusDuration) {
    emit(state.copyWith(focusDuration: focusDuration));
  }

  void selectBreakDuration(BreakDuration breakDuration) {
    emit(state.copyWith(breakDuration: breakDuration));
  }

  void selectFromDate(DateTime fromDate) {
    emit(state.copyWith(fromDate: fromDate));
  }

  void selectToDate(DateTime toDate) {
    emit(state.copyWith(toDate: toDate));
  }

  void setAlarms() async {
    final FocusDuration focusDuration = state.focusDuration;
    final DateTime selectedFromTime = state.fromDate;
    final DateTime selectedToTime = state.toDate;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Duration difference = selectedToTime.difference(selectedFromTime);
    int occurrences = difference.inMinutes ~/ focusDuration.duration;
    List<AlarmDetails> list = [];

    for (int i = 0; i < occurrences; i++) {
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
      var nextAlarm = list.removeAt(0);
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
      emit(state.copyWith(nextAlarm: nextAlarm));
      prefs.setString(ALARMS, encodedList);
      prefs.setInt(FOCUS_DURATION_KEY, state.focusDuration.index);
      prefs.setInt(BREAK_DURATION_KEY, state.breakDuration.index);
      prefs.setString(FROM_DATE_KEY, state.fromDate.toIso8601String());
      prefs.setString(TO_DATE_KEY, state.toDate.toIso8601String());
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

  Future<DateTime> getDateTimeFromPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String? dateTimeString = prefs.getString(key);
    if (dateTimeString != null) {
      return DateTime.parse(dateTimeString);
    }
    return DateTime.now();
  }

  List<AlarmDetails> decodeAlarmDetailsList(String jsonString) {
    return (jsonDecode(jsonString) as List<dynamic>)
        .map<AlarmDetails>((item) => AlarmDetails.fromJson(item))
        .toList();
  }
}

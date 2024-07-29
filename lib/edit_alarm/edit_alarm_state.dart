import 'package:getup/alarm_details.dart';
import 'package:getup/edit_alarm/durations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'edit_alarm_state.freezed.dart';

@freezed
class EditAlarmState with _$EditAlarmState {
  factory EditAlarmState({
    required FocusDuration focusDuration,
    required BreakDuration breakDuration,
    required DateTime fromDate,
    required DateTime toDate,
    AlarmDetails? nextAlarm,
  }) = _EditAlarmState;

  factory EditAlarmState.initial() => EditAlarmState(
        focusDuration: FocusDuration.sixty,
        breakDuration: BreakDuration.ten,
        fromDate: DateTime.now().copyWith(hour: 9, minute: 0),
        toDate: DateTime.now().copyWith(hour: 17, minute: 0),
      );
}

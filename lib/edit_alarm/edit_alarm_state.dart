import 'package:flutter/material.dart';
import 'package:getup/alarm_details.dart';
import 'package:getup/edit_alarm/durations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'edit_alarm_state.freezed.dart';

@freezed
class EditAlarmState with _$EditAlarmState {
  factory EditAlarmState({
    required FocusDuration focusDuration,
    required TimeOfDay fromTimeOfDay,
    required TimeOfDay toTimeOfDay,
    AlarmDetails? nextAlarm,
  }) = _EditAlarmState;

  factory EditAlarmState.initial() => EditAlarmState(
        focusDuration: FocusDuration.sixty,
        fromTimeOfDay:
            TimeOfDay.fromDateTime(DateTime.now().copyWith(hour: 9, minute: 0)),
        toTimeOfDay: TimeOfDay.fromDateTime(
            DateTime.now().copyWith(hour: 17, minute: 0)),
      );
}

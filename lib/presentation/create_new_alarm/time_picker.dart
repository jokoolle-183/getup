import 'package:flutter/material.dart';
import 'package:walk_it_up/presentation/create_new_alarm/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm/recurring_picker.dart';
import 'package:walk_it_up/presentation/create_new_alarm/time_wheel_picker.dart';

abstract class TimePicker {
  Widget buildPicker();
}

class RegularAlarmPicker implements TimePicker {
  @override
  Widget buildPicker() {
    return const TimeWheelPicker();
  }
}

class RecurringAlarmPicker implements TimePicker {
  @override
  Widget buildPicker() {
    return const RecurringPicker();
  }
}

class TimePickerFactory {
  static TimePicker getPicker(AlarmType type) {
    switch (type) {
      case AlarmType.regular:
        return RegularAlarmPicker();
      case AlarmType.recurringDaily:
        return RecurringAlarmPicker();
      default:
        throw Exception("Unknown alarm type");
    }
  }
}

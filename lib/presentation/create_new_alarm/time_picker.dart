import 'package:flutter/material.dart';
import 'package:walk_it_up/presentation/create_new_alarm/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm/create_new_alarm_state.dart';
import 'package:walk_it_up/presentation/create_new_alarm/pair.dart';
import 'package:walk_it_up/presentation/create_new_alarm/recurring_picker.dart';
import 'package:walk_it_up/presentation/create_new_alarm/time_wheel_picker.dart';

typedef TimePickerCallback = Pair<Function(String), Function(String)>;

abstract class TimePicker {
  abstract TimePickerCallback callback;
  Widget buildPicker();
}

class RegularAlarmPicker implements TimePicker {
  RegularAlarmPicker(
    this.callback,
  );

  @override
  TimePickerCallback callback;

  @override
  Widget buildPicker() {
    return TimeWheelPicker(
      onTimeSelected: callback.left,
    );
  }
}

class RecurringAlarmPicker implements TimePicker {
  RecurringAlarmPicker(this.callback);

  @override
  TimePickerCallback callback;

  @override
  Widget buildPicker() {
    return RecurringPicker(
      onTimeSelected: callback,
    );
  }
}

class TimePickerFactory {
  static TimePicker getPicker(
    AlarmType type,
    TimePickerCallback callback,
  ) {
    switch (type) {
      case AlarmType.regular:
        return RegularAlarmPicker(callback);
      case AlarmType.recurringDaily:
        return RecurringAlarmPicker(callback);
      default:
        throw Exception("Unknown alarm type");
    }
  }
}

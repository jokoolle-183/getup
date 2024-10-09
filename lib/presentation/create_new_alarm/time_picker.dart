import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/presentation/create_new_alarm/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm/pair.dart';
import 'package:walk_it_up/presentation/create_new_alarm/recurring_picker.dart';
import 'package:walk_it_up/presentation/create_new_alarm/regular_alarm_picker/time_picker_cubit.dart';
import 'package:walk_it_up/presentation/create_new_alarm/regular_alarm_picker/time_picker_state.dart';
import 'package:walk_it_up/presentation/create_new_alarm/time_wheel_picker_component.dart';

typedef TimePickerCallback = Pair<Function(String), Function(String)>;

abstract class TimePicker {
  abstract TimePickerCubit timePickerCubit;
  Widget buildPicker();
}

class RegularAlarmPicker implements TimePicker {
  RegularAlarmPicker(this.timePickerCubit);

  @override
  TimePickerCubit timePickerCubit;

  @override
  Widget buildPicker() {
    return BlocBuilder<TimePickerCubit, TimePickerState>(
      builder: (context, state) => TimeWheelPickerComponent(
        onTimeSelected: timePickerCubit.onTimeSelected,
        selectedHour: state.baseTimeHoursIndex,
        selectedMinute: state.baseTimeMinutesIndex,
      ),
    );
  }
}

class RecurringAlarmPicker implements TimePicker {
  RecurringAlarmPicker(this.timePickerCubit);

  @override
  TimePickerCubit timePickerCubit;
  @override
  Widget buildPicker() {
    return RecurringPicker(
      onStartTimeSelected: timePickerCubit.onTimeSelected,
      onEndTimeSelected: timePickerCubit.onEndTimeSelected,
    );
  }
}

class TimePickerFactory {
  static TimePicker getPicker(
    AlarmType type,
    TimePickerCubit cubit,
  ) {
    switch (type) {
      case AlarmType.regular:
        return RegularAlarmPicker(cubit);
      case AlarmType.recurringDaily:
        return RecurringAlarmPicker(cubit);
      default:
        throw Exception("Unknown alarm type");
    }
  }
}

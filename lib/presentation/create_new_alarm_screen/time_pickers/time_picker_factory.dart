import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/alarm_type/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/recurring_picker.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/time_picker_cubit.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/time_picker_state.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/time_wheel_picker.dart';

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
      builder: (context, state) => TimeWheelPicker(
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

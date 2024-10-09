import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/time_picker_cubit.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/time_picker_state.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/time_wheel_picker.dart';

class RecurringPicker extends StatelessWidget {
  const RecurringPicker({
    super.key,
    required this.onStartTimeSelected,
    required this.onEndTimeSelected,
  });

  final Function(String, Pair<int, int>) onStartTimeSelected;
  final Function(String, Pair<int, int>) onEndTimeSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimePickerCubit, TimePickerState>(
      builder: (context, state) => Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Start time',
                  style: TextStyle(fontSize: 20),
                ),
                TimeWheelPicker(
                  onTimeSelected: onStartTimeSelected,
                  selectedHour: state.baseTimeHoursIndex,
                  selectedMinute: state.baseTimeMinutesIndex,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'End time',
                  style: TextStyle(fontSize: 20),
                ),
                TimeWheelPicker(
                  onTimeSelected: onEndTimeSelected,
                  selectedHour: state.endTimeHoursIndex,
                  selectedMinute: state.endTimeMinutesIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

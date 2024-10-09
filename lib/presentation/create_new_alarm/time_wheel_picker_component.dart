import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:walk_it_up/presentation/create_new_alarm/pair.dart';
import 'package:walk_it_up/presentation/create_new_alarm/time_wheel_picker.dart';

class TimeWheelPickerComponent extends StatelessWidget {
  const TimeWheelPickerComponent({
    this.selectedHour,
    this.selectedMinute,
    super.key,
    required this.onTimeSelected,
  });

  final int? selectedHour;
  final int? selectedMinute;
  final Function(String, Pair<int, int>) onTimeSelected;

  @override
  Widget build(BuildContext context) {
    return TimeWheelPicker(
      selectedHour: selectedHour,
      selectedMinute: selectedMinute,
      onTimeSelected: onTimeSelected,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:walk_it_up/presentation/create_new_alarm/time_picker.dart';
import 'package:walk_it_up/presentation/create_new_alarm/time_wheel_picker.dart';

class RecurringPicker extends StatelessWidget {
  const RecurringPicker({
    required this.onTimeSelected,
    super.key,
  });

  final TimePickerCallback onTimeSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const Text(
                'Start time',
                style: TextStyle(fontSize: 20),
              ),
              TimeWheelPicker(onTimeSelected: onTimeSelected.left),
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
              TimeWheelPicker(onTimeSelected: onTimeSelected.right),
            ],
          ),
        ),
      ],
    );
  }
}

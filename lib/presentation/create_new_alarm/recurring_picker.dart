import 'package:flutter/material.dart';
import 'package:walk_it_up/presentation/create_new_alarm/time_wheel_picker.dart';

class RecurringPicker extends StatelessWidget {
  const RecurringPicker({super.key});
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'Start time',
                style: TextStyle(fontSize: 20),
              ),
              TimeWheelPicker(),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'End time',
                style: TextStyle(fontSize: 20),
              ),
              TimeWheelPicker(),
            ],
          ),
        ),
      ],
    );
  }
}

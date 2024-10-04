import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:walk_it_up/presentation/create_new_alarm/create_new_alarm_state.dart';

class TimeWheelPicker extends StatefulWidget {
  const TimeWheelPicker({
    required this.onTimeSelected,
    super.key,
  });
  final Function(String) onTimeSelected;

  @override
  State<TimeWheelPicker> createState() => _TimeWheelPickerState();
}

class _TimeWheelPickerState extends State<TimeWheelPicker> {
  late FixedExtentScrollController _hoursController;
  late FixedExtentScrollController _minutesController;

  String _hourString = '';
  String _minuteString = '';

  @override
  void initState() {
    super.initState();
    _hoursController = FixedExtentScrollController();
    _minutesController = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Color.fromARGB(255, 211, 222, 227),
                ),
                width: MediaQuery.of(context).size.width,
                height: 50,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 220,
                  child: ListWheelScrollView(
                    physics: const FixedExtentScrollPhysics(),
                    itemExtent: 50,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    overAndUnderCenterOpacity: 0.5,
                    onSelectedItemChanged: (index) {
                      _hourString = getHourStrings()[index];
                      widget.onTimeSelected('$_hourString:$_minuteString');
                    },
                    children: [
                      ...getHourStrings().map((e) => Align(
                            alignment: Alignment.center,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 30),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 220,
                  child: ListWheelScrollView(
                    itemExtent: 50,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    overAndUnderCenterOpacity: 0.5,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      _minuteString = getMinuteStrings()[index];
                      widget.onTimeSelected('$_hourString:$_minuteString');
                    },
                    children: [
                      ...getMinuteStrings().map((e) => Align(
                            alignment: Alignment.center,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 30),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<String> getHourStrings() {
  List<String> hourList = [];

  // Loop through hours from 0 to 23
  for (int hour = 0; hour < 24; hour++) {
    // Format the hour as a two-digit string
    hourList.add(hour.toString().padLeft(2, '0'));
  }

  return hourList;
}

List<String> getMinuteStrings() {
  List<String> minuteList = [];

  // Loop through minutes from 0 to 59
  for (int minute = 0; minute < 60; minute++) {
    // Format the minute as a two-digit string
    minuteList.add(minute.toString().padLeft(2, '0'));
  }

  return minuteList;
}

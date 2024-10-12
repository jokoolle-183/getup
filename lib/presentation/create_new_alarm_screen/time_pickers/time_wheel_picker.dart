import 'package:flutter/widgets.dart';
import 'package:walk_it_up/debouncer.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';

class TimeWheelPicker extends StatefulWidget {
  const TimeWheelPicker({
    required this.onTimeSelected,
    this.selectedHour,
    this.selectedMinute,
    super.key,
  });

  final int? selectedHour;
  final int? selectedMinute;
  final Function(String, Pair<int, int>) onTimeSelected;

  @override
  State<TimeWheelPicker> createState() => _TimeWheelPickerState();
}

class _TimeWheelPickerState extends State<TimeWheelPicker> {
  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 300));
  late FixedExtentScrollController _hoursController;
  late FixedExtentScrollController _minutesController;

  @override
  void initState() {
    super.initState();
    _hoursController = _hoursController = FixedExtentScrollController(
        initialItem: widget.selectedHour != null
            ? widget.selectedHour!
            : getHourStrings()
                .indexOf(getHourStringFromInt(DateTime.now().hour)));
    _minutesController = FixedExtentScrollController(
        initialItem: widget.selectedMinute != null
            ? widget.selectedMinute!
            : getMinuteStrings()
                .indexOf(getMinuteStringFromInt(DateTime.now().minute)));
  }

  @override
  void dispose() {
    super.dispose();
    _hoursController.dispose();
    _minutesController.dispose();
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
                    controller: _hoursController,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    overAndUnderCenterOpacity: 0.5,
                    onSelectedItemChanged: (index) {
                      _debouncer.call(() => widget.onTimeSelected(
                          '${getHourStrings()[_hoursController.selectedItem]}:${getMinuteStrings()[_minutesController.selectedItem]}',
                          Pair(index, _minutesController.selectedItem)));
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
                    controller: _minutesController,
                    onSelectedItemChanged: (index) {
                      _debouncer.call(() => widget.onTimeSelected(
                          '${getHourStrings()[_hoursController.selectedItem]}:${getMinuteStrings()[_minutesController.selectedItem]}',
                          Pair(_hoursController.selectedItem, index)));
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

String getHourStringFromInt(int hour) {
  if (hour < 10) {
    return "0$hour";
  } else {
    return hour.toString();
  }
}

String getMinuteStringFromInt(int minute) {
  if (minute < 10) {
    return "0$minute";
  } else {
    return minute.toString();
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

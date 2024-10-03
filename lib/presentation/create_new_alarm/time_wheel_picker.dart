import 'package:flutter/material.dart';

class TimeWheelPicker extends StatelessWidget {
  const TimeWheelPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 42,
              color: const Color.fromARGB(255, 173, 184, 190),
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
                  height: 200,
                  child: ListWheelScrollView(
                    physics: const FixedExtentScrollPhysics(),
                    itemExtent: 42,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    overAndUnderCenterOpacity: 0.5,
                    children: [
                      ...getHourStrings().map((e) => Align(
                            alignment: Alignment.center,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 200,
                  child: ListWheelScrollView(
                    itemExtent: 42,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    overAndUnderCenterOpacity: 0.5,
                    physics: const FixedExtentScrollPhysics(),
                    children: [
                      ...getMinuteStrings().map((e) => Align(
                            alignment: Alignment.center,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 28),
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

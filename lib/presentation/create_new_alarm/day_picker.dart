import 'package:flutter/material.dart';
import 'package:walk_it_up/data/model/weekdays.dart';

class DayPicker extends StatelessWidget {
  const DayPicker({
    required this.selectedDays,
    required this.onSelected,
    super.key,
  });

  final List<Weekday> selectedDays;
  final Function(Weekday weekday) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
              child: Text("Every ${joinDays()}"),
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...Weekday.values.map(
                (day) => Material(
                  shape: const CircleBorder(),
                  color: selectedDays.contains(day)
                      ? const Color.fromARGB(255, 71, 114, 213)
                      : Colors.white,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => onSelected(day),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color.fromARGB(255, 71, 114, 213),
                            width: 0.5),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          day.abbreviation.characters.first,
                          style: TextStyle(
                            color: selectedDays.contains(day)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  String joinDays() {
    if (selectedDays.length == Weekday.values.length) {
      return 'day';
    } else {
      return selectedDays.map((day) => day.abbreviation).join(', ');
    }
  }
}

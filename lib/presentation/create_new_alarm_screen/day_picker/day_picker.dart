import 'package:flutter/material.dart';
import 'package:walk_it_up/data/model/weekdays.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';

class DayPicker extends StatelessWidget {
  const DayPicker({
    required this.selectedDays,
    required this.onSelected,
    required this.selectedTime,
    super.key,
  });

  final List<Weekday> selectedDays;
  final Pair<String, String> selectedTime;
  final Function(Weekday weekday) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
              child: Text(determineDate(selectedDays, selectedTime.left)),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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

  //TODO: Move this to the Cubit and just propagate the text as part of state
  String determineDate(List<Weekday> selectedDays, String selectedTime) {
    var text = '';
    final selectedDateTime = convertStringToDate(selectedTime);

    final selected = {...selectedDays};
    final weekdays = {
      Weekday.monday,
      Weekday.tuesday,
      Weekday.wednesday,
      Weekday.thursday,
      Weekday.friday
    };
    final weekends = {Weekday.saturday, Weekday.sunday};

    if (selectedDays.isEmpty) {
      final now = DateTime.now();
      if (selectedDateTime.isAfter(now)) {
        text = 'Today';
      } else {
        text = 'Tomorrow';
      }
      return text;
    }

    if (selected.containsAll(weekends) && selected.containsAll(weekdays)) {
      text = 'Every day';
    } else if (selectedDays.toSet().difference(weekdays).isEmpty &&
        selectedDays.length == weekdays.length) {
      text = 'Weekdays';
    }
    // Check if the selected days are only weekends
    else if (selectedDays.toSet().difference(weekends).isEmpty &&
        selectedDays.length == weekends.length) {
      text = 'Weekends';
    } else {
      text = 'Every ${selectedDays.map((day) => day.abbreviation).join(', ')}';
    }

    return text;
  }

  DateTime convertStringToDate(String selectedTime) {
    // Determine if selected time is before now or after
    print("Convert string to date, selectedTime: $selectedTime");
    final now = DateTime.now();
    final hoursAndMinutes = selectedTime.split(':');
    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(hoursAndMinutes[0]),
      int.parse(hoursAndMinutes[1]),
    );

    return selectedDateTime;
  }
}

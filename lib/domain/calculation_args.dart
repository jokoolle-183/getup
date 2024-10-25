import 'package:walk_it_up/data/model/weekdays.dart';

class CalculationArgs {
  final String selectedTime;
  final List<Weekday> daysOfWeek;

  const CalculationArgs({
    required this.selectedTime,
    required this.daysOfWeek,
  });

  CalculationArgs copyWith({
    String? selectedTime,
    List<Weekday>? daysOfWeek,
  }) {
    return CalculationArgs(
      selectedTime: selectedTime ?? this.selectedTime,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }
}

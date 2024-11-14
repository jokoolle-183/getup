import 'package:walk_it_up/data/model/weekdays.dart';

class AlarmConfig {
  final DateTime? selectedTime;
  final List<Weekday> daysOfWeek;
  final String soundPath;
  final int snoozeDuration;
  final bool isVibrate;

  const AlarmConfig({
    required this.selectedTime,
    required this.daysOfWeek,
    required this.isVibrate,
    required this.snoozeDuration,
    required this.soundPath,
  });

  AlarmConfig copyWith({
    DateTime? selectedTime,
    List<Weekday>? daysOfWeek,
    String? soundPath,
    bool? isVibrate,
    int? snoozeDuration,
  }) {
    return AlarmConfig(
      selectedTime: selectedTime ?? this.selectedTime,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      soundPath: soundPath ?? this.soundPath,
      isVibrate: isVibrate ?? this.isVibrate,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
    );
  }
}

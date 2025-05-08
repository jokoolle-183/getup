import 'package:walk_it_up/data/model/weekdays.dart';

class AlarmSetArgs {
  final DateTime startTime;
  final DateTime endTime;
  final String audioPath;
  final List<Weekday>? daysOfWeek;
  final int intervalBetweenAlarms;
  final int? pauseDuration;
  final List<DateTime> recurringAlarmDates;

  const AlarmSetArgs({
    required this.startTime,
    required this.endTime,
    required this.intervalBetweenAlarms,
    required this.recurringAlarmDates,
    required this.audioPath,
    required this.daysOfWeek,
    this.pauseDuration,
  });

  AlarmSetArgs copyWith({
    DateTime? startTime,
    DateTime? endTime,
    String? audioPath,
    List<Weekday>? daysOfWeek,
    int? intervalBetweenAlarms,
    int? pauseDuration,
    List<DateTime>? recurringAlarmDates,
  }) {
    return AlarmSetArgs(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      audioPath: audioPath ?? this.audioPath,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      intervalBetweenAlarms:
          intervalBetweenAlarms ?? this.intervalBetweenAlarms,
      pauseDuration: pauseDuration ?? this.pauseDuration,
      recurringAlarmDates: recurringAlarmDates ?? this.recurringAlarmDates,
    );
  }
}

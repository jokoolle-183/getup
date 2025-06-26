import 'package:walk_it_up/data/model/weekdays.dart';

class AlarmSetConfig {
  final DateTime selectedStartTime;
  final DateTime selectedEndTime;
  final List<Weekday> daysOfWeek;
  final String audioPath;
  final Duration interval;
  final String soundPath;
  final int snoozeDuration;
  final bool isVibrate;
  final bool isEnabled;

  const AlarmSetConfig({
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.daysOfWeek,
    required this.interval,
    required this.isVibrate,
    required this.snoozeDuration,
    required this.soundPath,
    required this.audioPath,
    required this.isEnabled,
  });

  List<DateTime> get alarmDates => _createAlarmDatesInSet(selectedStartTime, selectedEndTime, interval);

  List<DateTime> _createAlarmDatesInSet(
    DateTime startAlarmDate,
    DateTime endAlarmDate,
    Duration interval,
  ) {
    final List<DateTime> list = [];

    final differenceInMinutes = endAlarmDate.difference(startAlarmDate).inMinutes;
    final numAlarms = differenceInMinutes / interval.inMinutes + 1;

    /// End time included

    for (int i = 0; i < numAlarms; i++) {
      list.add(startAlarmDate.add(interval));
    }

    list.forEach((date) => print("Alarm instance time: $date"));
    return list;
  }

  AlarmSetConfig copyWith({
    DateTime? selectedTime,
    DateTime? selectedEndTime,
    List<Weekday>? daysOfWeek,
    Duration? interval,
    String? soundPath,
    bool? isVibrate,
    int? snoozeDuration,
    String? audioPath,
    bool? isEnabled,
  }) {
    return AlarmSetConfig(
      selectedStartTime: selectedTime ?? this.selectedStartTime,
      selectedEndTime: selectedEndTime ?? this.selectedEndTime,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      interval: interval ?? this.interval,
      soundPath: soundPath ?? this.soundPath,
      isVibrate: isVibrate ?? this.isVibrate,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
      audioPath: audioPath ?? this.audioPath,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

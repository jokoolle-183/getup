import 'package:walk_it_up/data/model/weekdays.dart';

class AlarmSetConfig {
  final DateTime selectedStartTime;
  final DateTime selectedEndTime;
  final List<Weekday> daysOfWeek;
  final String audioPath;
  final Duration interval;
  final Duration breakDuration;
  final String soundPath;
  final int snoozeDuration;
  final bool isVibrate;
  final bool isEnabled;

  const AlarmSetConfig({
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.daysOfWeek,
    required this.interval,
    required this.breakDuration,
    required this.isVibrate,
    required this.snoozeDuration,
    required this.soundPath,
    required this.audioPath,
    required this.isEnabled,
  });

  List<DateTime> get alarmDates => _createAlarmDatesInSet(selectedStartTime, selectedEndTime, interval);

  /// Generates a list of alarm DateTime instances between [startAlarmDate] and [endAlarmDate].
  /// Alarms are scheduled at each [interval] plus [breakDuration].
  /// If the gap between the last calculated alarm and [endAlarmDate] is greater than or equal to 3/4 of the interval,
  /// a final alarm is added at [endAlarmDate] to ensure coverage of the full session without alarms being too close together.
  List<DateTime> _createAlarmDatesInSet(
    DateTime startAlarmDate,
    DateTime endAlarmDate,
    Duration interval,
  ) {
    final List<DateTime> list = [];
    final Duration step = interval + breakDuration;

    DateTime current = startAlarmDate;
    while (current.isBefore(endAlarmDate)) {
      list.add(current);
      current = current.add(step);
    }

    // Check if we should add a final alarm at endAlarmDate
    if (list.isNotEmpty) {
      final lastAlarm = list.last;
      final gap = endAlarmDate.difference(lastAlarm).inMinutes;
      final threshold = (interval.inMinutes * 0.75).round();

      // Only add if the gap is greater than or equal to 3/4 of the interval
      if (gap >= threshold) {
        list.add(endAlarmDate);
      }
    } else {
      // If no alarms were added (shouldn't happen), add the end time
      list.add(endAlarmDate);
    }

    for (var date in list) {
      print("Alarm instance time: $date");
    }
    return list;
  }

  AlarmSetConfig copyWith({
    DateTime? selectedTime,
    DateTime? selectedEndTime,
    List<Weekday>? daysOfWeek,
    Duration? interval,
    Duration? breakDuration,
    String? soundPath,
    bool? isVibrate,
    int? snoozeDuration,
    String? audioPath,
    bool? isEnabled,
  }) {
    return AlarmSetConfig(
      selectedStartTime: selectedTime ?? selectedStartTime,
      selectedEndTime: selectedEndTime ?? this.selectedEndTime,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      interval: interval ?? this.interval,
      breakDuration: breakDuration ?? this.breakDuration,
      soundPath: soundPath ?? this.soundPath,
      isVibrate: isVibrate ?? this.isVibrate,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
      audioPath: audioPath ?? this.audioPath,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

import 'package:walk_it_up/data/model/weekdays.dart';

class RegularAlarmModel {
  final String? name;
  final String audioPath;
  final DateTime time;
  final int? snoozeDuration;
  final List<Weekday>? daysOfWeek;

  const RegularAlarmModel({
    required this.time,
    required this.audioPath,
    this.daysOfWeek,
    this.snoozeDuration,
    this.name,
  });
}

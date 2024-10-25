import 'package:walk_it_up/data/model/weekdays.dart';

class AlarmArgs {
  final int? id;
  final String? name;
  final String audioPath;
  final DateTime time;
  final int? snoozeDuration;
  final List<Weekday>? daysOfWeek;

  const AlarmArgs({
    required this.time,
    required this.audioPath,
    this.id,
    this.daysOfWeek,
    this.snoozeDuration,
    this.name,
  });

  AlarmArgs copyWith({
    int? id,
    DateTime? time,
    String? audioPath,
    List<Weekday>? daysOfWeek,
    int? snoozeDuration,
    String? name,
  }) {
    return AlarmArgs(
      id: id ?? this.id,
      name: name ?? this.name,
      time: time ?? this.time,
      audioPath: audioPath ?? this.audioPath,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
    );
  }
}

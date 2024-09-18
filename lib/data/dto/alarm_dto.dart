import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/dto/weekdays.dart';

@immutable
class AlarmDto extends Equatable {
  final int id;
  final String? name;
  final String audioPath;
  final DateTime time;
  final int? snoozeDuration;
  final List<Weekday>? daysOfWeek;

  const AlarmDto._({
    required this.id,
    required this.time,
    required this.daysOfWeek,
    required this.snoozeDuration,
    required this.audioPath,
    this.name,
  });

  factory AlarmDto.fromDbAlarm(RegularAlarm alarm) => AlarmDto._(
        id: alarm.id,
        name: alarm.name,
        audioPath: alarm.audioPath,
        time: alarm.time,
        snoozeDuration: alarm.snoozeDuration,
        daysOfWeek: tryCast(alarm.daysOfWeek),
      );

  factory AlarmDto.fromAlarmCompanion(RegularAlarmsCompanion alarmCompanion) =>
      AlarmDto._(
        id: alarmCompanion.id.value,
        name: alarmCompanion.name.value,
        audioPath: alarmCompanion.audioPath.value,
        time: alarmCompanion.time.value,
        snoozeDuration: alarmCompanion.snoozeDuration.value,
        daysOfWeek: tryCast(alarmCompanion.daysOfWeek.value),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        audioPath,
        time,
        snoozeDuration,
        daysOfWeek,
      ];
}

T? tryCast<T>(dynamic object) => object is T ? object : null;

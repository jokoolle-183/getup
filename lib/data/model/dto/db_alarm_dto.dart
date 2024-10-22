import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/weekdays.dart';

@immutable
class DbAlarmDto extends Equatable {
  final int id;
  final String? name;
  final String audioPath;
  final DateTime time;
  final int? snoozeDuration;
  final List<Weekday>? daysOfWeek;

  const DbAlarmDto._({
    required this.id,
    required this.time,
    required this.daysOfWeek,
    required this.snoozeDuration,
    required this.audioPath,
    this.name,
  });

  factory DbAlarmDto.fromDbAlarm(DbAlarm alarm) => DbAlarmDto._(
        id: alarm.id,
        name: alarm.name,
        audioPath: alarm.audioPath,
        time: alarm.time,
        snoozeDuration: alarm.snoozeDuration,
        daysOfWeek: tryCast(alarm.daysOfWeek),
      );

  factory DbAlarmDto.fromAlarmCompanion(DbAlarmsCompanion alarmCompanion) =>
      DbAlarmDto._(
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

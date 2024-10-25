import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/weekdays.dart';

@immutable
class DbAlarmDto extends Equatable {
  final int id;
  final String? name;
  final String audioPath;
  final int? snoozeDuration;
  final List<Weekday>? daysOfWeek;
  final bool isEnabled;
  final AlarmInstance instance;

  const DbAlarmDto._({
    required this.id,
    required this.daysOfWeek,
    required this.snoozeDuration,
    required this.audioPath,
    required this.isEnabled,
    required this.instance,
    this.name,
  });

  factory DbAlarmDto.from(DbAlarm alarm, AlarmInstance instance) =>
      DbAlarmDto._(
        id: alarm.id,
        name: alarm.name,
        audioPath: alarm.audioPath,
        snoozeDuration: alarm.snoozeDuration,
        daysOfWeek: tryCast(alarm.daysOfWeek),
        isEnabled: alarm.isEnabled,
        instance: instance,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        audioPath,
        snoozeDuration,
        daysOfWeek,
        isEnabled,
      ];
}

T? tryCast<T>(dynamic object) => object is T ? object : null;

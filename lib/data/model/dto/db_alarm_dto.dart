import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/database/type_converter/equal_list.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_set_dto.dart';
import 'package:walk_it_up/data/model/weekdays.dart';

@immutable
class DbAlarmDto extends Equatable {
  final int id;
  final String? name;
  final String audioPath;
  final int? snoozeDuration;
  final EqualList<Weekday>? daysOfWeek;
  final bool isEnabled;
  final AlarmInstanceDto alarmInstance;

  const DbAlarmDto._({
    required this.id,
    required this.daysOfWeek,
    required this.snoozeDuration,
    required this.audioPath,
    required this.isEnabled,
    required this.alarmInstance,
    this.name,
  });

  factory DbAlarmDto.from({
    required DbAlarm alarm,
    required AlarmInstanceDto alarmInstanceDto,
    AlarmInstanceSetDto? alarmInstanceSetDto,
  }) =>
      DbAlarmDto._(
        id: alarm.id,
        name: alarm.name,
        audioPath: alarm.audioPath,
        snoozeDuration: alarm.snoozeDuration,
        daysOfWeek: tryCast(alarm.daysOfWeek),
        isEnabled: alarm.isEnabled,
        alarmInstance: alarmInstanceDto,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        audioPath,
        snoozeDuration,
        daysOfWeek,
        isEnabled,
        alarmInstance,
      ];
}

T? tryCast<T>(dynamic object) => object is T ? object : null;

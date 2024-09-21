import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/dto/recurring_alarm_dto.dart';
import 'package:walk_it_up/data/model/dto/regular_alarm_dto.dart';
import 'package:walk_it_up/data/model/weekdays.dart';

@immutable
class AlarmSetDto extends Equatable {
  final int id;
  final String? name;
  final String audioPath;
  final DateTime startTime;
  final DateTime endTime;
  final int intervalBetweenAlarms;
  final int? pauseDuration;
  final List<Weekday>? daysOfWeek;
  final List<RecurringAlarmDto> recurringAlarms;
  final bool isEnabled;

  const AlarmSetDto._({
    required this.id,
    required this.audioPath,
    required this.startTime,
    required this.endTime,
    required this.intervalBetweenAlarms,
    required this.daysOfWeek,
    required this.recurringAlarms,
    required this.isEnabled,
    this.name,
    this.pauseDuration,
  });

  factory AlarmSetDto.fromDbAlarmSet(
    AlarmSet alarmSet,
    List<RecurringAlarmDto> recurringAlarms,
  ) =>
      AlarmSetDto._(
        id: alarmSet.id,
        audioPath: alarmSet.audioPath,
        startTime: alarmSet.startTime,
        endTime: alarmSet.endTime,
        intervalBetweenAlarms: alarmSet.intervalBetweenAlarms,
        daysOfWeek: tryCast(alarmSet.daysOfWeek),
        name: alarmSet.name,
        pauseDuration: alarmSet.pauseDuration,
        recurringAlarms: recurringAlarms,
        isEnabled: alarmSet.isEnabled,
      );

  @override
  List<Object?> get props => [
        id,
        audioPath,
        name,
        startTime,
        endTime,
        intervalBetweenAlarms,
        pauseDuration,
        daysOfWeek,
        recurringAlarms,
        isEnabled,
      ];
}

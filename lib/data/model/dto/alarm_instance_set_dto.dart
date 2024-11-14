import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/weekdays.dart';

@immutable
class AlarmInstanceSetDto extends Equatable {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final String audioPath;
  final List<Weekday>? daysOfWeek;
  final int intervalBetweenAlarms;
  final int? pauseDuration;
  final List<AlarmInstanceDto> recurringAlarms;

  const AlarmInstanceSetDto._({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.intervalBetweenAlarms,
    required this.recurringAlarms,
    required this.audioPath,
    required this.daysOfWeek,
    this.pauseDuration,
  });

  factory AlarmInstanceSetDto.from(
    AlarmInstanceSet alarmSet,
    List<AlarmInstanceDto> recurringAlarms,
  ) =>
      AlarmInstanceSetDto._(
        id: alarmSet.id,
        startTime: alarmSet.startTime,
        endTime: alarmSet.endTime,
        intervalBetweenAlarms: alarmSet.intervalBetweenAlarms,
        pauseDuration: alarmSet.pauseDuration,
        recurringAlarms: recurringAlarms,
        audioPath: alarmSet.audioPath,
        daysOfWeek: alarmSet.daysOfWeek,
      );

  @override
  List<Object?> get props => [
        id,
        startTime,
        endTime,
        intervalBetweenAlarms,
        pauseDuration,
        recurringAlarms,
        daysOfWeek,
        audioPath,
      ];
}

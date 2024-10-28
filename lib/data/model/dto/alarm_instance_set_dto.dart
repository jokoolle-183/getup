import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';

@immutable
class AlarmInstanceSetDto extends Equatable {
  final int id;
  final int alarmId;
  final DateTime startTime;
  final DateTime endTime;
  final int intervalBetweenAlarms;
  final int? pauseDuration;
  final List<AlarmInstanceDto> recurringAlarms;

  const AlarmInstanceSetDto._({
    required this.id,
    required this.alarmId,
    required this.startTime,
    required this.endTime,
    required this.intervalBetweenAlarms,
    required this.recurringAlarms,
    this.pauseDuration,
  });

  factory AlarmInstanceSetDto.from(
    AlarmInstanceSet alarmSet,
    List<AlarmInstanceDto> recurringAlarms,
  ) =>
      AlarmInstanceSetDto._(
        id: alarmSet.id,
        alarmId: alarmSet.alarmId,
        startTime: alarmSet.startTime,
        endTime: alarmSet.endTime,
        intervalBetweenAlarms: alarmSet.intervalBetweenAlarms,
        pauseDuration: alarmSet.pauseDuration,
        recurringAlarms: recurringAlarms,
      );

  @override
  List<Object?> get props => [
        id,
        startTime,
        endTime,
        intervalBetweenAlarms,
        pauseDuration,
        recurringAlarms,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';

@immutable
class AlarmInstanceSetDto extends Equatable {
  final int id;
  final String? name;
  final DateTime startTime;
  final DateTime endTime;
  final int intervalBetweenAlarms;
  final int? pauseDuration;
  final List<AlarmInstanceDto> recurringAlarms;
  final bool isEnabled;

  const AlarmInstanceSetDto._({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.intervalBetweenAlarms,
    required this.recurringAlarms,
    required this.isEnabled,
    this.name,
    this.pauseDuration,
  });

  factory AlarmInstanceSetDto.fromDbAlarmSet(
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
        isEnabled: alarmSet.isEnabled,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        startTime,
        endTime,
        intervalBetweenAlarms,
        pauseDuration,
        recurringAlarms,
        isEnabled,
      ];
}

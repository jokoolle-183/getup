import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';

@immutable
class AlarmInstanceDto extends Equatable {
  final int id;
  final int alarmId;
  final int? alarmInstanceSetId;
  final DateTime time;
  final bool isEnabled;

  const AlarmInstanceDto._({
    required this.id,
    required this.alarmId,
    required this.time,
    required this.isEnabled,
    this.alarmInstanceSetId,
  });

  factory AlarmInstanceDto.from(AlarmInstance alarm) => AlarmInstanceDto._(
        id: alarm.id,
        alarmId: alarm.alarmId,
        alarmInstanceSetId: alarm.alarmInstanceSetId,
        time: alarm.time,
        isEnabled: alarm.isEnabled,
      );

  @override
  List<Object?> get props => [
        id,
        alarmId,
        alarmInstanceSetId,
        time,
        isEnabled,
      ];
}

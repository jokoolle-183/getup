import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';

@immutable
class RecurringAlarmDto extends Equatable {
  final int id;
  final int parentId;
  final DateTime time;
  final bool isEnabled;

  const RecurringAlarmDto._({
    required this.id,
    required this.parentId,
    required this.time,
    required this.isEnabled,
  });

  factory RecurringAlarmDto.fromDbRecurringAlarm(RecurringAlarm alarm) =>
      RecurringAlarmDto._(
        id: alarm.id,
        parentId: alarm.alarmSetId,
        time: alarm.time,
        isEnabled: alarm.isEnabled,
      );

  @override
  List<Object?> get props => [
        id,
        parentId,
        time,
        isEnabled,
      ];
}

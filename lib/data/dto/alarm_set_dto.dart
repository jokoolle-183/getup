import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/dto/alarm_dto.dart';
import 'package:walk_it_up/data/dto/weekdays.dart';

class AlarmSetDto {
  final int id;
  final String? name;
  final DateTime startTime;
  final DateTime endTime;
  final int intervalBetweenAlarms;
  final int? pauseDuration;
  final List<Weekday> daysOfWeek;

  AlarmSetDto._({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.intervalBetweenAlarms,
    required this.daysOfWeek,
    this.name,
    this.pauseDuration,
  });

  factory AlarmSetDto.fromDbAlarmSet(AlarmSet alarmSet) => AlarmSetDto._(
        id: alarmSet.id,
        startTime: alarmSet.startTime,
        endTime: alarmSet.endTime,
        intervalBetweenAlarms: alarmSet.intervalBetweenAlarms,
        daysOfWeek: tryCast(alarmSet.daysOfWeek),
        name: alarmSet.name,
        pauseDuration: alarmSet.pauseDuration,
      );
}

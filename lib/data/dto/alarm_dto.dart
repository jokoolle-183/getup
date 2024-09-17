import 'package:equatable/equatable.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';

class AlarmDto extends Equatable {
  final int id;
  final String? name;
  final String audioPath;
  final DateTime time;
  final int snoozeDuration;
  final String daysOfWeek;

  AlarmDto._({
    required this.id,
    required this.time,
    required this.daysOfWeek,
    required this.snoozeDuration,
    required this.audioPath,
    this.name,
  });

  factory AlarmDto.fromDbAlarm(DbAlarm dbAlarm) => AlarmDto._(
        id: dbAlarm.id,
        name: dbAlarm.name,
        audioPath: dbAlarm.audioPath,
        time: dbAlarm.time,
        snoozeDuration: dbAlarm.snoozeDuration,
        daysOfWeek: dbAlarm.daysOfWeek,
      );

  factory AlarmDto.fromAlarmCompanion(AlarmsCompanion alarmCompanion) =>
      AlarmDto._(
        id: alarmCompanion.id.value,
        name: alarmCompanion.name.value,
        audioPath: alarmCompanion.audioPath.value,
        time: alarmCompanion.time.value,
        snoozeDuration: alarmCompanion.snoozeDuration.value,
        daysOfWeek: alarmCompanion.daysOfWeek.value,
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

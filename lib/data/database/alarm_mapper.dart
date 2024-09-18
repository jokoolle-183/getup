import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/dto/alarm_dto.dart';

class AlarmMapper {
  static RegularAlarmsCompanion mapAlarmToCompanion(AlarmDto alarmDto) {
    return RegularAlarmsCompanion.insert(
      name: Value.absentIfNull(alarmDto.name),
      audioPath: alarmDto.audioPath,
      time: alarmDto.time,
      snoozeDuration: Value.absentIfNull(alarmDto.snoozeDuration),
      daysOfWeek: Value.absentIfNull(alarmDto.daysOfWeek),
    );
  }

  static AlarmDto mapCompanionToAlarm(RegularAlarmsCompanion alarmCompanion) {
    return AlarmDto.fromAlarmCompanion(alarmCompanion);
  }
}

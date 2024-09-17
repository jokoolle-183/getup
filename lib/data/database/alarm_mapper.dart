import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/dto/alarm_dto.dart';

class AlarmMapper {
  static AlarmsCompanion mapAlarmToCompanion(AlarmDto alarmDto) {
    return AlarmsCompanion.insert(
      name: Value.absentIfNull(alarmDto.name),
      audioPath: alarmDto.audioPath,
      time: alarmDto.time,
      snoozeDuration: alarmDto.snoozeDuration,
      daysOfWeek: alarmDto.daysOfWeek,
    );
  }

  static AlarmDto mapCompanionToAlarm(AlarmsCompanion alarmCompanion) {
    return AlarmDto.fromAlarmCompanion(alarmCompanion);
  }
}

import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/database/type_converter/equal_list.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_set_dto.dart';
import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';
import 'package:walk_it_up/data/model/alarm_args.dart';

class AlarmMapper {
  static DbAlarmsCompanion mapDTOToCompanion(DbAlarmDto regularAlarmDto) {
    return DbAlarmsCompanion.insert(
      name: Value.absentIfNull(regularAlarmDto.name),
      audioPath: regularAlarmDto.audioPath,
      snoozeDuration: Value.absentIfNull(regularAlarmDto.snoozeDuration),
      daysOfWeek:
          Value.absentIfNull(EqualList(regularAlarmDto.daysOfWeek ?? [])),
    );
  }

  static DbAlarmsCompanion mapArgsToCompanion(AlarmArgs alarmArgs) {
    return DbAlarmsCompanion.insert(
      name: Value.absentIfNull(alarmArgs.name),
      audioPath: alarmArgs.audioPath,
      isEnabled: Value(alarmArgs.enabled),
      snoozeDuration: Value.absentIfNull(alarmArgs.snoozeDuration),
      daysOfWeek: Value.absentIfNull(
        EqualList(alarmArgs.daysOfWeek ?? []),
      ),
    );
  }

  static AlarmInstanceSetsCompanion mapAlarmInstanceSetToCompanion(
      AlarmInstanceSetDto alarmSet) {
    return AlarmInstanceSetsCompanion.insert(
      audioPath: alarmSet.audioPath,
      startTime: alarmSet.startTime,
      endTime: alarmSet.endTime,
      intervalBetweenAlarms: alarmSet.intervalBetweenAlarms,
      daysOfWeek: Value.absentIfNull(EqualList(alarmSet.daysOfWeek ?? [])),
      pauseDuration: Value.absentIfNull(alarmSet.pauseDuration),
    );
  }

  static AlarmInstancesCompanion mapAlarmInstanceToCompanion({
    int? alarmId,
    int? alarmInstanceSetId,
    required AlarmInstanceDto recurringAlarm,
  }) {
    return AlarmInstancesCompanion.insert(
      alarmId: Value(alarmId),
      alarmInstanceSetId: Value(alarmInstanceSetId),
      time: recurringAlarm.time,
      isEnabled: Value(recurringAlarm.isEnabled),
    );
  }
}

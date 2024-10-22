import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/database/type_converter/equal_list.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_set_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';
import 'package:walk_it_up/data/model/regular_alarm_model.dart';

class AlarmMapper {
  static DbAlarmsCompanion mapDTOToCompanion(DbAlarmDto regularAlarmDto) {
    return DbAlarmsCompanion.insert(
      name: Value.absentIfNull(regularAlarmDto.name),
      audioPath: regularAlarmDto.audioPath,
      time: regularAlarmDto.time,
      snoozeDuration: Value.absentIfNull(regularAlarmDto.snoozeDuration),
      daysOfWeek:
          Value.absentIfNull(EqualList(regularAlarmDto.daysOfWeek ?? [])),
    );
  }

  static DbAlarmsCompanion mapModelToCompanion(
      RegularAlarmModel regularAlarmModel) {
    return DbAlarmsCompanion.insert(
      name: Value.absentIfNull(regularAlarmModel.name),
      audioPath: regularAlarmModel.audioPath,
      time: regularAlarmModel.time,
      snoozeDuration: Value.absentIfNull(regularAlarmModel.snoozeDuration),
      daysOfWeek:
          Value.absentIfNull(EqualList(regularAlarmModel.daysOfWeek ?? [])),
    );
  }

  static AlarmInstanceSetsCompanion mapAlarmInstanceSetToCompanion(
      int alarmId, AlarmSetDto alarmSet) {
    return AlarmInstanceSetsCompanion.insert(
      alarmId: alarmId,
      name: Value.absentIfNull(alarmSet.name),
      startTime: alarmSet.startTime,
      endTime: alarmSet.endTime,
      intervalBetweenAlarms: alarmSet.intervalBetweenAlarms,
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

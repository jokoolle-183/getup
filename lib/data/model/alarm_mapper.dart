import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/dto/alarm_set_dto.dart';
import 'package:walk_it_up/data/model/dto/recurring_alarm_dto.dart';
import 'package:walk_it_up/data/model/dto/regular_alarm_dto.dart';

class AlarmMapper {
  static RegularAlarmsCompanion mapRegularAlarmToCompanion(
      RegularAlarmDto regularAlarm) {
    return RegularAlarmsCompanion.insert(
      name: Value.absentIfNull(regularAlarm.name),
      audioPath: regularAlarm.audioPath,
      time: regularAlarm.time,
      snoozeDuration: Value.absentIfNull(regularAlarm.snoozeDuration),
      daysOfWeek: Value.absentIfNull(regularAlarm.daysOfWeek),
    );
  }

  static AlarmSetsCompanion mapAlarmSetToCompanion(AlarmSetDto alarmSet) {
    return AlarmSetsCompanion.insert(
      name: Value.absentIfNull(alarmSet.name),
      audioPath: alarmSet.audioPath,
      startTime: alarmSet.startTime,
      endTime: alarmSet.endTime,
      intervalBetweenAlarms: alarmSet.intervalBetweenAlarms,
      pauseDuration: Value.absentIfNull(alarmSet.pauseDuration),
      daysOfWeek: Value.absentIfNull(alarmSet.daysOfWeek),
    );
  }

  static RecurringAlarmsCompanion mapRecurringAlarmToCompanion(
    int alarmSetId,
    RecurringAlarmDto recurringAlarm,
  ) {
    return RecurringAlarmsCompanion.insert(
      alarmSetId: alarmSetId,
      time: recurringAlarm.time,
      isEnabled: Value(recurringAlarm.isEnabled),
    );
  }
}

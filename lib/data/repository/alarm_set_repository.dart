import 'package:walk_it_up/data/model/dto/alarm_set_dto.dart';
import 'package:walk_it_up/data/model/dto/recurring_alarm_dto.dart';

abstract class AlarmSetRepository {
  Future<List<AlarmSetDto>> getAlarmSets();
  Future<void> saveAlarmSet(
      AlarmSetDto alarmSet, List<RecurringAlarmDto> recurringAlarms);
  Future<void> updateAlarmSet(
      AlarmSetDto alarmSet, List<RecurringAlarmDto> recurringAlarms);
  Future<void> deleteAlarmSet(AlarmSetDto alarmSet);
}

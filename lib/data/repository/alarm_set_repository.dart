import 'package:walk_it_up/data/model/dto/alarm_instance_set_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_set_dto.dart';

abstract class AlarmSetRepository {
  Future<List<AlarmInstanceSetDto>> getAlarmSets();
  Future<void> saveAlarmSet(
      AlarmSetDto alarmSet, List<AlarmInstanceDto> recurringAlarms);
  Future<void> updateAlarmSet(
      AlarmSetDto alarmSet, List<AlarmInstanceDto> recurringAlarms);
  Future<void> deleteAlarmSet(AlarmSetDto alarmSet);
}

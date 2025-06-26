import 'package:walk_it_up/data/model/alarm_set_args.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_set_dto.dart';

abstract class AlarmSetRepository {
  Future<List<AlarmInstanceSetDto>> getAlarmSets();
  Future<int?> saveAlarmSet(AlarmSetArgs alarmSetArgs);
  Future<void> updateAlarmSet(AlarmInstanceSetDto alarmSet);
  Future<void> deleteAlarmSet(AlarmInstanceSetDto alarmSet);
  Future<AlarmInstanceSetDto?> getAlarmInstanceSetById(int instanceSetId);
}

import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';
import 'package:walk_it_up/data/model/alarm_args.dart';

abstract class RegularAlarmRepository {
  Future<List<DbAlarmDto>> getRegularAlarms();
  Future<int> saveAlarm(AlarmArgs alarmArgs);
  Future<bool> updateAlarm(DbAlarmDto regularAlarm);
  Future<int> deleteAlarm(DbAlarmDto regularAlarm);
  Future<int> updateAlarmInstance(int alarmId, int instanceId, DateTime time);
  Future<DbAlarmDto?> getAlarmById(int id);
  Future<DbAlarmDto?> getAlarmByInstanceId(int instanceId);
}

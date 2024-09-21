import 'package:walk_it_up/data/model/dto/regular_alarm_dto.dart';

abstract class RegularAlarmRepository {
  Future<List<RegularAlarmDto>> getRegularAlarms();
  Future<int> saveAlarm(RegularAlarmDto regularAlarm);
  Future<bool> updateAlarm(RegularAlarmDto regularAlarm);
  Future<int> deleteAlarm(RegularAlarmDto regularAlarm);
  Stream<RegularAlarmDto> watchAlarmById(int id);
}

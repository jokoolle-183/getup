import 'package:walk_it_up/data/dto/alarm_dto.dart';
import 'package:walk_it_up/data/dto/alarm_set_dto.dart';

abstract class AlarmRepository {
  Future<List<AlarmDto>> getAlarms();
  Future<List<AlarmSetDto>> getAlarmSets();
}

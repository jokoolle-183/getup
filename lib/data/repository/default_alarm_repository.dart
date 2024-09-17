import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/dto/alarm_dto.dart';
import 'package:walk_it_up/data/dto/alarm_set_dto.dart';
import 'package:walk_it_up/data/repository/alarm_repository.dart';

class DefaultAlarmRepository extends AlarmRepository {
  final AlarmDatabase _database;

  DefaultAlarmRepository(this._database);

  @override
  Future<List<AlarmSetDto>> getAlarmSets() async {
    var alarmSets = await _database.allAlarmSets;
    return alarmSets
        .map((alarmSet) => AlarmSetDto.fromDbAlarmSet(alarmSet))
        .toList();
  }

  @override
  Future<List<AlarmDto>> getAlarms() async {
    var alarms = await _database.allAlarms;
    return alarms.map((alarm) => AlarmDto.fromDbAlarm(alarm)).toList();
  }
}

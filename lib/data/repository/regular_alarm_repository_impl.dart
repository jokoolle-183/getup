import 'package:walk_it_up/data/model/alarm_mapper.dart';
import 'package:walk_it_up/data/database/dao/alarm_dao/db_alarms_dao.dart';
import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';
import 'package:walk_it_up/data/model/regular_alarm_model.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';

class RegularAlarmRepositoryImpl extends RegularAlarmRepository {
  final DbAlarmDao _regularAlarmsDao;
  RegularAlarmRepositoryImpl(this._regularAlarmsDao);

  @override
  Future<int> deleteAlarm(DbAlarmDto regularAlarm) {
    return _regularAlarmsDao.deleteAlarm(regularAlarm.id);
  }

  @override
  Future<List<DbAlarmDto>> getRegularAlarms() async {
    final dbAlarms = await _regularAlarmsDao.allRegularAlarms;
    return dbAlarms.map((alarm) => DbAlarmDto.fromDbAlarm(alarm)).toList();
  }

  @override
  Future<int> saveAlarm(RegularAlarmModel regularAlarm) {
    return _regularAlarmsDao
        .saveAlarm(AlarmMapper.mapModelToCompanion(regularAlarm));
  }

  @override
  Future<bool> updateAlarm(DbAlarmDto regularAlarm) {
    return _regularAlarmsDao
        .updateAlarm(AlarmMapper.mapDTOToCompanion(regularAlarm));
  }

  @override
  Stream<DbAlarmDto> watchAlarmById(int id) {
    return _regularAlarmsDao
        .watchAlarmById(id)
        .map((alarm) => DbAlarmDto.fromDbAlarm(alarm));
  }
}

import 'package:walk_it_up/data/database/alarm_mapper.dart';
import 'package:walk_it_up/data/database/dao/regular_alarm/regular_alarms_dao.dart';
import 'package:walk_it_up/data/model/dto/regular_alarm_dto.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';

class RegularAlarmRepositoryImpl extends RegularAlarmRepository {
  final RegularAlarmsDao _regularAlarmsDao;
  RegularAlarmRepositoryImpl(this._regularAlarmsDao);

  @override
  Future<int> deleteAlarm(RegularAlarmDto regularAlarm) {
    return _regularAlarmsDao.deleteAlarm(regularAlarm.id);
  }

  @override
  Future<List<RegularAlarmDto>> getRegularAlarms() async {
    final dbAlarms = await _regularAlarmsDao.allRegularAlarms;
    return dbAlarms.map((alarm) => RegularAlarmDto.fromDbAlarm(alarm)).toList();
  }

  @override
  Future<int> saveAlarm(RegularAlarmDto regularAlarm) {
    return _regularAlarmsDao
        .saveAlarm(AlarmMapper.mapRegularAlarmToCompanion(regularAlarm));
  }

  @override
  Future<bool> updateAlarm(RegularAlarmDto regularAlarm) {
    return _regularAlarmsDao
        .updateAlarm(AlarmMapper.mapRegularAlarmToCompanion(regularAlarm));
  }

  @override
  Stream<RegularAlarmDto> watchAlarmById(int id) {
    return _regularAlarmsDao
        .watchAlarmById(id)
        .map((alarm) => RegularAlarmDto.fromDbAlarm(alarm));
  }
}

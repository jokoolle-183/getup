import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/database/dao/alarm_instance_dao/alarm_instance_dao.dart';
import 'package:walk_it_up/data/model/alarm_mapper.dart';
import 'package:walk_it_up/data/database/dao/alarm_dao/db_alarms_dao.dart';
import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';
import 'package:walk_it_up/data/model/alarm_args.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';

class RegularAlarmRepositoryImpl extends RegularAlarmRepository {
  final DbAlarmDao _alarmDao;
  final AlarmInstancesDao _alarmInstancesDao;
  RegularAlarmRepositoryImpl(this._alarmDao, this._alarmInstancesDao);

  @override
  Future<int> deleteAlarm(DbAlarmDto regularAlarm) {
    return _alarmDao.deleteAlarm(regularAlarm.id);
  }

  @override
  Future<List<DbAlarmDto>> getRegularAlarms() async {
    return _alarmDao.getAlarms();
  }

  @override
  Future<int> saveAlarm(AlarmArgs alarmArgs) async {
    final alarmId =
        await _alarmDao.saveAlarm(AlarmMapper.mapArgsToCompanion(alarmArgs));
    final entry = AlarmInstancesCompanion.insert(
      alarmId: Value(alarmId),
      time: alarmArgs.time,
    );
    return _alarmInstancesDao.saveAlarmInstance(entry);
  }

  @override
  Future<bool> updateAlarm(DbAlarmDto regularAlarm) {
    return _alarmDao.updateAlarm(AlarmMapper.mapDTOToCompanion(regularAlarm));
  }

  @override
  Stream<DbAlarmDto> watchAlarmById(int id) {
    return _alarmDao.watchAlarmById(id);
  }
}

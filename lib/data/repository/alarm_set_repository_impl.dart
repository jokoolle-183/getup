import 'package:walk_it_up/data/model/alarm_mapper.dart';
import 'package:walk_it_up/data/database/dao/alarm_set/alarm_set_dao.dart';
import 'package:walk_it_up/data/model/dto/alarm_set_dto.dart';
import 'package:walk_it_up/data/model/dto/recurring_alarm_dto.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';

class AlarmSetRepositoryImpl extends AlarmSetRepository {
  final AlarmSetDao _alarmSetDao;

  AlarmSetRepositoryImpl(this._alarmSetDao);

  @override
  Future<List<AlarmSetDto>> getAlarmSets() async {
    return _alarmSetDao.getSetsWithAlarms();
  }

  @override
  Future<void> saveAlarmSet(
      AlarmSetDto alarmSet, List<RecurringAlarmDto> recurringAlarms) {
    final alarmSetCompanion = AlarmMapper.mapAlarmSetToCompanion(alarmSet);
    final recurringAlarmCompanions = recurringAlarms
        .map(
          (alarm) => AlarmMapper.mapRecurringAlarmToCompanion(
            alarmSet.id,
            alarm,
          ),
        )
        .toList();

    return _alarmSetDao.saveAlarmSet(
      alarmSetCompanion,
      recurringAlarmCompanions,
    );
  }

  @override
  Future<void> updateAlarmSet(
      AlarmSetDto alarmSet, List<RecurringAlarmDto> recurringAlarms) {
    final alarmSetCompanion = AlarmMapper.mapAlarmSetToCompanion(alarmSet);
    final recurringAlarmCompanions = recurringAlarms
        .map(
          (alarm) => AlarmMapper.mapRecurringAlarmToCompanion(
            alarmSet.id,
            alarm,
          ),
        )
        .toList();

    return _alarmSetDao.updateAlarmSet(
      alarmSetCompanion,
      recurringAlarmCompanions,
    );
  }

  @override
  Future<void> deleteAlarmSet(AlarmSetDto alarmSet) {
    return _alarmSetDao.deleteAlarmSet(alarmSet.id);
  }
}

import 'package:walk_it_up/data/database/dao/alarm_set/alarm_instances_set_dao.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_set_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_set_dto.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';

class AlarmSetRepositoryImpl extends AlarmSetRepository {
  final AlarmInstanceSetDao _alarmSetDao;

  AlarmSetRepositoryImpl(this._alarmSetDao);

  @override
  Future<List<AlarmInstanceSetDto>> getAlarmSets() async {
    return _alarmSetDao.getSetsWithAlarms();
  }

  @override
  Future<void> saveAlarmSet(
    AlarmSetDto alarmSet,
    List<AlarmInstanceDto> recurringAlarms,
  ) {
    // final alarmSetCompanion =
    //     AlarmMapper.mapAlarmInstanceSetToCompanion(alarmId, alarmSet);
    // final recurringAlarmCompanions = recurringAlarms
    //     .map(
    //       (alarm) => AlarmMapper.mapAlarmInstanceToCompanion(
    //         alarmId: null,
    //         alarmInstanceSetId: ,
    //         recurringAlarm: alarm,
    //       ),
    //     )
    //     .toList();

    // return _alarmSetDao.saveAlarmSet(
    //   alarmSetCompanion,
    //   recurringAlarmCompanions,
    // );
    return Future.value();
  }

  @override
  Future<void> updateAlarmSet(
    AlarmSetDto alarmSet,
    List<AlarmInstanceDto> recurringAlarms,
  ) {
    // final alarmSetCompanion =
    //     AlarmMapper.mapAlarmInstanceSetToCompanion(alarmSet);
    // final recurringAlarmCompanions = recurringAlarms
    //     .map(
    //       (alarm) => AlarmMapper.mapAlarmInstanceToCompanion(
    //         alarmSet.id,
    //         alarm,
    //       ),
    //     )
    //     .toList();

    // return _alarmSetDao.updateAlarmSet(
    //   alarmSetCompanion,
    //   recurringAlarmCompanions,
    // );
    return Future.value();
  }

  @override
  Future<void> deleteAlarmSet(AlarmSetDto alarmSet) {
    return _alarmSetDao.deleteAlarmSet(alarmSet.id);
  }
}

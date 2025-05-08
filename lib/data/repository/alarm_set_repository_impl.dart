import 'package:walk_it_up/data/database/dao/alarm_set/alarm_instances_set_dao.dart';
import 'package:walk_it_up/data/model/alarm_mapper.dart';
import 'package:walk_it_up/data/model/alarm_set_args.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_set_dto.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';

class AlarmSetRepositoryImpl extends AlarmSetRepository {
  final AlarmInstanceSetDao _alarmSetDao;

  AlarmSetRepositoryImpl(this._alarmSetDao);

  @override
  Future<List<AlarmSetArgs>> getAlarmSets() async {
    return _alarmSetDao.getSetsWithAlarms();
  }

  @override
  Future<void> saveAlarmSet(
    AlarmSetArgs alarmSetArgs,
  ) {
    final alarmSetCompanion =
        AlarmMapper.mapAlarmSetArgsToCompanion(alarmSetArgs);
    final recurringAlarmCompanions = alarmSetArgs.recurringAlarmDates
        .map(
          (alarm) => AlarmMapper.mapAlarmDateToAlarmInstanceCompanion(
            recurringAlarm: alarm,
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
    AlarmSetArgs alarmSet,
    List<AlarmInstanceDto> recurringAlarms,
  ) {
    // final alarmSetCompanion = AlarmMapper.mapAlarmSetArgsToCompanion(alarmSet);
    // final recurringAlarmCompanions = recurringAlarms
    //     .map(
    //       (alarm) => AlarmMapper.mapAlarmDateToAlarmInstanceCompanion(
    //         recurringAlarm: alarm,
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
  Future<void> deleteAlarmSet(AlarmSetArgs alarmSet) {
    return _alarmSetDao.deleteAlarmSet(alarmSet.id);
  }
}

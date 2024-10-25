import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';

part 'db_alarms_dao.g.dart';

@DriftAccessor(tables: [DbAlarms, AlarmInstances])
class DbAlarmDao extends DatabaseAccessor<AlarmDatabase>
    with _$DbAlarmDaoMixin {
  DbAlarmDao(AlarmDatabase db) : super(db);

  Future<List<DbAlarmDto>> getAlarms() async {
    final query = select(alarmInstances).join([
      leftOuterJoin(dbAlarms, dbAlarms.id.equalsExp(alarmInstances.alarmId))
    ]);

    return query.get().then((rows) => rows
        .map(
          (row) => DbAlarmDto.from(
            row.readTable(dbAlarms),
            row.readTable(alarmInstances),
          ),
        )
        .toList());
  }

  Future<int> saveAlarm(DbAlarmsCompanion entry) {
    return into(dbAlarms).insert(entry);
  }

  Future<bool> updateAlarm(DbAlarmsCompanion entry) {
    return update(dbAlarms).replace(entry);
  }

  Future<int> deleteAlarm(int id) {
    return (delete(dbAlarms)..where((alarm) => alarm.id.equals(id))).go();
  }

  Stream<DbAlarmDto> watchAlarmById(int id) {
    final query = select(alarmInstances).join([
      leftOuterJoin(dbAlarms, dbAlarms.id.equalsExp(alarmInstances.alarmId)),
    ])
      ..where(dbAlarms.id.equals(id));

    return query.watch().map((rows) {
      return rows.map((row) {
        final dbAlarm = row.readTable(dbAlarms);
        final alarmInstance = row.readTableOrNull(alarmInstances);

        return DbAlarmDto.from(
          dbAlarm,
          alarmInstance!,
        );
      }).first;
    });
  }
}

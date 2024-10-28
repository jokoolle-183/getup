import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_set_dto.dart';
import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';

part 'db_alarms_dao.g.dart';

@DriftAccessor(tables: [DbAlarms, AlarmInstances])
class DbAlarmDao extends DatabaseAccessor<AlarmDatabase>
    with _$DbAlarmDaoMixin {
  DbAlarmDao(AlarmDatabase db) : super(db);

  Future<List<DbAlarmDto>> getAlarms() {
    final alarmQuery = select(dbAlarms).join([
      leftOuterJoin(
        alarmInstanceSets,
        alarmInstanceSets.alarmId.equalsExp(dbAlarms.id),
      ),
    ]);
    return constructResults(alarmQuery);
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

  Future<DbAlarmDto?> getAlarmById(int id) async {
    final alarmQuery = select(dbAlarms).join([
      leftOuterJoin(
        alarmInstanceSets,
        alarmInstanceSets.alarmId.equalsExp(dbAlarms.id),
      ),
    ])
      ..where(dbAlarms.id.equals(id));

    final alarms = await constructResults(alarmQuery);

    return alarms.firstOrNull;
  }

  Future<List<DbAlarmDto>> constructResults(
      JoinedSelectStatement<HasResultSet, dynamic> query) async {
    return query.get().then((rows) async {
      final List<DbAlarmDto> alarmDtos = [];

      for (final row in rows) {
        final alarm = row.readTable(dbAlarms);
        final alarmInstanceSet = row.readTableOrNull(alarmInstanceSets);

        if (alarmInstanceSet != null) {
          final allSetInstances =
              await getAlarmInstancesBySetId(alarmInstanceSet.id);
          final alarmInstance = allSetInstances.firstOrNull;

          if (alarmInstance != null) {
            final alarmInstanceDtos = allSetInstances
                .map((instance) => AlarmInstanceDto.from(instance))
                .toList();

            alarmDtos.add(DbAlarmDto.from(
              alarm: alarm,
              alarmInstanceDto: AlarmInstanceDto.from(alarmInstance),
              alarmInstanceSetDto:
                  AlarmInstanceSetDto.from(alarmInstanceSet, alarmInstanceDtos),
            ));
          }
        } else {
          final alarmInstance = await getAlarmInstanceByAlarmId(alarm.id);

          if (alarmInstance != null) {
            alarmDtos.add(DbAlarmDto.from(
              alarm: alarm,
              alarmInstanceDto: AlarmInstanceDto.from(alarmInstance),
            ));
          }
        }
      }

      return alarmDtos;
    });
  }

  // Helper function to get the next AlarmInstance by alarmInstanceSetId
  Future<List<AlarmInstance>> getAlarmInstancesBySetId(int alarmInstanceSetId) {
    return (select(alarmInstances)
          ..where((tbl) => tbl.alarmInstanceSetId.equals(alarmInstanceSetId))
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.time, mode: OrderingMode.asc)
          ]))
        .get();
  }

// Helper function to get the regular (non-recurring) AlarmInstance for an Alarm
  Future<AlarmInstance?> getAlarmInstanceByAlarmId(int alarmId) {
    return (select(alarmInstances)
          ..where((tbl) => tbl.alarmId.equals(alarmId))
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.time, mode: OrderingMode.asc)
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<List<AlarmInstance>> getRecurringAlarmsForSet(int alarmInstanceSetId) {
    return (select(alarmInstances)
          ..where((tbl) => tbl.alarmInstanceSetId.equals(alarmInstanceSetId))
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.time, mode: OrderingMode.asc)
          ]))
        .get();
  }
}

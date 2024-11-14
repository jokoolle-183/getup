import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';

part 'db_alarms_dao.g.dart';

@DriftAccessor(tables: [DbAlarms, AlarmInstances])
class DbAlarmDao extends DatabaseAccessor<AlarmDatabase>
    with _$DbAlarmDaoMixin {
  DbAlarmDao(AlarmDatabase db) : super(db);

  Future<List<DbAlarmDto>> getAlarms() {
    final query = select(dbAlarms).join([
      innerJoin(
        alarmInstances,
        alarmInstances.alarmId.equalsExp(dbAlarms.id),
      ),
    ]);

    return query.get().then((results) => results.map((row) {
          final dbAlarm = row.readTable(dbAlarms);
          final alarmInstance = row.readTable(alarmInstances);

          return DbAlarmDto.from(
            alarm: dbAlarm,
            alarmInstanceDto: AlarmInstanceDto.from(alarmInstance),
          );
        }).toList());
  }

  Future<int> saveAlarm(DbAlarmsCompanion entry) {
    return into(dbAlarms).insertOnConflictUpdate(entry);
  }

  Future<bool> updateAlarm(DbAlarmsCompanion entry) {
    return update(dbAlarms).replace(entry);
  }

  Future<int> deleteAlarm(int id) {
    return (delete(dbAlarms)..where((alarm) => alarm.id.equals(id))).go();
  }

  Future<DbAlarmDto?> getAlarmById(int id) async {
    final alarmQuery = select(dbAlarms).join([
      innerJoin(
        alarmInstances,
        alarmInstances.alarmId.equalsExp(dbAlarms.id),
      ),
    ])
      ..where(dbAlarms.id.equals(id));

    final result = await alarmQuery.getSingleOrNull();

    if (result == null) {
      return null; // If no result is found for the specified alarmId
    }

    final alarm = result.readTable(db.dbAlarms);
    final instance = result.readTable(
        db.alarmInstances); // Guaranteed to be non-null due to inner join

    return DbAlarmDto.from(
      alarm: alarm,
      alarmInstanceDto: AlarmInstanceDto.from(instance),
    );
  }

  Future<DbAlarmDto?> getAlarmByInstanceId(int instanceId) async {
    final alarmInstance = await (select(alarmInstances)
          ..where((instances) => instances.id.equals(instanceId)))
        .getSingleOrNull();

    if (alarmInstance == null || alarmInstance.alarmId == null) {
      return null;
    }

    final alarm = await (select(db.dbAlarms)
          ..where((tbl) => tbl.id.equals(alarmInstance.alarmId!)))
        .getSingleOrNull();

    if (alarm == null) {
      return null;
    }

    return DbAlarmDto.from(
      alarm: alarm,
      alarmInstanceDto: AlarmInstanceDto.from(alarmInstance),
    );
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

import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';

part 'db_alarms_dao.g.dart';

@DriftAccessor(tables: [DbAlarms])
class DbAlarmDao extends DatabaseAccessor<AlarmDatabase>
    with _$DbAlarmDaoMixin {
  DbAlarmDao(AlarmDatabase db) : super(db);

  Future<List<DbAlarm>> get allRegularAlarms => select(dbAlarms).get();

  Future<int> saveAlarm(DbAlarmsCompanion entry) {
    return into(dbAlarms).insert(entry);
  }

  Future<bool> updateAlarm(DbAlarmsCompanion entry) {
    return update(dbAlarms).replace(entry);
  }

  Future<int> deleteAlarm(int id) {
    return (delete(dbAlarms)..where((alarm) => alarm.id.equals(id))).go();
  }

  Stream<DbAlarm> watchAlarmById(int id) {
    return (select(dbAlarms)..where((alarm) => alarm.id.equals(id)))
        .watchSingle();
  }
}

import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/database/tables/alarm_tables.dart';

part 'regular_alarms_dao.g.dart';

@DriftAccessor(tables: [RegularAlarms])
class RegularAlarmsDao extends DatabaseAccessor<AlarmDatabase>
    with _$RegularAlarmsDaoMixin {
  RegularAlarmsDao(AlarmDatabase db) : super(db);

  Future<List<RegularAlarm>> get allRegularAlarms =>
      select(regularAlarms).get();

  Future<int> saveAlarm(RegularAlarmsCompanion entry) {
    return into(regularAlarms).insert(entry);
  }

  Future<bool> updateAlarm(RegularAlarmsCompanion entry) {
    return update(regularAlarms).replace(entry);
  }

  Future<int> deleteAlarm(int id) {
    return (delete(regularAlarms)..where((alarm) => alarm.id.equals(id))).go();
  }

  Stream<RegularAlarm> watchAlarmById(int id) {
    return (select(regularAlarms)..where((alarm) => alarm.id.equals(id)))
        .watchSingle();
  }
}

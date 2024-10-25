import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';

part 'alarm_instance_dao.g.dart';

@DriftAccessor(tables: [AlarmInstances])
class AlarmInstancesDao extends DatabaseAccessor<AlarmDatabase>
    with _$AlarmInstancesDaoMixin {
  AlarmInstancesDao(AlarmDatabase db) : super(db);

  Future<int> saveAlarmInstance(AlarmInstancesCompanion entry) {
    return into(alarmInstances).insert(entry);
  }
}

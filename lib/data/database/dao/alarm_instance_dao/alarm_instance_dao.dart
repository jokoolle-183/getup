import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';

part 'alarm_instance_dao.g.dart';

@DriftAccessor(tables: [AlarmInstances])
class AlarmInstancesDao extends DatabaseAccessor<AlarmDatabase>
    with _$AlarmInstancesDaoMixin {
  AlarmInstancesDao(AlarmDatabase db) : super(db);

  Future<int> saveAlarmInstance(AlarmInstancesCompanion entry) async {
    return into(alarmInstances).insertOnConflictUpdate(entry);
  }

  Future<AlarmInstance> getAlarmInstanceById(int id) async {
    return (select(alarmInstances)
          ..where((alarmInstance) => alarmInstance.id.equals(id)))
        .getSingle();
  }

  Future<int> deleteAlarmInstance(int instanceId) {
    return (delete(alarmInstances)
          ..where((instance) => instance.id.equals(instanceId)))
        .go();
  }

  Future<int> registerAlarmInstance(
    int instanceId,
    AlarmInstancesCompanion entry,
  ) {
    return transaction(() async {
      await deleteAlarmInstance(instanceId);
      return await saveAlarmInstance(entry);
    });
  }
}

import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';

part 'alarm_instance_dao.g.dart';

@DriftAccessor(tables: [AlarmInstances])
class AlarmInstancesDao extends DatabaseAccessor<AlarmDatabase> with _$AlarmInstancesDaoMixin {
  AlarmInstancesDao(AlarmDatabase db) : super(db);

  /// Throws an [SqliteException] if the insert fails.
  /// TODO: Add error handling
  Future<int> saveAlarmInstance(AlarmInstancesCompanion entry) async {
    return into(alarmInstances).insertOnConflictUpdate(entry);
  }

  /// Throws an [IterableElementError] if there's no such element or too many.
  /// TODO: Add error handling
  Future<AlarmInstance?> getAlarmInstanceById(int id) async {
    final instances =
        await (select(alarmInstances)..where((alarmInstance) => alarmInstance.id.equals(id))).get();
    return instances.firstOrNull;
  }

  /// Throws an [SqliteException] if the delete fails.
  /// TODO: Add error handling
  Future<int> deleteAlarmInstance(int instanceId) {
    return (delete(alarmInstances)..where((instance) => instance.id.equals(instanceId))).go();
  }

  Future<int> registerNewAlarmInstance(
    int instanceId,
    AlarmInstancesCompanion entry,
  ) {
    return transaction(() async {
      await deleteAlarmInstance(instanceId);
      return await saveAlarmInstance(entry);
    });
  }
}

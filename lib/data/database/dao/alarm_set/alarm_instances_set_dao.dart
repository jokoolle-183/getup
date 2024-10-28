import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_set_dto.dart';

part 'alarm_instances_set_dao.g.dart';

@DriftAccessor(tables: [AlarmInstanceSets, AlarmInstances])
class AlarmInstanceSetDao extends DatabaseAccessor<AlarmDatabase>
    with _$AlarmInstanceSetDaoMixin {
  AlarmInstanceSetDao(AlarmDatabase db) : super(db);

  Future<List<AlarmInstance>> get allRecurringAlarms =>
      select(alarmInstances).get();

  Future<List<AlarmInstanceSet>> get allAlarmSets =>
      select(alarmInstanceSets).get();

  Future<List<AlarmInstanceSetDto>> getSetsWithAlarms() async {
    final query = select(alarmInstanceSets).join([
      leftOuterJoin(alarmInstances,
          alarmInstances.alarmInstanceSetId.equalsExp(alarmInstanceSets.id)),
    ]);

    return query
        .get()
        .then(
            (rows) => groupBy(rows, (row) => row.readTable(alarmInstanceSets)))
        .then((map) {
      return map.entries.map((entry) {
        final alarmSet = entry.key;
        final alarms = entry.value
            .map((row) => row.readTableOrNull(alarmInstances))
            .whereType<AlarmInstance>()
            .map(AlarmInstanceDto.from)
            .toList();
        return AlarmInstanceSetDto.from(alarmSet, alarms);
      }).toList();
    });
  }

  Future<void> saveAlarmSet(
    AlarmInstanceSetsCompanion alarmSet,
    List<AlarmInstancesCompanion> alarmList,
  ) {
    return transaction(() async {
      final id = await into(alarmInstanceSets).insert(alarmSet);
      await batch((batch) {
        final alarmsWithParentId = alarmList
            .map((alarm) => alarm.copyWith(alarmInstanceSetId: Value(id)))
            .toList();
        batch.insertAll(alarmInstances, alarmsWithParentId);
      });
    });
  }

  Future<void> updateAlarmSet(
    AlarmInstanceSetsCompanion alarmSet,
    List<AlarmInstancesCompanion> alarmList,
  ) {
    return transaction(() async {
      await update(alarmInstanceSets).replace(alarmSet);

      // Update existing alarms under this alarm set
      for (AlarmInstancesCompanion alarm in alarmList) {
        await (update(alarmInstances)
              ..where((table) => table.id.equals(alarm.id.value)))
            .write(alarm);
      }
    });
  }

  Future<int> deleteAlarmSet(int id) {
    return (delete(alarmInstanceSets)
          ..where((alarmSet) => alarmSet.id.equals(id)))
        .go();
  }

  Stream<AlarmInstanceSet> watchAlarmSetById(int id) {
    return (select(alarmInstanceSets)
          ..where((alarmSet) => alarmSet.id.equals(id)))
        .watchSingle();
  }
}

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/database/tables/alarm_tables.dart';
import 'package:walk_it_up/data/model/dto/alarm_set_dto.dart';
import 'package:walk_it_up/data/model/dto/recurring_alarm_dto.dart';

part 'alarm_set_dao.g.dart';

@DriftAccessor(tables: [AlarmSets, RecurringAlarms])
class AlarmSetDao extends DatabaseAccessor<AlarmDatabase>
    with _$AlarmSetDaoMixin {
  AlarmSetDao(AlarmDatabase db) : super(db);

  Future<List<AlarmSetDto>> getAlarmSets() async {
    final query = select(alarmSets).join([
      leftOuterJoin(
          recurringAlarms, recurringAlarms.alarmSetId.equalsExp(alarmSets.id)),
    ]);
    return query
        .get()
        .then((rows) => groupBy(rows, (row) => row.readTable(alarmSets)))
        .then((map) {
      return map.entries.map((entry) {
        final alarmSet = entry.key;
        final alarms = entry.value
            .map((row) => row.readTableOrNull(recurringAlarms))
            .whereType<RecurringAlarm>()
            .map(RecurringAlarmDto.fromDbRecurringAlarm)
            .toList();
        return AlarmSetDto.fromDbAlarmSet(alarmSet, alarms);
      }).toList();
    });
  }

  Future<void> saveAlarmSet(
    AlarmSetsCompanion alarmSet,
    List<RecurringAlarmsCompanion> alarmList,
  ) {
    return transaction(() async {
      final id = await into(alarmSets).insert(alarmSet);
      await batch((batch) {
        final alarmsWithParentId = alarmList
            .map((alarm) => alarm.copyWith(alarmSetId: Value(id)))
            .toList();
        batch.insertAll(recurringAlarms, alarmsWithParentId);
      });
    });
  }

  Future<void> updateAlarmSet(
    AlarmSetsCompanion alarmSet,
    List<RecurringAlarmsCompanion> alarmList,
  ) {
    return transaction(() async {
      await update(alarmSets).replace(alarmSet);

      // Update existing alarms under this alarm set
      for (RecurringAlarmsCompanion alarm in alarmList) {
        await (update(recurringAlarms)
              ..where((table) => table.id.equals(alarm.id.value)))
            .write(alarm);
      }
    });
  }

  Future<int> deleteAlarmSet(int id) {
    return (delete(alarmSets)..where((alarmSet) => alarmSet.id.equals(id)))
        .go();
  }

  Stream<AlarmSet> watchAlarmSetById(int id) {
    return (select(alarmSets)..where((alarmSet) => alarmSet.id.equals(id)))
        .watchSingle();
  }
}

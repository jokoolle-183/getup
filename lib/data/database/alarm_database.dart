import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:walk_it_up/constants.dart';
import 'package:walk_it_up/data/database/dao/alarm_dao/db_alarms_dao.dart';
import 'package:walk_it_up/data/database/dao/alarm_set/alarm_instances_set_dao.dart';
import 'package:walk_it_up/data/database/type_converter/enum_list_converter.dart';
import 'package:walk_it_up/data/database/type_converter/equal_list.dart';
import 'package:walk_it_up/data/model/weekdays.dart';

part 'alarm_database.g.dart'; // This will be generated by drift

@DataClassName('DbAlarm')
class DbAlarms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get audioPath => text()();
  DateTimeColumn get time => dateTime()();
  IntColumn get snoozeDuration => integer().nullable()();
  TextColumn get daysOfWeek =>
      text().map(EnumListConverter(EqualList(Weekday.values))).nullable()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
}

@DataClassName('AlarmInstanceSet')
class AlarmInstanceSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get alarmId => integer().references(
        DbAlarms,
        #id,
        onDelete: KeyAction
            .cascade, // If the set is deleted, this will set alarmSetId to null
      )();
  TextColumn get name => text().nullable()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  IntColumn get intervalBetweenAlarms => integer()();
  IntColumn get pauseDuration => integer().nullable()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
}

@DataClassName('AlarmInstance')
class AlarmInstances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get alarmId => integer()
      .references(
        DbAlarms,
        #id,
        onDelete: KeyAction
            .cascade, // If the set is deleted, this will set alarmSetId to null
      )
      .nullable()();
  IntColumn get alarmInstanceSetId => integer()
      .references(
        AlarmInstanceSets,
        #id,
        onDelete: KeyAction
            .cascade, // If the set is deleted, this will set alarmSetId to null
      )
      .nullable()();
  DateTimeColumn get time => dateTime()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
}

@DriftDatabase(
  tables: [DbAlarms, AlarmInstanceSets, AlarmInstances],
  daos: [DbAlarmDao, AlarmInstanceSetDao],
)
class AlarmDatabase extends _$AlarmDatabase {
  bool isUnderTest = false;

  AlarmDatabase() : super(_openConnection());

  AlarmDatabase.test(QueryExecutor executor) : super(executor) {
    isUnderTest = true;
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: ALARM_DATABASE);
  }

  @override
  int get schemaVersion => 1;

  // @override
  // MigrationStrategy get migration =>
  //     MigrationStrategy(beforeOpen: (details) async {
  //       // Prepopulate the db on first creation and in case it's not
  //       // for testing
  //       if (details.wasCreated && !isUnderTest) {
  //         final date = DateTime.now();
  //         final alarmId = await into(dbAlarm).insert(
  //           DbAlarmCompanion.insert(
  //             audioPath: 'assets/perfect_alarm.mp3',
  //             time: DateTime(date.year, date.month, date.day, 10, 0),
  //             daysOfWeek: Value(EqualList([
  //               Weekday.monday,
  //               Weekday.tuesday,
  //               Weekday.wednesday,
  //             ])),
  //           ),
  //         );

  //         final alarmSetId = await into(alarmInstanceSet).insert(
  //           AlarmInstanceSetCompanion.insert(
  //             alarmId: alarmId,
  //             startTime: DateTime(date.year, date.month, date.day, 9, 0),
  //             endTime: DateTime(date.year, date.month, date.day, 12, 0),
  //             intervalBetweenAlarms: 60,
  //           ),
  //         );

  //         final alarmInstances = [
  //           AlarmInstanceCompanion.insert(
  //             alarmInstanceSetId: Value(alarmSetId),
  //             time: DateTime(date.year, date.month, date.day, 10, 0),
  //           ),
  //           AlarmInstanceCompanion.insert(
  //             alarmInstanceSetId: Value(alarmSetId),
  //             time: DateTime(date.year, date.month, date.day, 11, 0),
  //           ),
  //           AlarmInstanceCompanion.insert(
  //             alarmInstanceSetId: Value(alarmSetId),
  //             time: DateTime(date.year, date.month, date.day, 12, 0),
  //           ),
  //         ];

  //         batch((batch) {
  //           batch.insertAll(alarmInstance, alarmInstances);
  //         });
  //       }
  //       // Turned off by default in sqlite 3, needs to be manually activated
  //       await customStatement('PRAGMA foreign_keys = ON');
  //     });
}

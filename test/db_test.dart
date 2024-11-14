import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/database/dao/alarm_dao/db_alarms_dao.dart';
import 'package:walk_it_up/data/database/dao/alarm_instance_dao/alarm_instance_dao.dart';
import 'package:walk_it_up/data/database/dao/alarm_set/alarm_instances_set_dao.dart';
import 'package:walk_it_up/data/database/type_converter/equal_list.dart';
import 'package:walk_it_up/data/model/weekdays.dart';

void main() {
  late AlarmDatabase database;
  late DbAlarmDao alarmsDao;
  late AlarmInstanceSetDao alarmSetDao;
  late AlarmInstancesDao alarmInstancesDao;

  // final dbAlarmCompanion = DbAlarmsCompanion.insert(
  //   id: const Value(1),
  //   snoozeDuration: const Value(10),
  //   audioPath: 'assets/perfect_alarm.mp3',
  //   isEnabled: const Value(true),
  // );
  // final alarmSetCompanion = AlarmInstanceSetsCompanion.insert(
  //   id: const Value(1),
  //   alarmId: dbAlarmCompanion.id.value,
  //   startTime: DateTime(2024, 9, 16, 10, 0),
  //   endTime: DateTime(2024, 9, 16, 18, 0),
  //   intervalBetweenAlarms: 60,
  //   pauseDuration: const Value.absentIfNull(5),
  // );

  // final alarmSetInstances = [
  //   AlarmInstancesCompanion.insert(
  //     id: const Value(1),
  //     alarmId: dbAlarmCompanion.id.value,
  //     alarmInstanceSetId: alarmSetCompanion.id,
  //     time: DateTime(2024, 9, 16, 9, 0),
  //   ),
  //   AlarmInstancesCompanion.insert(
  //     id: const Value(2),
  //     alarmId: dbAlarmCompanion.id.value,
  //     alarmInstanceSetId: alarmSetCompanion.id,
  //     time: DateTime(2024, 9, 16, 10, 0),
  //   ),
  //   AlarmInstancesCompanion.insert(
  //     id: const Value(3),
  //     alarmId: dbAlarmCompanion.id.value,
  //     alarmInstanceSetId: alarmSetCompanion.id,
  //     time: DateTime(2024, 9, 16, 11, 0),
  //   ),
  // ];

  setUp(() {
    database = AlarmDatabase.test(NativeDatabase.memory());
    alarmsDao = DbAlarmDao(database);
    alarmSetDao = AlarmInstanceSetDao(database);
    alarmInstancesDao = AlarmInstancesDao(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('Database insertion tests', () {
    // test('Insert new alarm', () async {
    //   final id = await alarmsDao.saveAlarm(
    //     DbAlarmsCompanion.insert(
    //       name: const Value.absentIfNull('Alarm'),
    //       audioPath: 'assets/some_sound.mp3',
    //       snoozeDuration: const Value(10),
    //       daysOfWeek: Value(EqualList([
    //         Weekday.monday,
    //         Weekday.tuesday,
    //         Weekday.wednesday,
    //       ])),
    //     ),
    //   );
    //   // Save alarm instance as well, without it we can't get the alarm by id
    //   await alarmInstancesDao.saveAlarmInstance(
    //     AlarmInstancesCompanion.insert(
    //       alarmId: id,
    //       time: DateTime.now(),
    //     ),
    //   );
    //   final alarm = await alarmsDao.getAlarmById(id);
    //   expect(alarm!.alarmInstance.id, id);
    // });

    // test('Insert a new AlarmSet', () async {
    //   final expectation = expectLater(
    //     alarmSetDao
    //         .watchAlarmSetById(alarmSetCompanion.id.value)
    //         .map((alarmSet) => alarmSet.id),
    //     emits(alarmSetCompanion.id.value),
    //   );

    //   await alarmSetDao.saveAlarmSet(alarmSetCompanion, alarmSetInstances);
    //   await expectation;
    // });

    //   test('Inserting a new AlarmSet inserts corresponding Alarms', () async {
    //     await alarmSetDao.saveAlarmSet(alarmSetCompanion, alarmSetInstances);
    //     final alarms = await alarmSetDao.allRecurringAlarms;

    //     final containsId =
    //         alarms.every((a) => a.alarmSetId == alarmSetCompanion.id.value);

    //     expect(alarms.length, equals(alarmSetInstances.length));
    //     expect(containsId, true);
    //   });
    // });

    // group('Database update tests', () {
    //   test('Update existing alarm', () async {
    //     final alarm = RegularAlarmsCompanion.insert(
    //       time: DateTime(2024, 9, 16, 8, 0),
    //       audioPath: 'assets/some_sound.mp3',
    //       snoozeDuration: const Value.absentIfNull(5),
    //       daysOfWeek: Value(EqualList([
    //         Weekday.monday,
    //         Weekday.tuesday,
    //         Weekday.wednesday,
    //         Weekday.thursday,
    //         Weekday.friday,
    //       ])),
    //     );
    //     final id = await alarmsDao.saveAlarm(alarm);

    //     final snoozeDurationExpectation = expectLater(
    //       alarmsDao.watchAlarmById(id).map((alarm) => alarm.snoozeDuration),
    //       emitsInOrder([5, 10]),
    //     );
    //     final dateTimeExpectation = expectLater(
    //       alarmsDao.watchAlarmById(id).map((alarm) => alarm.time),
    //       emitsInOrder(
    //           [DateTime(2024, 9, 16, 8, 0), DateTime(2024, 9, 16, 16, 0)]),
    //     );
    //     final nameExpectation = expectLater(
    //       alarmsDao.watchAlarmById(id).map((alarm) => alarm.name),
    //       emitsInOrder([null, 'Alarm']),
    //     );
    //     final daysOfWeekExpectation = expectLater(
    //       alarmsDao.watchAlarmById(id).map((alarm) => alarm.daysOfWeek),
    //       emitsInOrder([
    //         [
    //           Weekday.monday,
    //           Weekday.tuesday,
    //           Weekday.wednesday,
    //           Weekday.thursday,
    //           Weekday.friday
    //         ],
    //         [
    //           Weekday.monday,
    //           Weekday.tuesday,
    //           Weekday.wednesday,
    //           Weekday.thursday,
    //           Weekday.friday,
    //           Weekday.saturday
    //         ]
    //       ]),
    //     );
    //     final audioPathExpectation = expectLater(
    //       alarmsDao.watchAlarmById(id).map((alarm) => alarm.audioPath),
    //       emitsInOrder(['assets/some_sound.mp3', 'assets/some_other_sound.mp3']),
    //     );

    //     await alarmsDao.updateAlarm(alarm.copyWith(
    //       id: Value(id),
    //       snoozeDuration: const Value(10),
    //       time: Value(
    //         DateTime(2024, 9, 16, 16, 0),
    //       ),
    //       name: const Value('Alarm'),
    //       daysOfWeek: Value(EqualList([
    //         Weekday.monday,
    //         Weekday.tuesday,
    //         Weekday.wednesday,
    //         Weekday.thursday,
    //         Weekday.friday,
    //         Weekday.saturday,
    //       ])),
    //       audioPath: const Value('assets/some_other_sound.mp3'),
    //     ));

    //     Future.wait([
    //       snoozeDurationExpectation,
    //       dateTimeExpectation,
    //       nameExpectation,
    //       daysOfWeekExpectation,
    //       audioPathExpectation
    //     ]);
    //   });

    //   test('Update existing alarm set ', () async {
    //     await alarmSetDao.saveAlarmSet(alarmSetCompanion, alarmSetInstances);

    //     final startTimeExpectation = expectLater(
    //       alarmSetDao
    //           .watchAlarmSetById(alarmSetCompanion.id.value)
    //           .map((alarm) => alarm.startTime),
    //       emitsInOrder([
    //         alarmSetCompanion.startTime.value,
    //         DateTime(2024, 9, 16, 16, 0),
    //       ]),
    //     );

    //     final endTimeExpectation = expectLater(
    //       alarmSetDao
    //           .watchAlarmSetById(alarmSetCompanion.id.value)
    //           .map((alarm) => alarm.endTime),
    //       emitsInOrder([
    //         alarmSetCompanion.endTime.value,
    //         DateTime(2024, 9, 16, 22, 0),
    //       ]),
    //     );

    //     final intervalBetweenAlarmsExpectation = expectLater(
    //       alarmSetDao
    //           .watchAlarmSetById(alarmSetCompanion.id.value)
    //           .map((alarm) => alarm.intervalBetweenAlarms),
    //       emitsInOrder([
    //         alarmSetCompanion.intervalBetweenAlarms.value,
    //         120,
    //       ]),
    //     );

    //     final pauseDurationExpectation = expectLater(
    //       alarmSetDao
    //           .watchAlarmSetById(alarmSetCompanion.id.value)
    //           .map((alarm) => alarm.pauseDuration),
    //       emitsInOrder([
    //         alarmSetCompanion.pauseDuration.value,
    //         10,
    //       ]),
    //     );

    //     final nameExpectation = expectLater(
    //       alarmSetDao
    //           .watchAlarmSetById(alarmSetCompanion.id.value)
    //           .map((alarm) => alarm.name),
    //       emitsInOrder([alarmSetCompanion.name.value, 'Alarm Set 2']),
    //     );

    //     final daysOfWeekExpectation = expectLater(
    //       alarmSetDao
    //           .watchAlarmSetById(alarmSetCompanion.id.value)
    //           .map((alarm) => alarm.daysOfWeek),
    //       emitsInOrder([
    //         alarmSetCompanion.daysOfWeek.value,
    //         [
    //           Weekday.monday,
    //           Weekday.tuesday,
    //           Weekday.wednesday,
    //           Weekday.thursday,
    //           Weekday.friday,
    //           Weekday.saturday
    //         ]
    //       ]),
    //     );

    //     final audioPathExpectation = expectLater(
    //       alarmSetDao
    //           .watchAlarmSetById(alarmSetCompanion.id.value)
    //           .map((alarm) => alarm.audioPath),
    //       emitsInOrder(
    //           [alarmSetCompanion.audioPath.value, 'assets/some_other_sound.mp3']),
    //     );

    //     //TODO: Add a test case for changing start and end time and how that affects
    //     // the quantity of recurring alarms

    //     // In order to implement this, an additional factory class for creating
    //     // recurring alarms is needed, which will be additionally tested

    //     final updatedAlarms = alarmSetInstances.indexed
    //         .map((entry) => entry.$2
    //             .copyWith(time: Value(DateTime(2024, 9, 16, 16 + entry.$1, 0))))
    //         .toList();

    //     await alarmSetDao.updateAlarmSet(
    //       alarmSetCompanion.copyWith(
    //           name: const Value('Alarm Set 2'),
    //           startTime: Value(DateTime(2024, 9, 16, 16, 0)),
    //           endTime: Value(DateTime(2024, 9, 16, 22, 0)),
    //           audioPath: const Value('assets/some_other_sound.mp3'),
    //           intervalBetweenAlarms: const Value(120),
    //           pauseDuration: const Value(10),
    //           daysOfWeek: Value(EqualList([
    //             Weekday.monday,
    //             Weekday.tuesday,
    //             Weekday.wednesday,
    //             Weekday.thursday,
    //             Weekday.friday,
    //             Weekday.saturday,
    //           ]))),
    //       updatedAlarms,
    //     );

    //     // Check for updated recurring alarms equality
    //     final updatedDbAlarms = await alarmSetDao.allRecurringAlarms
    //         .then((value) => value.sortedBy((a) => a.time));

    //     expect(updatedDbAlarms[0].time, updatedAlarms[0].time.value);
    //     expect(updatedDbAlarms[1].time, updatedAlarms[1].time.value);
    //     expect(updatedDbAlarms[2].time, updatedAlarms[2].time.value);

    //     // Wait for alarm set property expectations
    //     Future.wait([
    //       startTimeExpectation,
    //       endTimeExpectation,
    //       nameExpectation,
    //       daysOfWeekExpectation,
    //       audioPathExpectation,
    //       pauseDurationExpectation,
    //       intervalBetweenAlarmsExpectation,
    //     ]);
    //   });
    // });

    // group('Database item deletion tests', () {
    //   test('Deleting a RegularAlarm', () async {
    //     var regularAlarmsCompanion = RegularAlarmsCompanion.insert(
    //       time: DateTime(2024, 9, 16, 8, 0),
    //       audioPath: 'assets/some_sound.mp3',
    //       snoozeDuration: const Value.absentIfNull(5),
    //       daysOfWeek: Value(EqualList([
    //         Weekday.monday,
    //         Weekday.tuesday,
    //         Weekday.wednesday,
    //         Weekday.thursday,
    //         Weekday.friday
    //       ])),
    //     );

    //     final id =
    //         await alarmsDao.saveAlarm(regularAlarmsCompanion).then((value) {
    //       regularAlarmsCompanion =
    //           regularAlarmsCompanion.copyWith(id: Value(value));
    //       return value;
    //     });
    //     final allAlarms = await alarmsDao.allRegularAlarms;
    //     final instertedAlarm = allAlarms.first;

    //     expect(regularAlarmsCompanion.id.value, instertedAlarm.id);
    //     expect(regularAlarmsCompanion.name.value, instertedAlarm.name);
    //     expect(regularAlarmsCompanion.time.value, instertedAlarm.time);
    //     expect(regularAlarmsCompanion.snoozeDuration.value,
    //         instertedAlarm.snoozeDuration);
    //     expect(regularAlarmsCompanion.audioPath.value, instertedAlarm.audioPath);
    //     expect(
    //         regularAlarmsCompanion.daysOfWeek.value, instertedAlarm.daysOfWeek);

    //     await alarmsDao.deleteAlarm(id);
    //     final remainingAlarms = await alarmsDao.allRegularAlarms;
    //     expect(remainingAlarms, isEmpty);
    //   });

    //   test('Deleting an AlarmSet deletes RecurringAlarms also', () async {
    //     await alarmSetDao.saveAlarmSet(alarmSetCompanion, alarmSetInstances);

    //     final allAlarmSets = await alarmSetDao.allAlarmSets;
    //     final allRecurringAlarms = await alarmSetDao.allRecurringAlarms;
    //     final instertedAlarmSet = allAlarmSets.first;
    //     final containsId = allRecurringAlarms
    //         .every((a) => a.alarmSetId == alarmSetCompanion.id.value);

    //     expect(containsId, true);
    //     expect(allRecurringAlarms.length, alarmSetInstances.length);
    //     expect(alarmSetCompanion.id.value, instertedAlarmSet.id);
    //     expect(alarmSetCompanion.name.value, instertedAlarmSet.name);
    //     expect(alarmSetCompanion.startTime.value, instertedAlarmSet.startTime);
    //     expect(alarmSetCompanion.endTime.value, instertedAlarmSet.endTime);
    //     expect(alarmSetCompanion.audioPath.value, instertedAlarmSet.audioPath);
    //     expect(alarmSetCompanion.daysOfWeek.value, instertedAlarmSet.daysOfWeek);

    //     await alarmSetDao.deleteAlarmSet(alarmSetCompanion.id.value);
    //     final remainingAlarmSets = await alarmSetDao.allAlarmSets;
    //     final remainingRecurringAlarms = await alarmSetDao.allRecurringAlarms;

    //     expect(remainingAlarmSets, isEmpty);
    //     expect(remainingRecurringAlarms, isEmpty);
    //   });
  });
}

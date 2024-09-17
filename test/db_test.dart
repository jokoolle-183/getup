import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';
import 'package:walk_it_up/data/database/alarm_database.dart';
import 'package:walk_it_up/data/database/alarm_mapper.dart';
import 'package:walk_it_up/data/dto/alarm_dto.dart';

void main() {
  late AlarmDatabase database;

  final alarmSetCompanion = AlarmSetsCompanion.insert(
    id: const Value(1),
    startTime: DateTime(2024, 9, 16, 10, 0),
    endTime: DateTime(2024, 9, 16, 18, 0),
    intervalBetweenAlarms: 60,
    pauseDuration: const Value.absentIfNull(5),
    daysOfWeek: 'Mon, Tue, Thu',
  );

  final alarmCompanionList = [
    AlarmsCompanion.insert(
      id: const Value(1),
      time: DateTime(2024, 9, 16, 8, 0),
      audioPath: 'assets/some_sound.mp3',
      snoozeDuration: 5,
      daysOfWeek: "Mon, Tue, Wed, Thu, Fri",
    ),
    AlarmsCompanion.insert(
      id: const Value(2),
      time: DateTime(2024, 9, 16, 9, 0),
      audioPath: 'assets/some_sound1.mp3',
      snoozeDuration: 10,
      daysOfWeek: "Mon, Tue, Wed, Thu",
    ),
    AlarmsCompanion.insert(
      id: const Value(3),
      time: DateTime(2024, 9, 16, 10, 0),
      audioPath: 'assets/some_sound2.mp3',
      snoozeDuration: 15,
      daysOfWeek: "Mon, Tue, Wed",
    ),
  ];

  setUp(() {
    database = AlarmDatabase.test(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('Database insertion tests', () {
    test('Insert new alarm', () async {
      final id = await database.saveAlarm(
        AlarmsCompanion.insert(
            name: const Value.absentIfNull('Alarm'),
            audioPath: 'assets/some_sound.mp3',
            time: DateTime.now(),
            snoozeDuration: 10,
            daysOfWeek: "Mon, Tue, Wed"),
      );
      final alarm = await database.watchAlarmById(id).first;

      expect(alarm.id, id);
    });

    test('Save multiple alarms', () async {
      final expectedAlarms = alarmCompanionList
          .map((companion) => AlarmMapper.mapCompanionToAlarm(companion))
          .toList();

      await database.saveMultipleAlarms(alarmCompanionList);

      final allDbAlarms = await database.allAlarms;

      final actualAlarms =
          allDbAlarms.map((dbAlarm) => AlarmDto.fromDbAlarm(dbAlarm)).toList();

      expect(actualAlarms, equals(expectedAlarms));
    });

    test('Save a new AlarmSet', () async {
      final expectation = expectLater(
        database
            .watchAlarmSetById(alarmSetCompanion.id.value)
            .map((alarmSet) => alarmSet.id),
        emits(alarmSetCompanion.id.value),
      );

      await database.saveAlarmSet(alarmSetCompanion, alarmCompanionList);
      await expectation;
    });

    test(
        'Saving an AlarmSet creates corresponding entries in the junction table',
        () async {
      await database.saveAlarmSet(alarmSetCompanion, alarmCompanionList);

      final alarmSetAlarms = await database.allAlarmSetAlarms;

      expect(alarmSetAlarms.length, equals(alarmCompanionList.length));
    });
  });
}

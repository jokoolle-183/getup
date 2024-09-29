import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/type_converter/enum_list_converter.dart';
import 'package:walk_it_up/data/database/type_converter/equal_list.dart';
import 'package:walk_it_up/data/model/weekdays.dart';

@DataClassName('RegularAlarm')
class RegularAlarms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get audioPath => text()();
  DateTimeColumn get time => dateTime()();
  IntColumn get snoozeDuration => integer().nullable()();
  TextColumn get daysOfWeek =>
      text().map(EnumListConverter(EqualList(Weekday.values))).nullable()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
}

@DataClassName('AlarmSet')
class AlarmSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get audioPath => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  IntColumn get intervalBetweenAlarms => integer()();
  IntColumn get pauseDuration => integer().nullable()();
  TextColumn get daysOfWeek =>
      text().map(EnumListConverter(EqualList(Weekday.values))).nullable()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
}

@DataClassName('RecurringAlarm')
class RecurringAlarms extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get alarmSetId => integer().references(
        AlarmSets,
        #id,
        onDelete: KeyAction
            .cascade, // If the set is deleted, this will set alarmSetId to null
      )();
  DateTimeColumn get time => dateTime()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
}

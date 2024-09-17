// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_database.dart';

// ignore_for_file: type=lint
class $AlarmsTable extends Alarms with TableInfo<$AlarmsTable, DbAlarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _audioPathMeta =
      const VerificationMeta('audioPath');
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
      'audio_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _snoozeDurationMeta =
      const VerificationMeta('snoozeDuration');
  @override
  late final GeneratedColumn<int> snoozeDuration = GeneratedColumn<int>(
      'snooze_duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _daysOfWeekMeta =
      const VerificationMeta('daysOfWeek');
  @override
  late final GeneratedColumn<String> daysOfWeek = GeneratedColumn<String>(
      'days_of_week', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, audioPath, time, snoozeDuration, daysOfWeek];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarms';
  @override
  VerificationContext validateIntegrity(Insertable<DbAlarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('audio_path')) {
      context.handle(_audioPathMeta,
          audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta));
    } else if (isInserting) {
      context.missing(_audioPathMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('snooze_duration')) {
      context.handle(
          _snoozeDurationMeta,
          snoozeDuration.isAcceptableOrUnknown(
              data['snooze_duration']!, _snoozeDurationMeta));
    } else if (isInserting) {
      context.missing(_snoozeDurationMeta);
    }
    if (data.containsKey('days_of_week')) {
      context.handle(
          _daysOfWeekMeta,
          daysOfWeek.isAcceptableOrUnknown(
              data['days_of_week']!, _daysOfWeekMeta));
    } else if (isInserting) {
      context.missing(_daysOfWeekMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbAlarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbAlarm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      audioPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_path'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      snoozeDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}snooze_duration'])!,
      daysOfWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}days_of_week'])!,
    );
  }

  @override
  $AlarmsTable createAlias(String alias) {
    return $AlarmsTable(attachedDatabase, alias);
  }
}

class DbAlarm extends DataClass implements Insertable<DbAlarm> {
  final int id;
  final String? name;
  final String audioPath;
  final DateTime time;
  final int snoozeDuration;
  final String daysOfWeek;
  const DbAlarm(
      {required this.id,
      this.name,
      required this.audioPath,
      required this.time,
      required this.snoozeDuration,
      required this.daysOfWeek});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['audio_path'] = Variable<String>(audioPath);
    map['time'] = Variable<DateTime>(time);
    map['snooze_duration'] = Variable<int>(snoozeDuration);
    map['days_of_week'] = Variable<String>(daysOfWeek);
    return map;
  }

  AlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      audioPath: Value(audioPath),
      time: Value(time),
      snoozeDuration: Value(snoozeDuration),
      daysOfWeek: Value(daysOfWeek),
    );
  }

  factory DbAlarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbAlarm(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      audioPath: serializer.fromJson<String>(json['audioPath']),
      time: serializer.fromJson<DateTime>(json['time']),
      snoozeDuration: serializer.fromJson<int>(json['snoozeDuration']),
      daysOfWeek: serializer.fromJson<String>(json['daysOfWeek']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'audioPath': serializer.toJson<String>(audioPath),
      'time': serializer.toJson<DateTime>(time),
      'snoozeDuration': serializer.toJson<int>(snoozeDuration),
      'daysOfWeek': serializer.toJson<String>(daysOfWeek),
    };
  }

  DbAlarm copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          String? audioPath,
          DateTime? time,
          int? snoozeDuration,
          String? daysOfWeek}) =>
      DbAlarm(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        audioPath: audioPath ?? this.audioPath,
        time: time ?? this.time,
        snoozeDuration: snoozeDuration ?? this.snoozeDuration,
        daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      );
  DbAlarm copyWithCompanion(AlarmsCompanion data) {
    return DbAlarm(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      time: data.time.present ? data.time.value : this.time,
      snoozeDuration: data.snoozeDuration.present
          ? data.snoozeDuration.value
          : this.snoozeDuration,
      daysOfWeek:
          data.daysOfWeek.present ? data.daysOfWeek.value : this.daysOfWeek,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbAlarm(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('audioPath: $audioPath, ')
          ..write('time: $time, ')
          ..write('snoozeDuration: $snoozeDuration, ')
          ..write('daysOfWeek: $daysOfWeek')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, audioPath, time, snoozeDuration, daysOfWeek);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbAlarm &&
          other.id == this.id &&
          other.name == this.name &&
          other.audioPath == this.audioPath &&
          other.time == this.time &&
          other.snoozeDuration == this.snoozeDuration &&
          other.daysOfWeek == this.daysOfWeek);
}

class AlarmsCompanion extends UpdateCompanion<DbAlarm> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String> audioPath;
  final Value<DateTime> time;
  final Value<int> snoozeDuration;
  final Value<String> daysOfWeek;
  const AlarmsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.time = const Value.absent(),
    this.snoozeDuration = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
  });
  AlarmsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required String audioPath,
    required DateTime time,
    required int snoozeDuration,
    required String daysOfWeek,
  })  : audioPath = Value(audioPath),
        time = Value(time),
        snoozeDuration = Value(snoozeDuration),
        daysOfWeek = Value(daysOfWeek);
  static Insertable<DbAlarm> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? audioPath,
    Expression<DateTime>? time,
    Expression<int>? snoozeDuration,
    Expression<String>? daysOfWeek,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (audioPath != null) 'audio_path': audioPath,
      if (time != null) 'time': time,
      if (snoozeDuration != null) 'snooze_duration': snoozeDuration,
      if (daysOfWeek != null) 'days_of_week': daysOfWeek,
    });
  }

  AlarmsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String>? audioPath,
      Value<DateTime>? time,
      Value<int>? snoozeDuration,
      Value<String>? daysOfWeek}) {
    return AlarmsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      audioPath: audioPath ?? this.audioPath,
      time: time ?? this.time,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (snoozeDuration.present) {
      map['snooze_duration'] = Variable<int>(snoozeDuration.value);
    }
    if (daysOfWeek.present) {
      map['days_of_week'] = Variable<String>(daysOfWeek.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('audioPath: $audioPath, ')
          ..write('time: $time, ')
          ..write('snoozeDuration: $snoozeDuration, ')
          ..write('daysOfWeek: $daysOfWeek')
          ..write(')'))
        .toString();
  }
}

class $AlarmSetsTable extends AlarmSets
    with TableInfo<$AlarmSetsTable, AlarmSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _intervalBetweenAlarmsMeta =
      const VerificationMeta('intervalBetweenAlarms');
  @override
  late final GeneratedColumn<int> intervalBetweenAlarms = GeneratedColumn<int>(
      'interval_between_alarms', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pauseDurationMeta =
      const VerificationMeta('pauseDuration');
  @override
  late final GeneratedColumn<int> pauseDuration = GeneratedColumn<int>(
      'pause_duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _daysOfWeekMeta =
      const VerificationMeta('daysOfWeek');
  @override
  late final GeneratedColumn<String> daysOfWeek = GeneratedColumn<String>(
      'days_of_week', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        startTime,
        endTime,
        intervalBetweenAlarms,
        pauseDuration,
        daysOfWeek
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarm_sets';
  @override
  VerificationContext validateIntegrity(Insertable<AlarmSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('interval_between_alarms')) {
      context.handle(
          _intervalBetweenAlarmsMeta,
          intervalBetweenAlarms.isAcceptableOrUnknown(
              data['interval_between_alarms']!, _intervalBetweenAlarmsMeta));
    } else if (isInserting) {
      context.missing(_intervalBetweenAlarmsMeta);
    }
    if (data.containsKey('pause_duration')) {
      context.handle(
          _pauseDurationMeta,
          pauseDuration.isAcceptableOrUnknown(
              data['pause_duration']!, _pauseDurationMeta));
    }
    if (data.containsKey('days_of_week')) {
      context.handle(
          _daysOfWeekMeta,
          daysOfWeek.isAcceptableOrUnknown(
              data['days_of_week']!, _daysOfWeekMeta));
    } else if (isInserting) {
      context.missing(_daysOfWeekMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlarmSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmSet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time'])!,
      intervalBetweenAlarms: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}interval_between_alarms'])!,
      pauseDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pause_duration']),
      daysOfWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}days_of_week'])!,
    );
  }

  @override
  $AlarmSetsTable createAlias(String alias) {
    return $AlarmSetsTable(attachedDatabase, alias);
  }
}

class AlarmSet extends DataClass implements Insertable<AlarmSet> {
  final int id;
  final String? name;
  final DateTime startTime;
  final DateTime endTime;
  final int intervalBetweenAlarms;
  final int? pauseDuration;
  final String daysOfWeek;
  const AlarmSet(
      {required this.id,
      this.name,
      required this.startTime,
      required this.endTime,
      required this.intervalBetweenAlarms,
      this.pauseDuration,
      required this.daysOfWeek});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['interval_between_alarms'] = Variable<int>(intervalBetweenAlarms);
    if (!nullToAbsent || pauseDuration != null) {
      map['pause_duration'] = Variable<int>(pauseDuration);
    }
    map['days_of_week'] = Variable<String>(daysOfWeek);
    return map;
  }

  AlarmSetsCompanion toCompanion(bool nullToAbsent) {
    return AlarmSetsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      startTime: Value(startTime),
      endTime: Value(endTime),
      intervalBetweenAlarms: Value(intervalBetweenAlarms),
      pauseDuration: pauseDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(pauseDuration),
      daysOfWeek: Value(daysOfWeek),
    );
  }

  factory AlarmSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmSet(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      intervalBetweenAlarms:
          serializer.fromJson<int>(json['intervalBetweenAlarms']),
      pauseDuration: serializer.fromJson<int?>(json['pauseDuration']),
      daysOfWeek: serializer.fromJson<String>(json['daysOfWeek']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'intervalBetweenAlarms': serializer.toJson<int>(intervalBetweenAlarms),
      'pauseDuration': serializer.toJson<int?>(pauseDuration),
      'daysOfWeek': serializer.toJson<String>(daysOfWeek),
    };
  }

  AlarmSet copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          DateTime? startTime,
          DateTime? endTime,
          int? intervalBetweenAlarms,
          Value<int?> pauseDuration = const Value.absent(),
          String? daysOfWeek}) =>
      AlarmSet(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        intervalBetweenAlarms:
            intervalBetweenAlarms ?? this.intervalBetweenAlarms,
        pauseDuration:
            pauseDuration.present ? pauseDuration.value : this.pauseDuration,
        daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      );
  AlarmSet copyWithCompanion(AlarmSetsCompanion data) {
    return AlarmSet(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      intervalBetweenAlarms: data.intervalBetweenAlarms.present
          ? data.intervalBetweenAlarms.value
          : this.intervalBetweenAlarms,
      pauseDuration: data.pauseDuration.present
          ? data.pauseDuration.value
          : this.pauseDuration,
      daysOfWeek:
          data.daysOfWeek.present ? data.daysOfWeek.value : this.daysOfWeek,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmSet(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('intervalBetweenAlarms: $intervalBetweenAlarms, ')
          ..write('pauseDuration: $pauseDuration, ')
          ..write('daysOfWeek: $daysOfWeek')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, startTime, endTime,
      intervalBetweenAlarms, pauseDuration, daysOfWeek);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmSet &&
          other.id == this.id &&
          other.name == this.name &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.intervalBetweenAlarms == this.intervalBetweenAlarms &&
          other.pauseDuration == this.pauseDuration &&
          other.daysOfWeek == this.daysOfWeek);
}

class AlarmSetsCompanion extends UpdateCompanion<AlarmSet> {
  final Value<int> id;
  final Value<String?> name;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<int> intervalBetweenAlarms;
  final Value<int?> pauseDuration;
  final Value<String> daysOfWeek;
  const AlarmSetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.intervalBetweenAlarms = const Value.absent(),
    this.pauseDuration = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
  });
  AlarmSetsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required DateTime startTime,
    required DateTime endTime,
    required int intervalBetweenAlarms,
    this.pauseDuration = const Value.absent(),
    required String daysOfWeek,
  })  : startTime = Value(startTime),
        endTime = Value(endTime),
        intervalBetweenAlarms = Value(intervalBetweenAlarms),
        daysOfWeek = Value(daysOfWeek);
  static Insertable<AlarmSet> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? intervalBetweenAlarms,
    Expression<int>? pauseDuration,
    Expression<String>? daysOfWeek,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (intervalBetweenAlarms != null)
        'interval_between_alarms': intervalBetweenAlarms,
      if (pauseDuration != null) 'pause_duration': pauseDuration,
      if (daysOfWeek != null) 'days_of_week': daysOfWeek,
    });
  }

  AlarmSetsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<int>? intervalBetweenAlarms,
      Value<int?>? pauseDuration,
      Value<String>? daysOfWeek}) {
    return AlarmSetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      intervalBetweenAlarms:
          intervalBetweenAlarms ?? this.intervalBetweenAlarms,
      pauseDuration: pauseDuration ?? this.pauseDuration,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (intervalBetweenAlarms.present) {
      map['interval_between_alarms'] =
          Variable<int>(intervalBetweenAlarms.value);
    }
    if (pauseDuration.present) {
      map['pause_duration'] = Variable<int>(pauseDuration.value);
    }
    if (daysOfWeek.present) {
      map['days_of_week'] = Variable<String>(daysOfWeek.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmSetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('intervalBetweenAlarms: $intervalBetweenAlarms, ')
          ..write('pauseDuration: $pauseDuration, ')
          ..write('daysOfWeek: $daysOfWeek')
          ..write(')'))
        .toString();
  }
}

class $AlarmSetAlarmsTable extends AlarmSetAlarms
    with TableInfo<$AlarmSetAlarmsTable, AlarmSetAlarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmSetAlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _alarmSetIdMeta =
      const VerificationMeta('alarmSetId');
  @override
  late final GeneratedColumn<int> alarmSetId = GeneratedColumn<int>(
      'alarm_set_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES alarm_sets (id) ON DELETE CASCADE'));
  static const VerificationMeta _alarmIdMeta =
      const VerificationMeta('alarmId');
  @override
  late final GeneratedColumn<int> alarmId = GeneratedColumn<int>(
      'alarm_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES alarms (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [alarmSetId, alarmId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarm_set_alarms';
  @override
  VerificationContext validateIntegrity(Insertable<AlarmSetAlarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('alarm_set_id')) {
      context.handle(
          _alarmSetIdMeta,
          alarmSetId.isAcceptableOrUnknown(
              data['alarm_set_id']!, _alarmSetIdMeta));
    } else if (isInserting) {
      context.missing(_alarmSetIdMeta);
    }
    if (data.containsKey('alarm_id')) {
      context.handle(_alarmIdMeta,
          alarmId.isAcceptableOrUnknown(data['alarm_id']!, _alarmIdMeta));
    } else if (isInserting) {
      context.missing(_alarmIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {alarmSetId, alarmId};
  @override
  AlarmSetAlarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmSetAlarm(
      alarmSetId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}alarm_set_id'])!,
      alarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}alarm_id'])!,
    );
  }

  @override
  $AlarmSetAlarmsTable createAlias(String alias) {
    return $AlarmSetAlarmsTable(attachedDatabase, alias);
  }
}

class AlarmSetAlarm extends DataClass implements Insertable<AlarmSetAlarm> {
  final int alarmSetId;
  final int alarmId;
  const AlarmSetAlarm({required this.alarmSetId, required this.alarmId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['alarm_set_id'] = Variable<int>(alarmSetId);
    map['alarm_id'] = Variable<int>(alarmId);
    return map;
  }

  AlarmSetAlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmSetAlarmsCompanion(
      alarmSetId: Value(alarmSetId),
      alarmId: Value(alarmId),
    );
  }

  factory AlarmSetAlarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmSetAlarm(
      alarmSetId: serializer.fromJson<int>(json['alarmSetId']),
      alarmId: serializer.fromJson<int>(json['alarmId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'alarmSetId': serializer.toJson<int>(alarmSetId),
      'alarmId': serializer.toJson<int>(alarmId),
    };
  }

  AlarmSetAlarm copyWith({int? alarmSetId, int? alarmId}) => AlarmSetAlarm(
        alarmSetId: alarmSetId ?? this.alarmSetId,
        alarmId: alarmId ?? this.alarmId,
      );
  AlarmSetAlarm copyWithCompanion(AlarmSetAlarmsCompanion data) {
    return AlarmSetAlarm(
      alarmSetId:
          data.alarmSetId.present ? data.alarmSetId.value : this.alarmSetId,
      alarmId: data.alarmId.present ? data.alarmId.value : this.alarmId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmSetAlarm(')
          ..write('alarmSetId: $alarmSetId, ')
          ..write('alarmId: $alarmId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(alarmSetId, alarmId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmSetAlarm &&
          other.alarmSetId == this.alarmSetId &&
          other.alarmId == this.alarmId);
}

class AlarmSetAlarmsCompanion extends UpdateCompanion<AlarmSetAlarm> {
  final Value<int> alarmSetId;
  final Value<int> alarmId;
  final Value<int> rowid;
  const AlarmSetAlarmsCompanion({
    this.alarmSetId = const Value.absent(),
    this.alarmId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlarmSetAlarmsCompanion.insert({
    required int alarmSetId,
    required int alarmId,
    this.rowid = const Value.absent(),
  })  : alarmSetId = Value(alarmSetId),
        alarmId = Value(alarmId);
  static Insertable<AlarmSetAlarm> custom({
    Expression<int>? alarmSetId,
    Expression<int>? alarmId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (alarmSetId != null) 'alarm_set_id': alarmSetId,
      if (alarmId != null) 'alarm_id': alarmId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlarmSetAlarmsCompanion copyWith(
      {Value<int>? alarmSetId, Value<int>? alarmId, Value<int>? rowid}) {
    return AlarmSetAlarmsCompanion(
      alarmSetId: alarmSetId ?? this.alarmSetId,
      alarmId: alarmId ?? this.alarmId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (alarmSetId.present) {
      map['alarm_set_id'] = Variable<int>(alarmSetId.value);
    }
    if (alarmId.present) {
      map['alarm_id'] = Variable<int>(alarmId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmSetAlarmsCompanion(')
          ..write('alarmSetId: $alarmSetId, ')
          ..write('alarmId: $alarmId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AlarmDatabase extends GeneratedDatabase {
  _$AlarmDatabase(QueryExecutor e) : super(e);
  $AlarmDatabaseManager get managers => $AlarmDatabaseManager(this);
  late final $AlarmsTable alarms = $AlarmsTable(this);
  late final $AlarmSetsTable alarmSets = $AlarmSetsTable(this);
  late final $AlarmSetAlarmsTable alarmSetAlarms = $AlarmSetAlarmsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [alarms, alarmSets, alarmSetAlarms];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('alarm_sets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('alarm_set_alarms', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('alarms',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('alarm_set_alarms', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$AlarmsTableCreateCompanionBuilder = AlarmsCompanion Function({
  Value<int> id,
  Value<String?> name,
  required String audioPath,
  required DateTime time,
  required int snoozeDuration,
  required String daysOfWeek,
});
typedef $$AlarmsTableUpdateCompanionBuilder = AlarmsCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String> audioPath,
  Value<DateTime> time,
  Value<int> snoozeDuration,
  Value<String> daysOfWeek,
});

final class $$AlarmsTableReferences
    extends BaseReferences<_$AlarmDatabase, $AlarmsTable, DbAlarm> {
  $$AlarmsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AlarmSetAlarmsTable, List<AlarmSetAlarm>>
      _alarmSetAlarmsRefsTable(_$AlarmDatabase db) =>
          MultiTypedResultKey.fromTable(db.alarmSetAlarms,
              aliasName: $_aliasNameGenerator(
                  db.alarms.id, db.alarmSetAlarms.alarmId));

  $$AlarmSetAlarmsTableProcessedTableManager get alarmSetAlarmsRefs {
    final manager = $$AlarmSetAlarmsTableTableManager($_db, $_db.alarmSetAlarms)
        .filter((f) => f.alarmId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_alarmSetAlarmsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AlarmsTableFilterComposer
    extends FilterComposer<_$AlarmDatabase, $AlarmsTable> {
  $$AlarmsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get audioPath => $state.composableBuilder(
      column: $state.table.audioPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get snoozeDuration => $state.composableBuilder(
      column: $state.table.snoozeDuration,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get daysOfWeek => $state.composableBuilder(
      column: $state.table.daysOfWeek,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter alarmSetAlarmsRefs(
      ComposableFilter Function($$AlarmSetAlarmsTableFilterComposer f) f) {
    final $$AlarmSetAlarmsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.alarmSetAlarms,
        getReferencedColumn: (t) => t.alarmId,
        builder: (joinBuilder, parentComposers) =>
            $$AlarmSetAlarmsTableFilterComposer(ComposerState($state.db,
                $state.db.alarmSetAlarms, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$AlarmsTableOrderingComposer
    extends OrderingComposer<_$AlarmDatabase, $AlarmsTable> {
  $$AlarmsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get audioPath => $state.composableBuilder(
      column: $state.table.audioPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get snoozeDuration => $state.composableBuilder(
      column: $state.table.snoozeDuration,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get daysOfWeek => $state.composableBuilder(
      column: $state.table.daysOfWeek,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$AlarmsTableTableManager extends RootTableManager<
    _$AlarmDatabase,
    $AlarmsTable,
    DbAlarm,
    $$AlarmsTableFilterComposer,
    $$AlarmsTableOrderingComposer,
    $$AlarmsTableCreateCompanionBuilder,
    $$AlarmsTableUpdateCompanionBuilder,
    (DbAlarm, $$AlarmsTableReferences),
    DbAlarm,
    PrefetchHooks Function({bool alarmSetAlarmsRefs})> {
  $$AlarmsTableTableManager(_$AlarmDatabase db, $AlarmsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AlarmsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AlarmsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String> audioPath = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<int> snoozeDuration = const Value.absent(),
            Value<String> daysOfWeek = const Value.absent(),
          }) =>
              AlarmsCompanion(
            id: id,
            name: name,
            audioPath: audioPath,
            time: time,
            snoozeDuration: snoozeDuration,
            daysOfWeek: daysOfWeek,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required String audioPath,
            required DateTime time,
            required int snoozeDuration,
            required String daysOfWeek,
          }) =>
              AlarmsCompanion.insert(
            id: id,
            name: name,
            audioPath: audioPath,
            time: time,
            snoozeDuration: snoozeDuration,
            daysOfWeek: daysOfWeek,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AlarmsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({alarmSetAlarmsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (alarmSetAlarmsRefs) db.alarmSetAlarms
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (alarmSetAlarmsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AlarmsTableReferences
                            ._alarmSetAlarmsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AlarmsTableReferences(db, table, p0)
                                .alarmSetAlarmsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.alarmId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AlarmsTableProcessedTableManager = ProcessedTableManager<
    _$AlarmDatabase,
    $AlarmsTable,
    DbAlarm,
    $$AlarmsTableFilterComposer,
    $$AlarmsTableOrderingComposer,
    $$AlarmsTableCreateCompanionBuilder,
    $$AlarmsTableUpdateCompanionBuilder,
    (DbAlarm, $$AlarmsTableReferences),
    DbAlarm,
    PrefetchHooks Function({bool alarmSetAlarmsRefs})>;
typedef $$AlarmSetsTableCreateCompanionBuilder = AlarmSetsCompanion Function({
  Value<int> id,
  Value<String?> name,
  required DateTime startTime,
  required DateTime endTime,
  required int intervalBetweenAlarms,
  Value<int?> pauseDuration,
  required String daysOfWeek,
});
typedef $$AlarmSetsTableUpdateCompanionBuilder = AlarmSetsCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<int> intervalBetweenAlarms,
  Value<int?> pauseDuration,
  Value<String> daysOfWeek,
});

final class $$AlarmSetsTableReferences
    extends BaseReferences<_$AlarmDatabase, $AlarmSetsTable, AlarmSet> {
  $$AlarmSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AlarmSetAlarmsTable, List<AlarmSetAlarm>>
      _alarmSetAlarmsRefsTable(_$AlarmDatabase db) =>
          MultiTypedResultKey.fromTable(db.alarmSetAlarms,
              aliasName: $_aliasNameGenerator(
                  db.alarmSets.id, db.alarmSetAlarms.alarmSetId));

  $$AlarmSetAlarmsTableProcessedTableManager get alarmSetAlarmsRefs {
    final manager = $$AlarmSetAlarmsTableTableManager($_db, $_db.alarmSetAlarms)
        .filter((f) => f.alarmSetId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_alarmSetAlarmsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AlarmSetsTableFilterComposer
    extends FilterComposer<_$AlarmDatabase, $AlarmSetsTable> {
  $$AlarmSetsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get intervalBetweenAlarms => $state.composableBuilder(
      column: $state.table.intervalBetweenAlarms,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get pauseDuration => $state.composableBuilder(
      column: $state.table.pauseDuration,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get daysOfWeek => $state.composableBuilder(
      column: $state.table.daysOfWeek,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter alarmSetAlarmsRefs(
      ComposableFilter Function($$AlarmSetAlarmsTableFilterComposer f) f) {
    final $$AlarmSetAlarmsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.alarmSetAlarms,
        getReferencedColumn: (t) => t.alarmSetId,
        builder: (joinBuilder, parentComposers) =>
            $$AlarmSetAlarmsTableFilterComposer(ComposerState($state.db,
                $state.db.alarmSetAlarms, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$AlarmSetsTableOrderingComposer
    extends OrderingComposer<_$AlarmDatabase, $AlarmSetsTable> {
  $$AlarmSetsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get intervalBetweenAlarms => $state.composableBuilder(
      column: $state.table.intervalBetweenAlarms,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get pauseDuration => $state.composableBuilder(
      column: $state.table.pauseDuration,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get daysOfWeek => $state.composableBuilder(
      column: $state.table.daysOfWeek,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$AlarmSetsTableTableManager extends RootTableManager<
    _$AlarmDatabase,
    $AlarmSetsTable,
    AlarmSet,
    $$AlarmSetsTableFilterComposer,
    $$AlarmSetsTableOrderingComposer,
    $$AlarmSetsTableCreateCompanionBuilder,
    $$AlarmSetsTableUpdateCompanionBuilder,
    (AlarmSet, $$AlarmSetsTableReferences),
    AlarmSet,
    PrefetchHooks Function({bool alarmSetAlarmsRefs})> {
  $$AlarmSetsTableTableManager(_$AlarmDatabase db, $AlarmSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AlarmSetsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AlarmSetsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<int> intervalBetweenAlarms = const Value.absent(),
            Value<int?> pauseDuration = const Value.absent(),
            Value<String> daysOfWeek = const Value.absent(),
          }) =>
              AlarmSetsCompanion(
            id: id,
            name: name,
            startTime: startTime,
            endTime: endTime,
            intervalBetweenAlarms: intervalBetweenAlarms,
            pauseDuration: pauseDuration,
            daysOfWeek: daysOfWeek,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required DateTime startTime,
            required DateTime endTime,
            required int intervalBetweenAlarms,
            Value<int?> pauseDuration = const Value.absent(),
            required String daysOfWeek,
          }) =>
              AlarmSetsCompanion.insert(
            id: id,
            name: name,
            startTime: startTime,
            endTime: endTime,
            intervalBetweenAlarms: intervalBetweenAlarms,
            pauseDuration: pauseDuration,
            daysOfWeek: daysOfWeek,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AlarmSetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({alarmSetAlarmsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (alarmSetAlarmsRefs) db.alarmSetAlarms
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (alarmSetAlarmsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AlarmSetsTableReferences
                            ._alarmSetAlarmsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AlarmSetsTableReferences(db, table, p0)
                                .alarmSetAlarmsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.alarmSetId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AlarmSetsTableProcessedTableManager = ProcessedTableManager<
    _$AlarmDatabase,
    $AlarmSetsTable,
    AlarmSet,
    $$AlarmSetsTableFilterComposer,
    $$AlarmSetsTableOrderingComposer,
    $$AlarmSetsTableCreateCompanionBuilder,
    $$AlarmSetsTableUpdateCompanionBuilder,
    (AlarmSet, $$AlarmSetsTableReferences),
    AlarmSet,
    PrefetchHooks Function({bool alarmSetAlarmsRefs})>;
typedef $$AlarmSetAlarmsTableCreateCompanionBuilder = AlarmSetAlarmsCompanion
    Function({
  required int alarmSetId,
  required int alarmId,
  Value<int> rowid,
});
typedef $$AlarmSetAlarmsTableUpdateCompanionBuilder = AlarmSetAlarmsCompanion
    Function({
  Value<int> alarmSetId,
  Value<int> alarmId,
  Value<int> rowid,
});

final class $$AlarmSetAlarmsTableReferences extends BaseReferences<
    _$AlarmDatabase, $AlarmSetAlarmsTable, AlarmSetAlarm> {
  $$AlarmSetAlarmsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AlarmSetsTable _alarmSetIdTable(_$AlarmDatabase db) =>
      db.alarmSets.createAlias(
          $_aliasNameGenerator(db.alarmSetAlarms.alarmSetId, db.alarmSets.id));

  $$AlarmSetsTableProcessedTableManager? get alarmSetId {
    if ($_item.alarmSetId == null) return null;
    final manager = $$AlarmSetsTableTableManager($_db, $_db.alarmSets)
        .filter((f) => f.id($_item.alarmSetId!));
    final item = $_typedResult.readTableOrNull(_alarmSetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AlarmsTable _alarmIdTable(_$AlarmDatabase db) =>
      db.alarms.createAlias(
          $_aliasNameGenerator(db.alarmSetAlarms.alarmId, db.alarms.id));

  $$AlarmsTableProcessedTableManager? get alarmId {
    if ($_item.alarmId == null) return null;
    final manager = $$AlarmsTableTableManager($_db, $_db.alarms)
        .filter((f) => f.id($_item.alarmId!));
    final item = $_typedResult.readTableOrNull(_alarmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AlarmSetAlarmsTableFilterComposer
    extends FilterComposer<_$AlarmDatabase, $AlarmSetAlarmsTable> {
  $$AlarmSetAlarmsTableFilterComposer(super.$state);
  $$AlarmSetsTableFilterComposer get alarmSetId {
    final $$AlarmSetsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.alarmSetId,
        referencedTable: $state.db.alarmSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$AlarmSetsTableFilterComposer(ComposerState(
                $state.db, $state.db.alarmSets, joinBuilder, parentComposers)));
    return composer;
  }

  $$AlarmsTableFilterComposer get alarmId {
    final $$AlarmsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.alarmId,
        referencedTable: $state.db.alarms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$AlarmsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.alarms, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$AlarmSetAlarmsTableOrderingComposer
    extends OrderingComposer<_$AlarmDatabase, $AlarmSetAlarmsTable> {
  $$AlarmSetAlarmsTableOrderingComposer(super.$state);
  $$AlarmSetsTableOrderingComposer get alarmSetId {
    final $$AlarmSetsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.alarmSetId,
        referencedTable: $state.db.alarmSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$AlarmSetsTableOrderingComposer(ComposerState(
                $state.db, $state.db.alarmSets, joinBuilder, parentComposers)));
    return composer;
  }

  $$AlarmsTableOrderingComposer get alarmId {
    final $$AlarmsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.alarmId,
        referencedTable: $state.db.alarms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$AlarmsTableOrderingComposer(ComposerState(
                $state.db, $state.db.alarms, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$AlarmSetAlarmsTableTableManager extends RootTableManager<
    _$AlarmDatabase,
    $AlarmSetAlarmsTable,
    AlarmSetAlarm,
    $$AlarmSetAlarmsTableFilterComposer,
    $$AlarmSetAlarmsTableOrderingComposer,
    $$AlarmSetAlarmsTableCreateCompanionBuilder,
    $$AlarmSetAlarmsTableUpdateCompanionBuilder,
    (AlarmSetAlarm, $$AlarmSetAlarmsTableReferences),
    AlarmSetAlarm,
    PrefetchHooks Function({bool alarmSetId, bool alarmId})> {
  $$AlarmSetAlarmsTableTableManager(
      _$AlarmDatabase db, $AlarmSetAlarmsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AlarmSetAlarmsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AlarmSetAlarmsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> alarmSetId = const Value.absent(),
            Value<int> alarmId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlarmSetAlarmsCompanion(
            alarmSetId: alarmSetId,
            alarmId: alarmId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int alarmSetId,
            required int alarmId,
            Value<int> rowid = const Value.absent(),
          }) =>
              AlarmSetAlarmsCompanion.insert(
            alarmSetId: alarmSetId,
            alarmId: alarmId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AlarmSetAlarmsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({alarmSetId = false, alarmId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (alarmSetId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.alarmSetId,
                    referencedTable:
                        $$AlarmSetAlarmsTableReferences._alarmSetIdTable(db),
                    referencedColumn:
                        $$AlarmSetAlarmsTableReferences._alarmSetIdTable(db).id,
                  ) as T;
                }
                if (alarmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.alarmId,
                    referencedTable:
                        $$AlarmSetAlarmsTableReferences._alarmIdTable(db),
                    referencedColumn:
                        $$AlarmSetAlarmsTableReferences._alarmIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AlarmSetAlarmsTableProcessedTableManager = ProcessedTableManager<
    _$AlarmDatabase,
    $AlarmSetAlarmsTable,
    AlarmSetAlarm,
    $$AlarmSetAlarmsTableFilterComposer,
    $$AlarmSetAlarmsTableOrderingComposer,
    $$AlarmSetAlarmsTableCreateCompanionBuilder,
    $$AlarmSetAlarmsTableUpdateCompanionBuilder,
    (AlarmSetAlarm, $$AlarmSetAlarmsTableReferences),
    AlarmSetAlarm,
    PrefetchHooks Function({bool alarmSetId, bool alarmId})>;

class $AlarmDatabaseManager {
  final _$AlarmDatabase _db;
  $AlarmDatabaseManager(this._db);
  $$AlarmsTableTableManager get alarms =>
      $$AlarmsTableTableManager(_db, _db.alarms);
  $$AlarmSetsTableTableManager get alarmSets =>
      $$AlarmSetsTableTableManager(_db, _db.alarmSets);
  $$AlarmSetAlarmsTableTableManager get alarmSetAlarms =>
      $$AlarmSetAlarmsTableTableManager(_db, _db.alarmSetAlarms);
}

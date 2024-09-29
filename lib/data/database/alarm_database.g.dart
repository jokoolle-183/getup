// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_database.dart';

// ignore_for_file: type=lint
class $RegularAlarmsTable extends RegularAlarms
    with TableInfo<$RegularAlarmsTable, RegularAlarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegularAlarmsTable(this.attachedDatabase, [this._alias]);
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
      'snooze_duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _daysOfWeekMeta =
      const VerificationMeta('daysOfWeek');
  @override
  late final GeneratedColumnWithTypeConverter<EqualList<Weekday>?, String>
      daysOfWeek = GeneratedColumn<String>('days_of_week', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EqualList<Weekday>?>(
              $RegularAlarmsTable.$converterdaysOfWeekn);
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, audioPath, time, snoozeDuration, daysOfWeek, isEnabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'regular_alarms';
  @override
  VerificationContext validateIntegrity(Insertable<RegularAlarm> instance,
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
    }
    context.handle(_daysOfWeekMeta, const VerificationResult.success());
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RegularAlarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegularAlarm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      audioPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_path'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      snoozeDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}snooze_duration']),
      daysOfWeek: $RegularAlarmsTable.$converterdaysOfWeekn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}days_of_week'])),
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
    );
  }

  @override
  $RegularAlarmsTable createAlias(String alias) {
    return $RegularAlarmsTable(attachedDatabase, alias);
  }

  static TypeConverter<EqualList<Weekday>, String> $converterdaysOfWeek =
      EnumListConverter(EqualList(Weekday.values));
  static TypeConverter<EqualList<Weekday>?, String?> $converterdaysOfWeekn =
      NullAwareTypeConverter.wrap($converterdaysOfWeek);
}

class RegularAlarm extends DataClass implements Insertable<RegularAlarm> {
  final int id;
  final String? name;
  final String audioPath;
  final DateTime time;
  final int? snoozeDuration;
  final EqualList<Weekday>? daysOfWeek;
  final bool isEnabled;
  const RegularAlarm(
      {required this.id,
      this.name,
      required this.audioPath,
      required this.time,
      this.snoozeDuration,
      this.daysOfWeek,
      required this.isEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['audio_path'] = Variable<String>(audioPath);
    map['time'] = Variable<DateTime>(time);
    if (!nullToAbsent || snoozeDuration != null) {
      map['snooze_duration'] = Variable<int>(snoozeDuration);
    }
    if (!nullToAbsent || daysOfWeek != null) {
      map['days_of_week'] = Variable<String>(
          $RegularAlarmsTable.$converterdaysOfWeekn.toSql(daysOfWeek));
    }
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  RegularAlarmsCompanion toCompanion(bool nullToAbsent) {
    return RegularAlarmsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      audioPath: Value(audioPath),
      time: Value(time),
      snoozeDuration: snoozeDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozeDuration),
      daysOfWeek: daysOfWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(daysOfWeek),
      isEnabled: Value(isEnabled),
    );
  }

  factory RegularAlarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegularAlarm(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      audioPath: serializer.fromJson<String>(json['audioPath']),
      time: serializer.fromJson<DateTime>(json['time']),
      snoozeDuration: serializer.fromJson<int?>(json['snoozeDuration']),
      daysOfWeek: serializer.fromJson<EqualList<Weekday>?>(json['daysOfWeek']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
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
      'snoozeDuration': serializer.toJson<int?>(snoozeDuration),
      'daysOfWeek': serializer.toJson<EqualList<Weekday>?>(daysOfWeek),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  RegularAlarm copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          String? audioPath,
          DateTime? time,
          Value<int?> snoozeDuration = const Value.absent(),
          Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
          bool? isEnabled}) =>
      RegularAlarm(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        audioPath: audioPath ?? this.audioPath,
        time: time ?? this.time,
        snoozeDuration:
            snoozeDuration.present ? snoozeDuration.value : this.snoozeDuration,
        daysOfWeek: daysOfWeek.present ? daysOfWeek.value : this.daysOfWeek,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  RegularAlarm copyWithCompanion(RegularAlarmsCompanion data) {
    return RegularAlarm(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      time: data.time.present ? data.time.value : this.time,
      snoozeDuration: data.snoozeDuration.present
          ? data.snoozeDuration.value
          : this.snoozeDuration,
      daysOfWeek:
          data.daysOfWeek.present ? data.daysOfWeek.value : this.daysOfWeek,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegularAlarm(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('audioPath: $audioPath, ')
          ..write('time: $time, ')
          ..write('snoozeDuration: $snoozeDuration, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, audioPath, time, snoozeDuration, daysOfWeek, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegularAlarm &&
          other.id == this.id &&
          other.name == this.name &&
          other.audioPath == this.audioPath &&
          other.time == this.time &&
          other.snoozeDuration == this.snoozeDuration &&
          other.daysOfWeek == this.daysOfWeek &&
          other.isEnabled == this.isEnabled);
}

class RegularAlarmsCompanion extends UpdateCompanion<RegularAlarm> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String> audioPath;
  final Value<DateTime> time;
  final Value<int?> snoozeDuration;
  final Value<EqualList<Weekday>?> daysOfWeek;
  final Value<bool> isEnabled;
  const RegularAlarmsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.time = const Value.absent(),
    this.snoozeDuration = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  RegularAlarmsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required String audioPath,
    required DateTime time,
    this.snoozeDuration = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.isEnabled = const Value.absent(),
  })  : audioPath = Value(audioPath),
        time = Value(time);
  static Insertable<RegularAlarm> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? audioPath,
    Expression<DateTime>? time,
    Expression<int>? snoozeDuration,
    Expression<String>? daysOfWeek,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (audioPath != null) 'audio_path': audioPath,
      if (time != null) 'time': time,
      if (snoozeDuration != null) 'snooze_duration': snoozeDuration,
      if (daysOfWeek != null) 'days_of_week': daysOfWeek,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  RegularAlarmsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String>? audioPath,
      Value<DateTime>? time,
      Value<int?>? snoozeDuration,
      Value<EqualList<Weekday>?>? daysOfWeek,
      Value<bool>? isEnabled}) {
    return RegularAlarmsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      audioPath: audioPath ?? this.audioPath,
      time: time ?? this.time,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      isEnabled: isEnabled ?? this.isEnabled,
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
      map['days_of_week'] = Variable<String>(
          $RegularAlarmsTable.$converterdaysOfWeekn.toSql(daysOfWeek.value));
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegularAlarmsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('audioPath: $audioPath, ')
          ..write('time: $time, ')
          ..write('snoozeDuration: $snoozeDuration, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('isEnabled: $isEnabled')
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
  static const VerificationMeta _audioPathMeta =
      const VerificationMeta('audioPath');
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
      'audio_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  late final GeneratedColumnWithTypeConverter<EqualList<Weekday>?, String>
      daysOfWeek = GeneratedColumn<String>('days_of_week', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EqualList<Weekday>?>(
              $AlarmSetsTable.$converterdaysOfWeekn);
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        audioPath,
        startTime,
        endTime,
        intervalBetweenAlarms,
        pauseDuration,
        daysOfWeek,
        isEnabled
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
    if (data.containsKey('audio_path')) {
      context.handle(_audioPathMeta,
          audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta));
    } else if (isInserting) {
      context.missing(_audioPathMeta);
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
    context.handle(_daysOfWeekMeta, const VerificationResult.success());
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
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
      audioPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_path'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time'])!,
      intervalBetweenAlarms: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}interval_between_alarms'])!,
      pauseDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pause_duration']),
      daysOfWeek: $AlarmSetsTable.$converterdaysOfWeekn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}days_of_week'])),
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
    );
  }

  @override
  $AlarmSetsTable createAlias(String alias) {
    return $AlarmSetsTable(attachedDatabase, alias);
  }

  static TypeConverter<EqualList<Weekday>, String> $converterdaysOfWeek =
      EnumListConverter(EqualList(Weekday.values));
  static TypeConverter<EqualList<Weekday>?, String?> $converterdaysOfWeekn =
      NullAwareTypeConverter.wrap($converterdaysOfWeek);
}

class AlarmSet extends DataClass implements Insertable<AlarmSet> {
  final int id;
  final String? name;
  final String audioPath;
  final DateTime startTime;
  final DateTime endTime;
  final int intervalBetweenAlarms;
  final int? pauseDuration;
  final EqualList<Weekday>? daysOfWeek;
  final bool isEnabled;
  const AlarmSet(
      {required this.id,
      this.name,
      required this.audioPath,
      required this.startTime,
      required this.endTime,
      required this.intervalBetweenAlarms,
      this.pauseDuration,
      this.daysOfWeek,
      required this.isEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['audio_path'] = Variable<String>(audioPath);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['interval_between_alarms'] = Variable<int>(intervalBetweenAlarms);
    if (!nullToAbsent || pauseDuration != null) {
      map['pause_duration'] = Variable<int>(pauseDuration);
    }
    if (!nullToAbsent || daysOfWeek != null) {
      map['days_of_week'] = Variable<String>(
          $AlarmSetsTable.$converterdaysOfWeekn.toSql(daysOfWeek));
    }
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  AlarmSetsCompanion toCompanion(bool nullToAbsent) {
    return AlarmSetsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      audioPath: Value(audioPath),
      startTime: Value(startTime),
      endTime: Value(endTime),
      intervalBetweenAlarms: Value(intervalBetweenAlarms),
      pauseDuration: pauseDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(pauseDuration),
      daysOfWeek: daysOfWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(daysOfWeek),
      isEnabled: Value(isEnabled),
    );
  }

  factory AlarmSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmSet(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      audioPath: serializer.fromJson<String>(json['audioPath']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      intervalBetweenAlarms:
          serializer.fromJson<int>(json['intervalBetweenAlarms']),
      pauseDuration: serializer.fromJson<int?>(json['pauseDuration']),
      daysOfWeek: serializer.fromJson<EqualList<Weekday>?>(json['daysOfWeek']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'audioPath': serializer.toJson<String>(audioPath),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'intervalBetweenAlarms': serializer.toJson<int>(intervalBetweenAlarms),
      'pauseDuration': serializer.toJson<int?>(pauseDuration),
      'daysOfWeek': serializer.toJson<EqualList<Weekday>?>(daysOfWeek),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  AlarmSet copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          String? audioPath,
          DateTime? startTime,
          DateTime? endTime,
          int? intervalBetweenAlarms,
          Value<int?> pauseDuration = const Value.absent(),
          Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
          bool? isEnabled}) =>
      AlarmSet(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        audioPath: audioPath ?? this.audioPath,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        intervalBetweenAlarms:
            intervalBetweenAlarms ?? this.intervalBetweenAlarms,
        pauseDuration:
            pauseDuration.present ? pauseDuration.value : this.pauseDuration,
        daysOfWeek: daysOfWeek.present ? daysOfWeek.value : this.daysOfWeek,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  AlarmSet copyWithCompanion(AlarmSetsCompanion data) {
    return AlarmSet(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
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
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmSet(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('audioPath: $audioPath, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('intervalBetweenAlarms: $intervalBetweenAlarms, ')
          ..write('pauseDuration: $pauseDuration, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, audioPath, startTime, endTime,
      intervalBetweenAlarms, pauseDuration, daysOfWeek, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmSet &&
          other.id == this.id &&
          other.name == this.name &&
          other.audioPath == this.audioPath &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.intervalBetweenAlarms == this.intervalBetweenAlarms &&
          other.pauseDuration == this.pauseDuration &&
          other.daysOfWeek == this.daysOfWeek &&
          other.isEnabled == this.isEnabled);
}

class AlarmSetsCompanion extends UpdateCompanion<AlarmSet> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String> audioPath;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<int> intervalBetweenAlarms;
  final Value<int?> pauseDuration;
  final Value<EqualList<Weekday>?> daysOfWeek;
  final Value<bool> isEnabled;
  const AlarmSetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.intervalBetweenAlarms = const Value.absent(),
    this.pauseDuration = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  AlarmSetsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required String audioPath,
    required DateTime startTime,
    required DateTime endTime,
    required int intervalBetweenAlarms,
    this.pauseDuration = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.isEnabled = const Value.absent(),
  })  : audioPath = Value(audioPath),
        startTime = Value(startTime),
        endTime = Value(endTime),
        intervalBetweenAlarms = Value(intervalBetweenAlarms);
  static Insertable<AlarmSet> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? audioPath,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? intervalBetweenAlarms,
    Expression<int>? pauseDuration,
    Expression<String>? daysOfWeek,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (audioPath != null) 'audio_path': audioPath,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (intervalBetweenAlarms != null)
        'interval_between_alarms': intervalBetweenAlarms,
      if (pauseDuration != null) 'pause_duration': pauseDuration,
      if (daysOfWeek != null) 'days_of_week': daysOfWeek,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  AlarmSetsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String>? audioPath,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<int>? intervalBetweenAlarms,
      Value<int?>? pauseDuration,
      Value<EqualList<Weekday>?>? daysOfWeek,
      Value<bool>? isEnabled}) {
    return AlarmSetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      audioPath: audioPath ?? this.audioPath,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      intervalBetweenAlarms:
          intervalBetweenAlarms ?? this.intervalBetweenAlarms,
      pauseDuration: pauseDuration ?? this.pauseDuration,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      isEnabled: isEnabled ?? this.isEnabled,
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
      map['days_of_week'] = Variable<String>(
          $AlarmSetsTable.$converterdaysOfWeekn.toSql(daysOfWeek.value));
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmSetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('audioPath: $audioPath, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('intervalBetweenAlarms: $intervalBetweenAlarms, ')
          ..write('pauseDuration: $pauseDuration, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }
}

class $RecurringAlarmsTable extends RecurringAlarms
    with TableInfo<$RecurringAlarmsTable, RecurringAlarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringAlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _alarmSetIdMeta =
      const VerificationMeta('alarmSetId');
  @override
  late final GeneratedColumn<int> alarmSetId = GeneratedColumn<int>(
      'alarm_set_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES alarm_sets (id) ON DELETE CASCADE'));
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, alarmSetId, time, isEnabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_alarms';
  @override
  VerificationContext validateIntegrity(Insertable<RecurringAlarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('alarm_set_id')) {
      context.handle(
          _alarmSetIdMeta,
          alarmSetId.isAcceptableOrUnknown(
              data['alarm_set_id']!, _alarmSetIdMeta));
    } else if (isInserting) {
      context.missing(_alarmSetIdMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringAlarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringAlarm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      alarmSetId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}alarm_set_id'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
    );
  }

  @override
  $RecurringAlarmsTable createAlias(String alias) {
    return $RecurringAlarmsTable(attachedDatabase, alias);
  }
}

class RecurringAlarm extends DataClass implements Insertable<RecurringAlarm> {
  final int id;
  final int alarmSetId;
  final DateTime time;
  final bool isEnabled;
  const RecurringAlarm(
      {required this.id,
      required this.alarmSetId,
      required this.time,
      required this.isEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['alarm_set_id'] = Variable<int>(alarmSetId);
    map['time'] = Variable<DateTime>(time);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  RecurringAlarmsCompanion toCompanion(bool nullToAbsent) {
    return RecurringAlarmsCompanion(
      id: Value(id),
      alarmSetId: Value(alarmSetId),
      time: Value(time),
      isEnabled: Value(isEnabled),
    );
  }

  factory RecurringAlarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringAlarm(
      id: serializer.fromJson<int>(json['id']),
      alarmSetId: serializer.fromJson<int>(json['alarmSetId']),
      time: serializer.fromJson<DateTime>(json['time']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'alarmSetId': serializer.toJson<int>(alarmSetId),
      'time': serializer.toJson<DateTime>(time),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  RecurringAlarm copyWith(
          {int? id, int? alarmSetId, DateTime? time, bool? isEnabled}) =>
      RecurringAlarm(
        id: id ?? this.id,
        alarmSetId: alarmSetId ?? this.alarmSetId,
        time: time ?? this.time,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  RecurringAlarm copyWithCompanion(RecurringAlarmsCompanion data) {
    return RecurringAlarm(
      id: data.id.present ? data.id.value : this.id,
      alarmSetId:
          data.alarmSetId.present ? data.alarmSetId.value : this.alarmSetId,
      time: data.time.present ? data.time.value : this.time,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringAlarm(')
          ..write('id: $id, ')
          ..write('alarmSetId: $alarmSetId, ')
          ..write('time: $time, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, alarmSetId, time, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringAlarm &&
          other.id == this.id &&
          other.alarmSetId == this.alarmSetId &&
          other.time == this.time &&
          other.isEnabled == this.isEnabled);
}

class RecurringAlarmsCompanion extends UpdateCompanion<RecurringAlarm> {
  final Value<int> id;
  final Value<int> alarmSetId;
  final Value<DateTime> time;
  final Value<bool> isEnabled;
  const RecurringAlarmsCompanion({
    this.id = const Value.absent(),
    this.alarmSetId = const Value.absent(),
    this.time = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  RecurringAlarmsCompanion.insert({
    this.id = const Value.absent(),
    required int alarmSetId,
    required DateTime time,
    this.isEnabled = const Value.absent(),
  })  : alarmSetId = Value(alarmSetId),
        time = Value(time);
  static Insertable<RecurringAlarm> custom({
    Expression<int>? id,
    Expression<int>? alarmSetId,
    Expression<DateTime>? time,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (alarmSetId != null) 'alarm_set_id': alarmSetId,
      if (time != null) 'time': time,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  RecurringAlarmsCompanion copyWith(
      {Value<int>? id,
      Value<int>? alarmSetId,
      Value<DateTime>? time,
      Value<bool>? isEnabled}) {
    return RecurringAlarmsCompanion(
      id: id ?? this.id,
      alarmSetId: alarmSetId ?? this.alarmSetId,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (alarmSetId.present) {
      map['alarm_set_id'] = Variable<int>(alarmSetId.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringAlarmsCompanion(')
          ..write('id: $id, ')
          ..write('alarmSetId: $alarmSetId, ')
          ..write('time: $time, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AlarmDatabase extends GeneratedDatabase {
  _$AlarmDatabase(QueryExecutor e) : super(e);
  $AlarmDatabaseManager get managers => $AlarmDatabaseManager(this);
  late final $RegularAlarmsTable regularAlarms = $RegularAlarmsTable(this);
  late final $AlarmSetsTable alarmSets = $AlarmSetsTable(this);
  late final $RecurringAlarmsTable recurringAlarms =
      $RecurringAlarmsTable(this);
  late final RegularAlarmsDao regularAlarmsDao =
      RegularAlarmsDao(this as AlarmDatabase);
  late final AlarmSetDao alarmSetDao = AlarmSetDao(this as AlarmDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [regularAlarms, alarmSets, recurringAlarms];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('alarm_sets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('recurring_alarms', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$RegularAlarmsTableCreateCompanionBuilder = RegularAlarmsCompanion
    Function({
  Value<int> id,
  Value<String?> name,
  required String audioPath,
  required DateTime time,
  Value<int?> snoozeDuration,
  Value<EqualList<Weekday>?> daysOfWeek,
  Value<bool> isEnabled,
});
typedef $$RegularAlarmsTableUpdateCompanionBuilder = RegularAlarmsCompanion
    Function({
  Value<int> id,
  Value<String?> name,
  Value<String> audioPath,
  Value<DateTime> time,
  Value<int?> snoozeDuration,
  Value<EqualList<Weekday>?> daysOfWeek,
  Value<bool> isEnabled,
});

class $$RegularAlarmsTableFilterComposer
    extends FilterComposer<_$AlarmDatabase, $RegularAlarmsTable> {
  $$RegularAlarmsTableFilterComposer(super.$state);
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

  ColumnWithTypeConverterFilters<EqualList<Weekday>?, EqualList<Weekday>,
          String>
      get daysOfWeek => $state.composableBuilder(
          column: $state.table.daysOfWeek,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<bool> get isEnabled => $state.composableBuilder(
      column: $state.table.isEnabled,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$RegularAlarmsTableOrderingComposer
    extends OrderingComposer<_$AlarmDatabase, $RegularAlarmsTable> {
  $$RegularAlarmsTableOrderingComposer(super.$state);
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

  ColumnOrderings<bool> get isEnabled => $state.composableBuilder(
      column: $state.table.isEnabled,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$RegularAlarmsTableTableManager extends RootTableManager<
    _$AlarmDatabase,
    $RegularAlarmsTable,
    RegularAlarm,
    $$RegularAlarmsTableFilterComposer,
    $$RegularAlarmsTableOrderingComposer,
    $$RegularAlarmsTableCreateCompanionBuilder,
    $$RegularAlarmsTableUpdateCompanionBuilder,
    (
      RegularAlarm,
      BaseReferences<_$AlarmDatabase, $RegularAlarmsTable, RegularAlarm>
    ),
    RegularAlarm,
    PrefetchHooks Function()> {
  $$RegularAlarmsTableTableManager(
      _$AlarmDatabase db, $RegularAlarmsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RegularAlarmsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RegularAlarmsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String> audioPath = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<int?> snoozeDuration = const Value.absent(),
            Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              RegularAlarmsCompanion(
            id: id,
            name: name,
            audioPath: audioPath,
            time: time,
            snoozeDuration: snoozeDuration,
            daysOfWeek: daysOfWeek,
            isEnabled: isEnabled,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required String audioPath,
            required DateTime time,
            Value<int?> snoozeDuration = const Value.absent(),
            Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              RegularAlarmsCompanion.insert(
            id: id,
            name: name,
            audioPath: audioPath,
            time: time,
            snoozeDuration: snoozeDuration,
            daysOfWeek: daysOfWeek,
            isEnabled: isEnabled,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RegularAlarmsTableProcessedTableManager = ProcessedTableManager<
    _$AlarmDatabase,
    $RegularAlarmsTable,
    RegularAlarm,
    $$RegularAlarmsTableFilterComposer,
    $$RegularAlarmsTableOrderingComposer,
    $$RegularAlarmsTableCreateCompanionBuilder,
    $$RegularAlarmsTableUpdateCompanionBuilder,
    (
      RegularAlarm,
      BaseReferences<_$AlarmDatabase, $RegularAlarmsTable, RegularAlarm>
    ),
    RegularAlarm,
    PrefetchHooks Function()>;
typedef $$AlarmSetsTableCreateCompanionBuilder = AlarmSetsCompanion Function({
  Value<int> id,
  Value<String?> name,
  required String audioPath,
  required DateTime startTime,
  required DateTime endTime,
  required int intervalBetweenAlarms,
  Value<int?> pauseDuration,
  Value<EqualList<Weekday>?> daysOfWeek,
  Value<bool> isEnabled,
});
typedef $$AlarmSetsTableUpdateCompanionBuilder = AlarmSetsCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String> audioPath,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<int> intervalBetweenAlarms,
  Value<int?> pauseDuration,
  Value<EqualList<Weekday>?> daysOfWeek,
  Value<bool> isEnabled,
});

final class $$AlarmSetsTableReferences
    extends BaseReferences<_$AlarmDatabase, $AlarmSetsTable, AlarmSet> {
  $$AlarmSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecurringAlarmsTable, List<RecurringAlarm>>
      _recurringAlarmsRefsTable(_$AlarmDatabase db) =>
          MultiTypedResultKey.fromTable(db.recurringAlarms,
              aliasName: $_aliasNameGenerator(
                  db.alarmSets.id, db.recurringAlarms.alarmSetId));

  $$RecurringAlarmsTableProcessedTableManager get recurringAlarmsRefs {
    final manager =
        $$RecurringAlarmsTableTableManager($_db, $_db.recurringAlarms)
            .filter((f) => f.alarmSetId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_recurringAlarmsRefsTable($_db));
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

  ColumnFilters<String> get audioPath => $state.composableBuilder(
      column: $state.table.audioPath,
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

  ColumnWithTypeConverterFilters<EqualList<Weekday>?, EqualList<Weekday>,
          String>
      get daysOfWeek => $state.composableBuilder(
          column: $state.table.daysOfWeek,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<bool> get isEnabled => $state.composableBuilder(
      column: $state.table.isEnabled,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter recurringAlarmsRefs(
      ComposableFilter Function($$RecurringAlarmsTableFilterComposer f) f) {
    final $$RecurringAlarmsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.recurringAlarms,
            getReferencedColumn: (t) => t.alarmSetId,
            builder: (joinBuilder, parentComposers) =>
                $$RecurringAlarmsTableFilterComposer(ComposerState($state.db,
                    $state.db.recurringAlarms, joinBuilder, parentComposers)));
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

  ColumnOrderings<String> get audioPath => $state.composableBuilder(
      column: $state.table.audioPath,
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

  ColumnOrderings<bool> get isEnabled => $state.composableBuilder(
      column: $state.table.isEnabled,
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
    PrefetchHooks Function({bool recurringAlarmsRefs})> {
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
            Value<String> audioPath = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<int> intervalBetweenAlarms = const Value.absent(),
            Value<int?> pauseDuration = const Value.absent(),
            Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              AlarmSetsCompanion(
            id: id,
            name: name,
            audioPath: audioPath,
            startTime: startTime,
            endTime: endTime,
            intervalBetweenAlarms: intervalBetweenAlarms,
            pauseDuration: pauseDuration,
            daysOfWeek: daysOfWeek,
            isEnabled: isEnabled,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required String audioPath,
            required DateTime startTime,
            required DateTime endTime,
            required int intervalBetweenAlarms,
            Value<int?> pauseDuration = const Value.absent(),
            Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              AlarmSetsCompanion.insert(
            id: id,
            name: name,
            audioPath: audioPath,
            startTime: startTime,
            endTime: endTime,
            intervalBetweenAlarms: intervalBetweenAlarms,
            pauseDuration: pauseDuration,
            daysOfWeek: daysOfWeek,
            isEnabled: isEnabled,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AlarmSetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({recurringAlarmsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (recurringAlarmsRefs) db.recurringAlarms
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (recurringAlarmsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AlarmSetsTableReferences
                            ._recurringAlarmsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AlarmSetsTableReferences(db, table, p0)
                                .recurringAlarmsRefs,
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
    PrefetchHooks Function({bool recurringAlarmsRefs})>;
typedef $$RecurringAlarmsTableCreateCompanionBuilder = RecurringAlarmsCompanion
    Function({
  Value<int> id,
  required int alarmSetId,
  required DateTime time,
  Value<bool> isEnabled,
});
typedef $$RecurringAlarmsTableUpdateCompanionBuilder = RecurringAlarmsCompanion
    Function({
  Value<int> id,
  Value<int> alarmSetId,
  Value<DateTime> time,
  Value<bool> isEnabled,
});

final class $$RecurringAlarmsTableReferences extends BaseReferences<
    _$AlarmDatabase, $RecurringAlarmsTable, RecurringAlarm> {
  $$RecurringAlarmsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AlarmSetsTable _alarmSetIdTable(_$AlarmDatabase db) =>
      db.alarmSets.createAlias(
          $_aliasNameGenerator(db.recurringAlarms.alarmSetId, db.alarmSets.id));

  $$AlarmSetsTableProcessedTableManager? get alarmSetId {
    if ($_item.alarmSetId == null) return null;
    final manager = $$AlarmSetsTableTableManager($_db, $_db.alarmSets)
        .filter((f) => f.id($_item.alarmSetId!));
    final item = $_typedResult.readTableOrNull(_alarmSetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RecurringAlarmsTableFilterComposer
    extends FilterComposer<_$AlarmDatabase, $RecurringAlarmsTable> {
  $$RecurringAlarmsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isEnabled => $state.composableBuilder(
      column: $state.table.isEnabled,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

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
}

class $$RecurringAlarmsTableOrderingComposer
    extends OrderingComposer<_$AlarmDatabase, $RecurringAlarmsTable> {
  $$RecurringAlarmsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isEnabled => $state.composableBuilder(
      column: $state.table.isEnabled,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

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
}

class $$RecurringAlarmsTableTableManager extends RootTableManager<
    _$AlarmDatabase,
    $RecurringAlarmsTable,
    RecurringAlarm,
    $$RecurringAlarmsTableFilterComposer,
    $$RecurringAlarmsTableOrderingComposer,
    $$RecurringAlarmsTableCreateCompanionBuilder,
    $$RecurringAlarmsTableUpdateCompanionBuilder,
    (RecurringAlarm, $$RecurringAlarmsTableReferences),
    RecurringAlarm,
    PrefetchHooks Function({bool alarmSetId})> {
  $$RecurringAlarmsTableTableManager(
      _$AlarmDatabase db, $RecurringAlarmsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RecurringAlarmsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RecurringAlarmsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> alarmSetId = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              RecurringAlarmsCompanion(
            id: id,
            alarmSetId: alarmSetId,
            time: time,
            isEnabled: isEnabled,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int alarmSetId,
            required DateTime time,
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              RecurringAlarmsCompanion.insert(
            id: id,
            alarmSetId: alarmSetId,
            time: time,
            isEnabled: isEnabled,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RecurringAlarmsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({alarmSetId = false}) {
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
                        $$RecurringAlarmsTableReferences._alarmSetIdTable(db),
                    referencedColumn: $$RecurringAlarmsTableReferences
                        ._alarmSetIdTable(db)
                        .id,
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

typedef $$RecurringAlarmsTableProcessedTableManager = ProcessedTableManager<
    _$AlarmDatabase,
    $RecurringAlarmsTable,
    RecurringAlarm,
    $$RecurringAlarmsTableFilterComposer,
    $$RecurringAlarmsTableOrderingComposer,
    $$RecurringAlarmsTableCreateCompanionBuilder,
    $$RecurringAlarmsTableUpdateCompanionBuilder,
    (RecurringAlarm, $$RecurringAlarmsTableReferences),
    RecurringAlarm,
    PrefetchHooks Function({bool alarmSetId})>;

class $AlarmDatabaseManager {
  final _$AlarmDatabase _db;
  $AlarmDatabaseManager(this._db);
  $$RegularAlarmsTableTableManager get regularAlarms =>
      $$RegularAlarmsTableTableManager(_db, _db.regularAlarms);
  $$AlarmSetsTableTableManager get alarmSets =>
      $$AlarmSetsTableTableManager(_db, _db.alarmSets);
  $$RecurringAlarmsTableTableManager get recurringAlarms =>
      $$RecurringAlarmsTableTableManager(_db, _db.recurringAlarms);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_database.dart';

// ignore_for_file: type=lint
class $DbAlarmsTable extends DbAlarms with TableInfo<$DbAlarmsTable, DbAlarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbAlarmsTable(this.attachedDatabase, [this._alias]);
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
              $DbAlarmsTable.$converterdaysOfWeekn);
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
      [id, name, audioPath, snoozeDuration, daysOfWeek, isEnabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_alarms';
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
  DbAlarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbAlarm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      audioPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_path'])!,
      snoozeDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}snooze_duration']),
      daysOfWeek: $DbAlarmsTable.$converterdaysOfWeekn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}days_of_week'])),
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
    );
  }

  @override
  $DbAlarmsTable createAlias(String alias) {
    return $DbAlarmsTable(attachedDatabase, alias);
  }

  static TypeConverter<EqualList<Weekday>, String> $converterdaysOfWeek =
      EnumListConverter(EqualList(Weekday.values));
  static TypeConverter<EqualList<Weekday>?, String?> $converterdaysOfWeekn =
      NullAwareTypeConverter.wrap($converterdaysOfWeek);
}

class DbAlarm extends DataClass implements Insertable<DbAlarm> {
  final int id;
  final String? name;
  final String audioPath;
  final int? snoozeDuration;
  final EqualList<Weekday>? daysOfWeek;
  final bool isEnabled;
  const DbAlarm(
      {required this.id,
      this.name,
      required this.audioPath,
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
    if (!nullToAbsent || snoozeDuration != null) {
      map['snooze_duration'] = Variable<int>(snoozeDuration);
    }
    if (!nullToAbsent || daysOfWeek != null) {
      map['days_of_week'] = Variable<String>(
          $DbAlarmsTable.$converterdaysOfWeekn.toSql(daysOfWeek));
    }
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  DbAlarmsCompanion toCompanion(bool nullToAbsent) {
    return DbAlarmsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      audioPath: Value(audioPath),
      snoozeDuration: snoozeDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozeDuration),
      daysOfWeek: daysOfWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(daysOfWeek),
      isEnabled: Value(isEnabled),
    );
  }

  factory DbAlarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbAlarm(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      audioPath: serializer.fromJson<String>(json['audioPath']),
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
      'snoozeDuration': serializer.toJson<int?>(snoozeDuration),
      'daysOfWeek': serializer.toJson<EqualList<Weekday>?>(daysOfWeek),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  DbAlarm copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          String? audioPath,
          Value<int?> snoozeDuration = const Value.absent(),
          Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
          bool? isEnabled}) =>
      DbAlarm(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        audioPath: audioPath ?? this.audioPath,
        snoozeDuration:
            snoozeDuration.present ? snoozeDuration.value : this.snoozeDuration,
        daysOfWeek: daysOfWeek.present ? daysOfWeek.value : this.daysOfWeek,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  DbAlarm copyWithCompanion(DbAlarmsCompanion data) {
    return DbAlarm(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
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
    return (StringBuffer('DbAlarm(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('audioPath: $audioPath, ')
          ..write('snoozeDuration: $snoozeDuration, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, audioPath, snoozeDuration, daysOfWeek, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbAlarm &&
          other.id == this.id &&
          other.name == this.name &&
          other.audioPath == this.audioPath &&
          other.snoozeDuration == this.snoozeDuration &&
          other.daysOfWeek == this.daysOfWeek &&
          other.isEnabled == this.isEnabled);
}

class DbAlarmsCompanion extends UpdateCompanion<DbAlarm> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String> audioPath;
  final Value<int?> snoozeDuration;
  final Value<EqualList<Weekday>?> daysOfWeek;
  final Value<bool> isEnabled;
  const DbAlarmsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.snoozeDuration = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  DbAlarmsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required String audioPath,
    this.snoozeDuration = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.isEnabled = const Value.absent(),
  }) : audioPath = Value(audioPath);
  static Insertable<DbAlarm> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? audioPath,
    Expression<int>? snoozeDuration,
    Expression<String>? daysOfWeek,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (audioPath != null) 'audio_path': audioPath,
      if (snoozeDuration != null) 'snooze_duration': snoozeDuration,
      if (daysOfWeek != null) 'days_of_week': daysOfWeek,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  DbAlarmsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String>? audioPath,
      Value<int?>? snoozeDuration,
      Value<EqualList<Weekday>?>? daysOfWeek,
      Value<bool>? isEnabled}) {
    return DbAlarmsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      audioPath: audioPath ?? this.audioPath,
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
    if (snoozeDuration.present) {
      map['snooze_duration'] = Variable<int>(snoozeDuration.value);
    }
    if (daysOfWeek.present) {
      map['days_of_week'] = Variable<String>(
          $DbAlarmsTable.$converterdaysOfWeekn.toSql(daysOfWeek.value));
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbAlarmsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('audioPath: $audioPath, ')
          ..write('snoozeDuration: $snoozeDuration, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }
}

class $AlarmInstanceSetsTable extends AlarmInstanceSets
    with TableInfo<$AlarmInstanceSetsTable, AlarmInstanceSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmInstanceSetsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _daysOfWeekMeta =
      const VerificationMeta('daysOfWeek');
  @override
  late final GeneratedColumnWithTypeConverter<EqualList<Weekday>?, String>
      daysOfWeek = GeneratedColumn<String>('days_of_week', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EqualList<Weekday>?>(
              $AlarmInstanceSetsTable.$converterdaysOfWeekn);
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
        daysOfWeek,
        intervalBetweenAlarms,
        pauseDuration,
        isEnabled
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarm_instance_sets';
  @override
  VerificationContext validateIntegrity(Insertable<AlarmInstanceSet> instance,
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
    context.handle(_daysOfWeekMeta, const VerificationResult.success());
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
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlarmInstanceSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmInstanceSet(
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
      daysOfWeek: $AlarmInstanceSetsTable.$converterdaysOfWeekn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}days_of_week'])),
      intervalBetweenAlarms: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}interval_between_alarms'])!,
      pauseDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pause_duration']),
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
    );
  }

  @override
  $AlarmInstanceSetsTable createAlias(String alias) {
    return $AlarmInstanceSetsTable(attachedDatabase, alias);
  }

  static TypeConverter<EqualList<Weekday>, String> $converterdaysOfWeek =
      EnumListConverter(EqualList(Weekday.values));
  static TypeConverter<EqualList<Weekday>?, String?> $converterdaysOfWeekn =
      NullAwareTypeConverter.wrap($converterdaysOfWeek);
}

class AlarmInstanceSet extends DataClass
    implements Insertable<AlarmInstanceSet> {
  final int id;
  final String? name;
  final String audioPath;
  final DateTime startTime;
  final DateTime endTime;
  final EqualList<Weekday>? daysOfWeek;
  final int intervalBetweenAlarms;
  final int? pauseDuration;
  final bool isEnabled;
  const AlarmInstanceSet(
      {required this.id,
      this.name,
      required this.audioPath,
      required this.startTime,
      required this.endTime,
      this.daysOfWeek,
      required this.intervalBetweenAlarms,
      this.pauseDuration,
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
    if (!nullToAbsent || daysOfWeek != null) {
      map['days_of_week'] = Variable<String>(
          $AlarmInstanceSetsTable.$converterdaysOfWeekn.toSql(daysOfWeek));
    }
    map['interval_between_alarms'] = Variable<int>(intervalBetweenAlarms);
    if (!nullToAbsent || pauseDuration != null) {
      map['pause_duration'] = Variable<int>(pauseDuration);
    }
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  AlarmInstanceSetsCompanion toCompanion(bool nullToAbsent) {
    return AlarmInstanceSetsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      audioPath: Value(audioPath),
      startTime: Value(startTime),
      endTime: Value(endTime),
      daysOfWeek: daysOfWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(daysOfWeek),
      intervalBetweenAlarms: Value(intervalBetweenAlarms),
      pauseDuration: pauseDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(pauseDuration),
      isEnabled: Value(isEnabled),
    );
  }

  factory AlarmInstanceSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmInstanceSet(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      audioPath: serializer.fromJson<String>(json['audioPath']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      daysOfWeek: serializer.fromJson<EqualList<Weekday>?>(json['daysOfWeek']),
      intervalBetweenAlarms:
          serializer.fromJson<int>(json['intervalBetweenAlarms']),
      pauseDuration: serializer.fromJson<int?>(json['pauseDuration']),
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
      'daysOfWeek': serializer.toJson<EqualList<Weekday>?>(daysOfWeek),
      'intervalBetweenAlarms': serializer.toJson<int>(intervalBetweenAlarms),
      'pauseDuration': serializer.toJson<int?>(pauseDuration),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  AlarmInstanceSet copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          String? audioPath,
          DateTime? startTime,
          DateTime? endTime,
          Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
          int? intervalBetweenAlarms,
          Value<int?> pauseDuration = const Value.absent(),
          bool? isEnabled}) =>
      AlarmInstanceSet(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        audioPath: audioPath ?? this.audioPath,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        daysOfWeek: daysOfWeek.present ? daysOfWeek.value : this.daysOfWeek,
        intervalBetweenAlarms:
            intervalBetweenAlarms ?? this.intervalBetweenAlarms,
        pauseDuration:
            pauseDuration.present ? pauseDuration.value : this.pauseDuration,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  AlarmInstanceSet copyWithCompanion(AlarmInstanceSetsCompanion data) {
    return AlarmInstanceSet(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      daysOfWeek:
          data.daysOfWeek.present ? data.daysOfWeek.value : this.daysOfWeek,
      intervalBetweenAlarms: data.intervalBetweenAlarms.present
          ? data.intervalBetweenAlarms.value
          : this.intervalBetweenAlarms,
      pauseDuration: data.pauseDuration.present
          ? data.pauseDuration.value
          : this.pauseDuration,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmInstanceSet(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('audioPath: $audioPath, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('intervalBetweenAlarms: $intervalBetweenAlarms, ')
          ..write('pauseDuration: $pauseDuration, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, audioPath, startTime, endTime,
      daysOfWeek, intervalBetweenAlarms, pauseDuration, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmInstanceSet &&
          other.id == this.id &&
          other.name == this.name &&
          other.audioPath == this.audioPath &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.daysOfWeek == this.daysOfWeek &&
          other.intervalBetweenAlarms == this.intervalBetweenAlarms &&
          other.pauseDuration == this.pauseDuration &&
          other.isEnabled == this.isEnabled);
}

class AlarmInstanceSetsCompanion extends UpdateCompanion<AlarmInstanceSet> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String> audioPath;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<EqualList<Weekday>?> daysOfWeek;
  final Value<int> intervalBetweenAlarms;
  final Value<int?> pauseDuration;
  final Value<bool> isEnabled;
  const AlarmInstanceSetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.intervalBetweenAlarms = const Value.absent(),
    this.pauseDuration = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  AlarmInstanceSetsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required String audioPath,
    required DateTime startTime,
    required DateTime endTime,
    this.daysOfWeek = const Value.absent(),
    required int intervalBetweenAlarms,
    this.pauseDuration = const Value.absent(),
    this.isEnabled = const Value.absent(),
  })  : audioPath = Value(audioPath),
        startTime = Value(startTime),
        endTime = Value(endTime),
        intervalBetweenAlarms = Value(intervalBetweenAlarms);
  static Insertable<AlarmInstanceSet> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? audioPath,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? daysOfWeek,
    Expression<int>? intervalBetweenAlarms,
    Expression<int>? pauseDuration,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (audioPath != null) 'audio_path': audioPath,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (daysOfWeek != null) 'days_of_week': daysOfWeek,
      if (intervalBetweenAlarms != null)
        'interval_between_alarms': intervalBetweenAlarms,
      if (pauseDuration != null) 'pause_duration': pauseDuration,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  AlarmInstanceSetsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String>? audioPath,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<EqualList<Weekday>?>? daysOfWeek,
      Value<int>? intervalBetweenAlarms,
      Value<int?>? pauseDuration,
      Value<bool>? isEnabled}) {
    return AlarmInstanceSetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      audioPath: audioPath ?? this.audioPath,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      intervalBetweenAlarms:
          intervalBetweenAlarms ?? this.intervalBetweenAlarms,
      pauseDuration: pauseDuration ?? this.pauseDuration,
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
    if (daysOfWeek.present) {
      map['days_of_week'] = Variable<String>($AlarmInstanceSetsTable
          .$converterdaysOfWeekn
          .toSql(daysOfWeek.value));
    }
    if (intervalBetweenAlarms.present) {
      map['interval_between_alarms'] =
          Variable<int>(intervalBetweenAlarms.value);
    }
    if (pauseDuration.present) {
      map['pause_duration'] = Variable<int>(pauseDuration.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmInstanceSetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('audioPath: $audioPath, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('intervalBetweenAlarms: $intervalBetweenAlarms, ')
          ..write('pauseDuration: $pauseDuration, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }
}

class $AlarmInstancesTable extends AlarmInstances
    with TableInfo<$AlarmInstancesTable, AlarmInstance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmInstancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _alarmIdMeta =
      const VerificationMeta('alarmId');
  @override
  late final GeneratedColumn<int> alarmId = GeneratedColumn<int>(
      'alarm_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES db_alarms (id) ON DELETE CASCADE'));
  static const VerificationMeta _alarmInstanceSetIdMeta =
      const VerificationMeta('alarmInstanceSetId');
  @override
  late final GeneratedColumn<int> alarmInstanceSetId = GeneratedColumn<int>(
      'alarm_instance_set_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES alarm_instance_sets (id) ON DELETE CASCADE'));
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
  List<GeneratedColumn> get $columns =>
      [id, alarmId, alarmInstanceSetId, time, isEnabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarm_instances';
  @override
  VerificationContext validateIntegrity(Insertable<AlarmInstance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('alarm_id')) {
      context.handle(_alarmIdMeta,
          alarmId.isAcceptableOrUnknown(data['alarm_id']!, _alarmIdMeta));
    }
    if (data.containsKey('alarm_instance_set_id')) {
      context.handle(
          _alarmInstanceSetIdMeta,
          alarmInstanceSetId.isAcceptableOrUnknown(
              data['alarm_instance_set_id']!, _alarmInstanceSetIdMeta));
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
  AlarmInstance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmInstance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      alarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}alarm_id']),
      alarmInstanceSetId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}alarm_instance_set_id']),
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
    );
  }

  @override
  $AlarmInstancesTable createAlias(String alias) {
    return $AlarmInstancesTable(attachedDatabase, alias);
  }
}

class AlarmInstance extends DataClass implements Insertable<AlarmInstance> {
  final int id;
  final int? alarmId;
  final int? alarmInstanceSetId;
  final DateTime time;
  final bool isEnabled;
  const AlarmInstance(
      {required this.id,
      this.alarmId,
      this.alarmInstanceSetId,
      required this.time,
      required this.isEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || alarmId != null) {
      map['alarm_id'] = Variable<int>(alarmId);
    }
    if (!nullToAbsent || alarmInstanceSetId != null) {
      map['alarm_instance_set_id'] = Variable<int>(alarmInstanceSetId);
    }
    map['time'] = Variable<DateTime>(time);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  AlarmInstancesCompanion toCompanion(bool nullToAbsent) {
    return AlarmInstancesCompanion(
      id: Value(id),
      alarmId: alarmId == null && nullToAbsent
          ? const Value.absent()
          : Value(alarmId),
      alarmInstanceSetId: alarmInstanceSetId == null && nullToAbsent
          ? const Value.absent()
          : Value(alarmInstanceSetId),
      time: Value(time),
      isEnabled: Value(isEnabled),
    );
  }

  factory AlarmInstance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmInstance(
      id: serializer.fromJson<int>(json['id']),
      alarmId: serializer.fromJson<int?>(json['alarmId']),
      alarmInstanceSetId: serializer.fromJson<int?>(json['alarmInstanceSetId']),
      time: serializer.fromJson<DateTime>(json['time']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'alarmId': serializer.toJson<int?>(alarmId),
      'alarmInstanceSetId': serializer.toJson<int?>(alarmInstanceSetId),
      'time': serializer.toJson<DateTime>(time),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  AlarmInstance copyWith(
          {int? id,
          Value<int?> alarmId = const Value.absent(),
          Value<int?> alarmInstanceSetId = const Value.absent(),
          DateTime? time,
          bool? isEnabled}) =>
      AlarmInstance(
        id: id ?? this.id,
        alarmId: alarmId.present ? alarmId.value : this.alarmId,
        alarmInstanceSetId: alarmInstanceSetId.present
            ? alarmInstanceSetId.value
            : this.alarmInstanceSetId,
        time: time ?? this.time,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  AlarmInstance copyWithCompanion(AlarmInstancesCompanion data) {
    return AlarmInstance(
      id: data.id.present ? data.id.value : this.id,
      alarmId: data.alarmId.present ? data.alarmId.value : this.alarmId,
      alarmInstanceSetId: data.alarmInstanceSetId.present
          ? data.alarmInstanceSetId.value
          : this.alarmInstanceSetId,
      time: data.time.present ? data.time.value : this.time,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmInstance(')
          ..write('id: $id, ')
          ..write('alarmId: $alarmId, ')
          ..write('alarmInstanceSetId: $alarmInstanceSetId, ')
          ..write('time: $time, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, alarmId, alarmInstanceSetId, time, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmInstance &&
          other.id == this.id &&
          other.alarmId == this.alarmId &&
          other.alarmInstanceSetId == this.alarmInstanceSetId &&
          other.time == this.time &&
          other.isEnabled == this.isEnabled);
}

class AlarmInstancesCompanion extends UpdateCompanion<AlarmInstance> {
  final Value<int> id;
  final Value<int?> alarmId;
  final Value<int?> alarmInstanceSetId;
  final Value<DateTime> time;
  final Value<bool> isEnabled;
  const AlarmInstancesCompanion({
    this.id = const Value.absent(),
    this.alarmId = const Value.absent(),
    this.alarmInstanceSetId = const Value.absent(),
    this.time = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  AlarmInstancesCompanion.insert({
    this.id = const Value.absent(),
    this.alarmId = const Value.absent(),
    this.alarmInstanceSetId = const Value.absent(),
    required DateTime time,
    this.isEnabled = const Value.absent(),
  }) : time = Value(time);
  static Insertable<AlarmInstance> custom({
    Expression<int>? id,
    Expression<int>? alarmId,
    Expression<int>? alarmInstanceSetId,
    Expression<DateTime>? time,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (alarmId != null) 'alarm_id': alarmId,
      if (alarmInstanceSetId != null)
        'alarm_instance_set_id': alarmInstanceSetId,
      if (time != null) 'time': time,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  AlarmInstancesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? alarmId,
      Value<int?>? alarmInstanceSetId,
      Value<DateTime>? time,
      Value<bool>? isEnabled}) {
    return AlarmInstancesCompanion(
      id: id ?? this.id,
      alarmId: alarmId ?? this.alarmId,
      alarmInstanceSetId: alarmInstanceSetId ?? this.alarmInstanceSetId,
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
    if (alarmId.present) {
      map['alarm_id'] = Variable<int>(alarmId.value);
    }
    if (alarmInstanceSetId.present) {
      map['alarm_instance_set_id'] = Variable<int>(alarmInstanceSetId.value);
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
    return (StringBuffer('AlarmInstancesCompanion(')
          ..write('id: $id, ')
          ..write('alarmId: $alarmId, ')
          ..write('alarmInstanceSetId: $alarmInstanceSetId, ')
          ..write('time: $time, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AlarmDatabase extends GeneratedDatabase {
  _$AlarmDatabase(QueryExecutor e) : super(e);
  $AlarmDatabaseManager get managers => $AlarmDatabaseManager(this);
  late final $DbAlarmsTable dbAlarms = $DbAlarmsTable(this);
  late final $AlarmInstanceSetsTable alarmInstanceSets =
      $AlarmInstanceSetsTable(this);
  late final $AlarmInstancesTable alarmInstances = $AlarmInstancesTable(this);
  late final AlarmInstanceSetDao alarmInstanceSetDao =
      AlarmInstanceSetDao(this as AlarmDatabase);
  late final AlarmInstancesDao alarmInstancesDao =
      AlarmInstancesDao(this as AlarmDatabase);
  late final DbAlarmDao dbAlarmDao = DbAlarmDao(this as AlarmDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dbAlarms, alarmInstanceSets, alarmInstances];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('db_alarms',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('alarm_instances', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('alarm_instance_sets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('alarm_instances', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$DbAlarmsTableCreateCompanionBuilder = DbAlarmsCompanion Function({
  Value<int> id,
  Value<String?> name,
  required String audioPath,
  Value<int?> snoozeDuration,
  Value<EqualList<Weekday>?> daysOfWeek,
  Value<bool> isEnabled,
});
typedef $$DbAlarmsTableUpdateCompanionBuilder = DbAlarmsCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String> audioPath,
  Value<int?> snoozeDuration,
  Value<EqualList<Weekday>?> daysOfWeek,
  Value<bool> isEnabled,
});

final class $$DbAlarmsTableReferences
    extends BaseReferences<_$AlarmDatabase, $DbAlarmsTable, DbAlarm> {
  $$DbAlarmsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AlarmInstancesTable, List<AlarmInstance>>
      _alarmInstancesRefsTable(_$AlarmDatabase db) =>
          MultiTypedResultKey.fromTable(db.alarmInstances,
              aliasName: $_aliasNameGenerator(
                  db.dbAlarms.id, db.alarmInstances.alarmId));

  $$AlarmInstancesTableProcessedTableManager get alarmInstancesRefs {
    final manager = $$AlarmInstancesTableTableManager($_db, $_db.alarmInstances)
        .filter((f) => f.alarmId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_alarmInstancesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DbAlarmsTableFilterComposer
    extends Composer<_$AlarmDatabase, $DbAlarmsTable> {
  $$DbAlarmsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioPath => $composableBuilder(
      column: $table.audioPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get snoozeDuration => $composableBuilder(
      column: $table.snoozeDuration,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<EqualList<Weekday>?, EqualList<Weekday>,
          String>
      get daysOfWeek => $composableBuilder(
          column: $table.daysOfWeek,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));

  Expression<bool> alarmInstancesRefs(
      Expression<bool> Function($$AlarmInstancesTableFilterComposer f) f) {
    final $$AlarmInstancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.alarmInstances,
        getReferencedColumn: (t) => t.alarmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlarmInstancesTableFilterComposer(
              $db: $db,
              $table: $db.alarmInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DbAlarmsTableOrderingComposer
    extends Composer<_$AlarmDatabase, $DbAlarmsTable> {
  $$DbAlarmsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioPath => $composableBuilder(
      column: $table.audioPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get snoozeDuration => $composableBuilder(
      column: $table.snoozeDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get daysOfWeek => $composableBuilder(
      column: $table.daysOfWeek, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));
}

class $$DbAlarmsTableAnnotationComposer
    extends Composer<_$AlarmDatabase, $DbAlarmsTable> {
  $$DbAlarmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<int> get snoozeDuration => $composableBuilder(
      column: $table.snoozeDuration, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EqualList<Weekday>?, String>
      get daysOfWeek => $composableBuilder(
          column: $table.daysOfWeek, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  Expression<T> alarmInstancesRefs<T extends Object>(
      Expression<T> Function($$AlarmInstancesTableAnnotationComposer a) f) {
    final $$AlarmInstancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.alarmInstances,
        getReferencedColumn: (t) => t.alarmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlarmInstancesTableAnnotationComposer(
              $db: $db,
              $table: $db.alarmInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DbAlarmsTableTableManager extends RootTableManager<
    _$AlarmDatabase,
    $DbAlarmsTable,
    DbAlarm,
    $$DbAlarmsTableFilterComposer,
    $$DbAlarmsTableOrderingComposer,
    $$DbAlarmsTableAnnotationComposer,
    $$DbAlarmsTableCreateCompanionBuilder,
    $$DbAlarmsTableUpdateCompanionBuilder,
    (DbAlarm, $$DbAlarmsTableReferences),
    DbAlarm,
    PrefetchHooks Function({bool alarmInstancesRefs})> {
  $$DbAlarmsTableTableManager(_$AlarmDatabase db, $DbAlarmsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbAlarmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbAlarmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbAlarmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String> audioPath = const Value.absent(),
            Value<int?> snoozeDuration = const Value.absent(),
            Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              DbAlarmsCompanion(
            id: id,
            name: name,
            audioPath: audioPath,
            snoozeDuration: snoozeDuration,
            daysOfWeek: daysOfWeek,
            isEnabled: isEnabled,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required String audioPath,
            Value<int?> snoozeDuration = const Value.absent(),
            Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              DbAlarmsCompanion.insert(
            id: id,
            name: name,
            audioPath: audioPath,
            snoozeDuration: snoozeDuration,
            daysOfWeek: daysOfWeek,
            isEnabled: isEnabled,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DbAlarmsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({alarmInstancesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (alarmInstancesRefs) db.alarmInstances
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (alarmInstancesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$DbAlarmsTableReferences
                            ._alarmInstancesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DbAlarmsTableReferences(db, table, p0)
                                .alarmInstancesRefs,
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

typedef $$DbAlarmsTableProcessedTableManager = ProcessedTableManager<
    _$AlarmDatabase,
    $DbAlarmsTable,
    DbAlarm,
    $$DbAlarmsTableFilterComposer,
    $$DbAlarmsTableOrderingComposer,
    $$DbAlarmsTableAnnotationComposer,
    $$DbAlarmsTableCreateCompanionBuilder,
    $$DbAlarmsTableUpdateCompanionBuilder,
    (DbAlarm, $$DbAlarmsTableReferences),
    DbAlarm,
    PrefetchHooks Function({bool alarmInstancesRefs})>;
typedef $$AlarmInstanceSetsTableCreateCompanionBuilder
    = AlarmInstanceSetsCompanion Function({
  Value<int> id,
  Value<String?> name,
  required String audioPath,
  required DateTime startTime,
  required DateTime endTime,
  Value<EqualList<Weekday>?> daysOfWeek,
  required int intervalBetweenAlarms,
  Value<int?> pauseDuration,
  Value<bool> isEnabled,
});
typedef $$AlarmInstanceSetsTableUpdateCompanionBuilder
    = AlarmInstanceSetsCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String> audioPath,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<EqualList<Weekday>?> daysOfWeek,
  Value<int> intervalBetweenAlarms,
  Value<int?> pauseDuration,
  Value<bool> isEnabled,
});

final class $$AlarmInstanceSetsTableReferences extends BaseReferences<
    _$AlarmDatabase, $AlarmInstanceSetsTable, AlarmInstanceSet> {
  $$AlarmInstanceSetsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AlarmInstancesTable, List<AlarmInstance>>
      _alarmInstancesRefsTable(_$AlarmDatabase db) =>
          MultiTypedResultKey.fromTable(db.alarmInstances,
              aliasName: $_aliasNameGenerator(db.alarmInstanceSets.id,
                  db.alarmInstances.alarmInstanceSetId));

  $$AlarmInstancesTableProcessedTableManager get alarmInstancesRefs {
    final manager = $$AlarmInstancesTableTableManager($_db, $_db.alarmInstances)
        .filter((f) => f.alarmInstanceSetId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_alarmInstancesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AlarmInstanceSetsTableFilterComposer
    extends Composer<_$AlarmDatabase, $AlarmInstanceSetsTable> {
  $$AlarmInstanceSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioPath => $composableBuilder(
      column: $table.audioPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<EqualList<Weekday>?, EqualList<Weekday>,
          String>
      get daysOfWeek => $composableBuilder(
          column: $table.daysOfWeek,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get intervalBetweenAlarms => $composableBuilder(
      column: $table.intervalBetweenAlarms,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pauseDuration => $composableBuilder(
      column: $table.pauseDuration, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));

  Expression<bool> alarmInstancesRefs(
      Expression<bool> Function($$AlarmInstancesTableFilterComposer f) f) {
    final $$AlarmInstancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.alarmInstances,
        getReferencedColumn: (t) => t.alarmInstanceSetId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlarmInstancesTableFilterComposer(
              $db: $db,
              $table: $db.alarmInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AlarmInstanceSetsTableOrderingComposer
    extends Composer<_$AlarmDatabase, $AlarmInstanceSetsTable> {
  $$AlarmInstanceSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioPath => $composableBuilder(
      column: $table.audioPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get daysOfWeek => $composableBuilder(
      column: $table.daysOfWeek, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervalBetweenAlarms => $composableBuilder(
      column: $table.intervalBetweenAlarms,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pauseDuration => $composableBuilder(
      column: $table.pauseDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));
}

class $$AlarmInstanceSetsTableAnnotationComposer
    extends Composer<_$AlarmDatabase, $AlarmInstanceSetsTable> {
  $$AlarmInstanceSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EqualList<Weekday>?, String>
      get daysOfWeek => $composableBuilder(
          column: $table.daysOfWeek, builder: (column) => column);

  GeneratedColumn<int> get intervalBetweenAlarms => $composableBuilder(
      column: $table.intervalBetweenAlarms, builder: (column) => column);

  GeneratedColumn<int> get pauseDuration => $composableBuilder(
      column: $table.pauseDuration, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  Expression<T> alarmInstancesRefs<T extends Object>(
      Expression<T> Function($$AlarmInstancesTableAnnotationComposer a) f) {
    final $$AlarmInstancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.alarmInstances,
        getReferencedColumn: (t) => t.alarmInstanceSetId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlarmInstancesTableAnnotationComposer(
              $db: $db,
              $table: $db.alarmInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AlarmInstanceSetsTableTableManager extends RootTableManager<
    _$AlarmDatabase,
    $AlarmInstanceSetsTable,
    AlarmInstanceSet,
    $$AlarmInstanceSetsTableFilterComposer,
    $$AlarmInstanceSetsTableOrderingComposer,
    $$AlarmInstanceSetsTableAnnotationComposer,
    $$AlarmInstanceSetsTableCreateCompanionBuilder,
    $$AlarmInstanceSetsTableUpdateCompanionBuilder,
    (AlarmInstanceSet, $$AlarmInstanceSetsTableReferences),
    AlarmInstanceSet,
    PrefetchHooks Function({bool alarmInstancesRefs})> {
  $$AlarmInstanceSetsTableTableManager(
      _$AlarmDatabase db, $AlarmInstanceSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmInstanceSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmInstanceSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmInstanceSetsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String> audioPath = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
            Value<int> intervalBetweenAlarms = const Value.absent(),
            Value<int?> pauseDuration = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              AlarmInstanceSetsCompanion(
            id: id,
            name: name,
            audioPath: audioPath,
            startTime: startTime,
            endTime: endTime,
            daysOfWeek: daysOfWeek,
            intervalBetweenAlarms: intervalBetweenAlarms,
            pauseDuration: pauseDuration,
            isEnabled: isEnabled,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required String audioPath,
            required DateTime startTime,
            required DateTime endTime,
            Value<EqualList<Weekday>?> daysOfWeek = const Value.absent(),
            required int intervalBetweenAlarms,
            Value<int?> pauseDuration = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              AlarmInstanceSetsCompanion.insert(
            id: id,
            name: name,
            audioPath: audioPath,
            startTime: startTime,
            endTime: endTime,
            daysOfWeek: daysOfWeek,
            intervalBetweenAlarms: intervalBetweenAlarms,
            pauseDuration: pauseDuration,
            isEnabled: isEnabled,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AlarmInstanceSetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({alarmInstancesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (alarmInstancesRefs) db.alarmInstances
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (alarmInstancesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AlarmInstanceSetsTableReferences
                            ._alarmInstancesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AlarmInstanceSetsTableReferences(db, table, p0)
                                .alarmInstancesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.alarmInstanceSetId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AlarmInstanceSetsTableProcessedTableManager = ProcessedTableManager<
    _$AlarmDatabase,
    $AlarmInstanceSetsTable,
    AlarmInstanceSet,
    $$AlarmInstanceSetsTableFilterComposer,
    $$AlarmInstanceSetsTableOrderingComposer,
    $$AlarmInstanceSetsTableAnnotationComposer,
    $$AlarmInstanceSetsTableCreateCompanionBuilder,
    $$AlarmInstanceSetsTableUpdateCompanionBuilder,
    (AlarmInstanceSet, $$AlarmInstanceSetsTableReferences),
    AlarmInstanceSet,
    PrefetchHooks Function({bool alarmInstancesRefs})>;
typedef $$AlarmInstancesTableCreateCompanionBuilder = AlarmInstancesCompanion
    Function({
  Value<int> id,
  Value<int?> alarmId,
  Value<int?> alarmInstanceSetId,
  required DateTime time,
  Value<bool> isEnabled,
});
typedef $$AlarmInstancesTableUpdateCompanionBuilder = AlarmInstancesCompanion
    Function({
  Value<int> id,
  Value<int?> alarmId,
  Value<int?> alarmInstanceSetId,
  Value<DateTime> time,
  Value<bool> isEnabled,
});

final class $$AlarmInstancesTableReferences extends BaseReferences<
    _$AlarmDatabase, $AlarmInstancesTable, AlarmInstance> {
  $$AlarmInstancesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DbAlarmsTable _alarmIdTable(_$AlarmDatabase db) =>
      db.dbAlarms.createAlias(
          $_aliasNameGenerator(db.alarmInstances.alarmId, db.dbAlarms.id));

  $$DbAlarmsTableProcessedTableManager? get alarmId {
    if ($_item.alarmId == null) return null;
    final manager = $$DbAlarmsTableTableManager($_db, $_db.dbAlarms)
        .filter((f) => f.id($_item.alarmId!));
    final item = $_typedResult.readTableOrNull(_alarmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AlarmInstanceSetsTable _alarmInstanceSetIdTable(_$AlarmDatabase db) =>
      db.alarmInstanceSets.createAlias($_aliasNameGenerator(
          db.alarmInstances.alarmInstanceSetId, db.alarmInstanceSets.id));

  $$AlarmInstanceSetsTableProcessedTableManager? get alarmInstanceSetId {
    if ($_item.alarmInstanceSetId == null) return null;
    final manager =
        $$AlarmInstanceSetsTableTableManager($_db, $_db.alarmInstanceSets)
            .filter((f) => f.id($_item.alarmInstanceSetId!));
    final item = $_typedResult.readTableOrNull(_alarmInstanceSetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AlarmInstancesTableFilterComposer
    extends Composer<_$AlarmDatabase, $AlarmInstancesTable> {
  $$AlarmInstancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));

  $$DbAlarmsTableFilterComposer get alarmId {
    final $$DbAlarmsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.alarmId,
        referencedTable: $db.dbAlarms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DbAlarmsTableFilterComposer(
              $db: $db,
              $table: $db.dbAlarms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AlarmInstanceSetsTableFilterComposer get alarmInstanceSetId {
    final $$AlarmInstanceSetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.alarmInstanceSetId,
        referencedTable: $db.alarmInstanceSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlarmInstanceSetsTableFilterComposer(
              $db: $db,
              $table: $db.alarmInstanceSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlarmInstancesTableOrderingComposer
    extends Composer<_$AlarmDatabase, $AlarmInstancesTable> {
  $$AlarmInstancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));

  $$DbAlarmsTableOrderingComposer get alarmId {
    final $$DbAlarmsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.alarmId,
        referencedTable: $db.dbAlarms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DbAlarmsTableOrderingComposer(
              $db: $db,
              $table: $db.dbAlarms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AlarmInstanceSetsTableOrderingComposer get alarmInstanceSetId {
    final $$AlarmInstanceSetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.alarmInstanceSetId,
        referencedTable: $db.alarmInstanceSets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlarmInstanceSetsTableOrderingComposer(
              $db: $db,
              $table: $db.alarmInstanceSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlarmInstancesTableAnnotationComposer
    extends Composer<_$AlarmDatabase, $AlarmInstancesTable> {
  $$AlarmInstancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  $$DbAlarmsTableAnnotationComposer get alarmId {
    final $$DbAlarmsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.alarmId,
        referencedTable: $db.dbAlarms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DbAlarmsTableAnnotationComposer(
              $db: $db,
              $table: $db.dbAlarms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AlarmInstanceSetsTableAnnotationComposer get alarmInstanceSetId {
    final $$AlarmInstanceSetsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.alarmInstanceSetId,
            referencedTable: $db.alarmInstanceSets,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AlarmInstanceSetsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.alarmInstanceSets,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$AlarmInstancesTableTableManager extends RootTableManager<
    _$AlarmDatabase,
    $AlarmInstancesTable,
    AlarmInstance,
    $$AlarmInstancesTableFilterComposer,
    $$AlarmInstancesTableOrderingComposer,
    $$AlarmInstancesTableAnnotationComposer,
    $$AlarmInstancesTableCreateCompanionBuilder,
    $$AlarmInstancesTableUpdateCompanionBuilder,
    (AlarmInstance, $$AlarmInstancesTableReferences),
    AlarmInstance,
    PrefetchHooks Function({bool alarmId, bool alarmInstanceSetId})> {
  $$AlarmInstancesTableTableManager(
      _$AlarmDatabase db, $AlarmInstancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmInstancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmInstancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmInstancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> alarmId = const Value.absent(),
            Value<int?> alarmInstanceSetId = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              AlarmInstancesCompanion(
            id: id,
            alarmId: alarmId,
            alarmInstanceSetId: alarmInstanceSetId,
            time: time,
            isEnabled: isEnabled,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> alarmId = const Value.absent(),
            Value<int?> alarmInstanceSetId = const Value.absent(),
            required DateTime time,
            Value<bool> isEnabled = const Value.absent(),
          }) =>
              AlarmInstancesCompanion.insert(
            id: id,
            alarmId: alarmId,
            alarmInstanceSetId: alarmInstanceSetId,
            time: time,
            isEnabled: isEnabled,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AlarmInstancesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {alarmId = false, alarmInstanceSetId = false}) {
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
                      dynamic,
                      dynamic>>(state) {
                if (alarmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.alarmId,
                    referencedTable:
                        $$AlarmInstancesTableReferences._alarmIdTable(db),
                    referencedColumn:
                        $$AlarmInstancesTableReferences._alarmIdTable(db).id,
                  ) as T;
                }
                if (alarmInstanceSetId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.alarmInstanceSetId,
                    referencedTable: $$AlarmInstancesTableReferences
                        ._alarmInstanceSetIdTable(db),
                    referencedColumn: $$AlarmInstancesTableReferences
                        ._alarmInstanceSetIdTable(db)
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

typedef $$AlarmInstancesTableProcessedTableManager = ProcessedTableManager<
    _$AlarmDatabase,
    $AlarmInstancesTable,
    AlarmInstance,
    $$AlarmInstancesTableFilterComposer,
    $$AlarmInstancesTableOrderingComposer,
    $$AlarmInstancesTableAnnotationComposer,
    $$AlarmInstancesTableCreateCompanionBuilder,
    $$AlarmInstancesTableUpdateCompanionBuilder,
    (AlarmInstance, $$AlarmInstancesTableReferences),
    AlarmInstance,
    PrefetchHooks Function({bool alarmId, bool alarmInstanceSetId})>;

class $AlarmDatabaseManager {
  final _$AlarmDatabase _db;
  $AlarmDatabaseManager(this._db);
  $$DbAlarmsTableTableManager get dbAlarms =>
      $$DbAlarmsTableTableManager(_db, _db.dbAlarms);
  $$AlarmInstanceSetsTableTableManager get alarmInstanceSets =>
      $$AlarmInstanceSetsTableTableManager(_db, _db.alarmInstanceSets);
  $$AlarmInstancesTableTableManager get alarmInstances =>
      $$AlarmInstancesTableTableManager(_db, _db.alarmInstances);
}

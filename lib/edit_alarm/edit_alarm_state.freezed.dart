// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_alarm_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditAlarmState {
  int? get alarmId => throw _privateConstructorUsedError;
  FocusDuration get focusDuration => throw _privateConstructorUsedError;
  TimeOfDay get fromTimeOfDay => throw _privateConstructorUsedError;
  TimeOfDay get toTimeOfDay => throw _privateConstructorUsedError;
  AlarmDetails? get nextAlarm => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditAlarmStateCopyWith<EditAlarmState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditAlarmStateCopyWith<$Res> {
  factory $EditAlarmStateCopyWith(
          EditAlarmState value, $Res Function(EditAlarmState) then) =
      _$EditAlarmStateCopyWithImpl<$Res, EditAlarmState>;
  @useResult
  $Res call(
      {int? alarmId,
      FocusDuration focusDuration,
      TimeOfDay fromTimeOfDay,
      TimeOfDay toTimeOfDay,
      AlarmDetails? nextAlarm});
}

/// @nodoc
class _$EditAlarmStateCopyWithImpl<$Res, $Val extends EditAlarmState>
    implements $EditAlarmStateCopyWith<$Res> {
  _$EditAlarmStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alarmId = freezed,
    Object? focusDuration = null,
    Object? fromTimeOfDay = null,
    Object? toTimeOfDay = null,
    Object? nextAlarm = freezed,
  }) {
    return _then(_value.copyWith(
      alarmId: freezed == alarmId
          ? _value.alarmId
          : alarmId // ignore: cast_nullable_to_non_nullable
              as int?,
      focusDuration: null == focusDuration
          ? _value.focusDuration
          : focusDuration // ignore: cast_nullable_to_non_nullable
              as FocusDuration,
      fromTimeOfDay: null == fromTimeOfDay
          ? _value.fromTimeOfDay
          : fromTimeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      toTimeOfDay: null == toTimeOfDay
          ? _value.toTimeOfDay
          : toTimeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      nextAlarm: freezed == nextAlarm
          ? _value.nextAlarm
          : nextAlarm // ignore: cast_nullable_to_non_nullable
              as AlarmDetails?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditAlarmStateImplCopyWith<$Res>
    implements $EditAlarmStateCopyWith<$Res> {
  factory _$$EditAlarmStateImplCopyWith(_$EditAlarmStateImpl value,
          $Res Function(_$EditAlarmStateImpl) then) =
      __$$EditAlarmStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? alarmId,
      FocusDuration focusDuration,
      TimeOfDay fromTimeOfDay,
      TimeOfDay toTimeOfDay,
      AlarmDetails? nextAlarm});
}

/// @nodoc
class __$$EditAlarmStateImplCopyWithImpl<$Res>
    extends _$EditAlarmStateCopyWithImpl<$Res, _$EditAlarmStateImpl>
    implements _$$EditAlarmStateImplCopyWith<$Res> {
  __$$EditAlarmStateImplCopyWithImpl(
      _$EditAlarmStateImpl _value, $Res Function(_$EditAlarmStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alarmId = freezed,
    Object? focusDuration = null,
    Object? fromTimeOfDay = null,
    Object? toTimeOfDay = null,
    Object? nextAlarm = freezed,
  }) {
    return _then(_$EditAlarmStateImpl(
      alarmId: freezed == alarmId
          ? _value.alarmId
          : alarmId // ignore: cast_nullable_to_non_nullable
              as int?,
      focusDuration: null == focusDuration
          ? _value.focusDuration
          : focusDuration // ignore: cast_nullable_to_non_nullable
              as FocusDuration,
      fromTimeOfDay: null == fromTimeOfDay
          ? _value.fromTimeOfDay
          : fromTimeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      toTimeOfDay: null == toTimeOfDay
          ? _value.toTimeOfDay
          : toTimeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      nextAlarm: freezed == nextAlarm
          ? _value.nextAlarm
          : nextAlarm // ignore: cast_nullable_to_non_nullable
              as AlarmDetails?,
    ));
  }
}

/// @nodoc

class _$EditAlarmStateImpl implements _EditAlarmState {
  _$EditAlarmStateImpl(
      {this.alarmId,
      required this.focusDuration,
      required this.fromTimeOfDay,
      required this.toTimeOfDay,
      this.nextAlarm});

  @override
  final int? alarmId;
  @override
  final FocusDuration focusDuration;
  @override
  final TimeOfDay fromTimeOfDay;
  @override
  final TimeOfDay toTimeOfDay;
  @override
  final AlarmDetails? nextAlarm;

  @override
  String toString() {
    return 'EditAlarmState(alarmId: $alarmId, focusDuration: $focusDuration, fromTimeOfDay: $fromTimeOfDay, toTimeOfDay: $toTimeOfDay, nextAlarm: $nextAlarm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditAlarmStateImpl &&
            (identical(other.alarmId, alarmId) || other.alarmId == alarmId) &&
            (identical(other.focusDuration, focusDuration) ||
                other.focusDuration == focusDuration) &&
            (identical(other.fromTimeOfDay, fromTimeOfDay) ||
                other.fromTimeOfDay == fromTimeOfDay) &&
            (identical(other.toTimeOfDay, toTimeOfDay) ||
                other.toTimeOfDay == toTimeOfDay) &&
            (identical(other.nextAlarm, nextAlarm) ||
                other.nextAlarm == nextAlarm));
  }

  @override
  int get hashCode => Object.hash(runtimeType, alarmId, focusDuration,
      fromTimeOfDay, toTimeOfDay, nextAlarm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditAlarmStateImplCopyWith<_$EditAlarmStateImpl> get copyWith =>
      __$$EditAlarmStateImplCopyWithImpl<_$EditAlarmStateImpl>(
          this, _$identity);
}

abstract class _EditAlarmState implements EditAlarmState {
  factory _EditAlarmState(
      {final int? alarmId,
      required final FocusDuration focusDuration,
      required final TimeOfDay fromTimeOfDay,
      required final TimeOfDay toTimeOfDay,
      final AlarmDetails? nextAlarm}) = _$EditAlarmStateImpl;

  @override
  int? get alarmId;
  @override
  FocusDuration get focusDuration;
  @override
  TimeOfDay get fromTimeOfDay;
  @override
  TimeOfDay get toTimeOfDay;
  @override
  AlarmDetails? get nextAlarm;
  @override
  @JsonKey(ignore: true)
  _$$EditAlarmStateImplCopyWith<_$EditAlarmStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

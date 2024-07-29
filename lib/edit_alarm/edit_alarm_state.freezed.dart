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
  FocusDuration get focusDuration => throw _privateConstructorUsedError;
  BreakDuration get breakDuration => throw _privateConstructorUsedError;
  DateTime get fromDate => throw _privateConstructorUsedError;
  DateTime get toDate => throw _privateConstructorUsedError;
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
      {FocusDuration focusDuration,
      BreakDuration breakDuration,
      DateTime fromDate,
      DateTime toDate,
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
    Object? focusDuration = null,
    Object? breakDuration = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? nextAlarm = freezed,
  }) {
    return _then(_value.copyWith(
      focusDuration: null == focusDuration
          ? _value.focusDuration
          : focusDuration // ignore: cast_nullable_to_non_nullable
              as FocusDuration,
      breakDuration: null == breakDuration
          ? _value.breakDuration
          : breakDuration // ignore: cast_nullable_to_non_nullable
              as BreakDuration,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      {FocusDuration focusDuration,
      BreakDuration breakDuration,
      DateTime fromDate,
      DateTime toDate,
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
    Object? focusDuration = null,
    Object? breakDuration = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? nextAlarm = freezed,
  }) {
    return _then(_$EditAlarmStateImpl(
      focusDuration: null == focusDuration
          ? _value.focusDuration
          : focusDuration // ignore: cast_nullable_to_non_nullable
              as FocusDuration,
      breakDuration: null == breakDuration
          ? _value.breakDuration
          : breakDuration // ignore: cast_nullable_to_non_nullable
              as BreakDuration,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nextAlarm: freezed == nextAlarm
          ? _value.nextAlarm
          : nextAlarm // ignore: cast_nullable_to_non_nullable
              as AlarmDetails?,
    ));
  }
}

/// @nodoc

class _$EditAlarmStateImpl
    with DiagnosticableTreeMixin
    implements _EditAlarmState {
  _$EditAlarmStateImpl(
      {required this.focusDuration,
      required this.breakDuration,
      required this.fromDate,
      required this.toDate,
      this.nextAlarm});

  @override
  final FocusDuration focusDuration;
  @override
  final BreakDuration breakDuration;
  @override
  final DateTime fromDate;
  @override
  final DateTime toDate;
  @override
  final AlarmDetails? nextAlarm;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditAlarmState(focusDuration: $focusDuration, breakDuration: $breakDuration, fromDate: $fromDate, toDate: $toDate, nextAlarm: $nextAlarm)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditAlarmState'))
      ..add(DiagnosticsProperty('focusDuration', focusDuration))
      ..add(DiagnosticsProperty('breakDuration', breakDuration))
      ..add(DiagnosticsProperty('fromDate', fromDate))
      ..add(DiagnosticsProperty('toDate', toDate))
      ..add(DiagnosticsProperty('nextAlarm', nextAlarm));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditAlarmStateImpl &&
            (identical(other.focusDuration, focusDuration) ||
                other.focusDuration == focusDuration) &&
            (identical(other.breakDuration, breakDuration) ||
                other.breakDuration == breakDuration) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.nextAlarm, nextAlarm) ||
                other.nextAlarm == nextAlarm));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, focusDuration, breakDuration, fromDate, toDate, nextAlarm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditAlarmStateImplCopyWith<_$EditAlarmStateImpl> get copyWith =>
      __$$EditAlarmStateImplCopyWithImpl<_$EditAlarmStateImpl>(
          this, _$identity);
}

abstract class _EditAlarmState implements EditAlarmState {
  factory _EditAlarmState(
      {required final FocusDuration focusDuration,
      required final BreakDuration breakDuration,
      required final DateTime fromDate,
      required final DateTime toDate,
      final AlarmDetails? nextAlarm}) = _$EditAlarmStateImpl;

  @override
  FocusDuration get focusDuration;
  @override
  BreakDuration get breakDuration;
  @override
  DateTime get fromDate;
  @override
  DateTime get toDate;
  @override
  AlarmDetails? get nextAlarm;
  @override
  @JsonKey(ignore: true)
  _$$EditAlarmStateImplCopyWith<_$EditAlarmStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ring_alarm_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RingAlarmState {
  int get steps => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RingAlarmStateCopyWith<RingAlarmState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RingAlarmStateCopyWith<$Res> {
  factory $RingAlarmStateCopyWith(
          RingAlarmState value, $Res Function(RingAlarmState) then) =
      _$RingAlarmStateCopyWithImpl<$Res, RingAlarmState>;
  @useResult
  $Res call({int steps, String status, bool completed});
}

/// @nodoc
class _$RingAlarmStateCopyWithImpl<$Res, $Val extends RingAlarmState>
    implements $RingAlarmStateCopyWith<$Res> {
  _$RingAlarmStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? status = null,
    Object? completed = null,
  }) {
    return _then(_value.copyWith(
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RingAlarmStateImplCopyWith<$Res>
    implements $RingAlarmStateCopyWith<$Res> {
  factory _$$RingAlarmStateImplCopyWith(_$RingAlarmStateImpl value,
          $Res Function(_$RingAlarmStateImpl) then) =
      __$$RingAlarmStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int steps, String status, bool completed});
}

/// @nodoc
class __$$RingAlarmStateImplCopyWithImpl<$Res>
    extends _$RingAlarmStateCopyWithImpl<$Res, _$RingAlarmStateImpl>
    implements _$$RingAlarmStateImplCopyWith<$Res> {
  __$$RingAlarmStateImplCopyWithImpl(
      _$RingAlarmStateImpl _value, $Res Function(_$RingAlarmStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? status = null,
    Object? completed = null,
  }) {
    return _then(_$RingAlarmStateImpl(
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RingAlarmStateImpl implements _RingAlarmState {
  _$RingAlarmStateImpl(
      {required this.steps, required this.status, required this.completed});

  @override
  final int steps;
  @override
  final String status;
  @override
  final bool completed;

  @override
  String toString() {
    return 'RingAlarmState(steps: $steps, status: $status, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RingAlarmStateImpl &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, steps, status, completed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RingAlarmStateImplCopyWith<_$RingAlarmStateImpl> get copyWith =>
      __$$RingAlarmStateImplCopyWithImpl<_$RingAlarmStateImpl>(
          this, _$identity);
}

abstract class _RingAlarmState implements RingAlarmState {
  factory _RingAlarmState(
      {required final int steps,
      required final String status,
      required final bool completed}) = _$RingAlarmStateImpl;

  @override
  int get steps;
  @override
  String get status;
  @override
  bool get completed;
  @override
  @JsonKey(ignore: true)
  _$$RingAlarmStateImplCopyWith<_$RingAlarmStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

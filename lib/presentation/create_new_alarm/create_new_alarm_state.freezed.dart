// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_new_alarm_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateNewAlarmState {
  List<DateTime> get selectedTime => throw _privateConstructorUsedError;
  AlarmType get type => throw _privateConstructorUsedError;
  String get soundPath => throw _privateConstructorUsedError;
  bool get isVibrate => throw _privateConstructorUsedError;
  List<Weekday> get daysOfWeek => throw _privateConstructorUsedError;
  String? get selectedDaysText => throw _privateConstructorUsedError;
  int? get snoozeDuration => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateNewAlarmStateCopyWith<CreateNewAlarmState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateNewAlarmStateCopyWith<$Res> {
  factory $CreateNewAlarmStateCopyWith(
          CreateNewAlarmState value, $Res Function(CreateNewAlarmState) then) =
      _$CreateNewAlarmStateCopyWithImpl<$Res, CreateNewAlarmState>;
  @useResult
  $Res call(
      {List<DateTime> selectedTime,
      AlarmType type,
      String soundPath,
      bool isVibrate,
      List<Weekday> daysOfWeek,
      String? selectedDaysText,
      int? snoozeDuration,
      String? label});
}

/// @nodoc
class _$CreateNewAlarmStateCopyWithImpl<$Res, $Val extends CreateNewAlarmState>
    implements $CreateNewAlarmStateCopyWith<$Res> {
  _$CreateNewAlarmStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTime = null,
    Object? type = null,
    Object? soundPath = null,
    Object? isVibrate = null,
    Object? daysOfWeek = null,
    Object? selectedDaysText = freezed,
    Object? snoozeDuration = freezed,
    Object? label = freezed,
  }) {
    return _then(_value.copyWith(
      selectedTime: null == selectedTime
          ? _value.selectedTime
          : selectedTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AlarmType,
      soundPath: null == soundPath
          ? _value.soundPath
          : soundPath // ignore: cast_nullable_to_non_nullable
              as String,
      isVibrate: null == isVibrate
          ? _value.isVibrate
          : isVibrate // ignore: cast_nullable_to_non_nullable
              as bool,
      daysOfWeek: null == daysOfWeek
          ? _value.daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as List<Weekday>,
      selectedDaysText: freezed == selectedDaysText
          ? _value.selectedDaysText
          : selectedDaysText // ignore: cast_nullable_to_non_nullable
              as String?,
      snoozeDuration: freezed == snoozeDuration
          ? _value.snoozeDuration
          : snoozeDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateNewAlarmStateImplCopyWith<$Res>
    implements $CreateNewAlarmStateCopyWith<$Res> {
  factory _$$CreateNewAlarmStateImplCopyWith(_$CreateNewAlarmStateImpl value,
          $Res Function(_$CreateNewAlarmStateImpl) then) =
      __$$CreateNewAlarmStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<DateTime> selectedTime,
      AlarmType type,
      String soundPath,
      bool isVibrate,
      List<Weekday> daysOfWeek,
      String? selectedDaysText,
      int? snoozeDuration,
      String? label});
}

/// @nodoc
class __$$CreateNewAlarmStateImplCopyWithImpl<$Res>
    extends _$CreateNewAlarmStateCopyWithImpl<$Res, _$CreateNewAlarmStateImpl>
    implements _$$CreateNewAlarmStateImplCopyWith<$Res> {
  __$$CreateNewAlarmStateImplCopyWithImpl(_$CreateNewAlarmStateImpl _value,
      $Res Function(_$CreateNewAlarmStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTime = null,
    Object? type = null,
    Object? soundPath = null,
    Object? isVibrate = null,
    Object? daysOfWeek = null,
    Object? selectedDaysText = freezed,
    Object? snoozeDuration = freezed,
    Object? label = freezed,
  }) {
    return _then(_$CreateNewAlarmStateImpl(
      selectedTime: null == selectedTime
          ? _value._selectedTime
          : selectedTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AlarmType,
      soundPath: null == soundPath
          ? _value.soundPath
          : soundPath // ignore: cast_nullable_to_non_nullable
              as String,
      isVibrate: null == isVibrate
          ? _value.isVibrate
          : isVibrate // ignore: cast_nullable_to_non_nullable
              as bool,
      daysOfWeek: null == daysOfWeek
          ? _value._daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as List<Weekday>,
      selectedDaysText: freezed == selectedDaysText
          ? _value.selectedDaysText
          : selectedDaysText // ignore: cast_nullable_to_non_nullable
              as String?,
      snoozeDuration: freezed == snoozeDuration
          ? _value.snoozeDuration
          : snoozeDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CreateNewAlarmStateImpl implements _CreateNewAlarmState {
  _$CreateNewAlarmStateImpl(
      {required final List<DateTime> selectedTime,
      required this.type,
      required this.soundPath,
      required this.isVibrate,
      required final List<Weekday> daysOfWeek,
      this.selectedDaysText,
      this.snoozeDuration,
      this.label})
      : _selectedTime = selectedTime,
        _daysOfWeek = daysOfWeek;

  final List<DateTime> _selectedTime;
  @override
  List<DateTime> get selectedTime {
    if (_selectedTime is EqualUnmodifiableListView) return _selectedTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedTime);
  }

  @override
  final AlarmType type;
  @override
  final String soundPath;
  @override
  final bool isVibrate;
  final List<Weekday> _daysOfWeek;
  @override
  List<Weekday> get daysOfWeek {
    if (_daysOfWeek is EqualUnmodifiableListView) return _daysOfWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daysOfWeek);
  }

  @override
  final String? selectedDaysText;
  @override
  final int? snoozeDuration;
  @override
  final String? label;

  @override
  String toString() {
    return 'CreateNewAlarmState(selectedTime: $selectedTime, type: $type, soundPath: $soundPath, isVibrate: $isVibrate, daysOfWeek: $daysOfWeek, selectedDaysText: $selectedDaysText, snoozeDuration: $snoozeDuration, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateNewAlarmStateImpl &&
            const DeepCollectionEquality()
                .equals(other._selectedTime, _selectedTime) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.soundPath, soundPath) ||
                other.soundPath == soundPath) &&
            (identical(other.isVibrate, isVibrate) ||
                other.isVibrate == isVibrate) &&
            const DeepCollectionEquality()
                .equals(other._daysOfWeek, _daysOfWeek) &&
            (identical(other.selectedDaysText, selectedDaysText) ||
                other.selectedDaysText == selectedDaysText) &&
            (identical(other.snoozeDuration, snoozeDuration) ||
                other.snoozeDuration == snoozeDuration) &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_selectedTime),
      type,
      soundPath,
      isVibrate,
      const DeepCollectionEquality().hash(_daysOfWeek),
      selectedDaysText,
      snoozeDuration,
      label);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateNewAlarmStateImplCopyWith<_$CreateNewAlarmStateImpl> get copyWith =>
      __$$CreateNewAlarmStateImplCopyWithImpl<_$CreateNewAlarmStateImpl>(
          this, _$identity);
}

abstract class _CreateNewAlarmState implements CreateNewAlarmState {
  factory _CreateNewAlarmState(
      {required final List<DateTime> selectedTime,
      required final AlarmType type,
      required final String soundPath,
      required final bool isVibrate,
      required final List<Weekday> daysOfWeek,
      final String? selectedDaysText,
      final int? snoozeDuration,
      final String? label}) = _$CreateNewAlarmStateImpl;

  @override
  List<DateTime> get selectedTime;
  @override
  AlarmType get type;
  @override
  String get soundPath;
  @override
  bool get isVibrate;
  @override
  List<Weekday> get daysOfWeek;
  @override
  String? get selectedDaysText;
  @override
  int? get snoozeDuration;
  @override
  String? get label;
  @override
  @JsonKey(ignore: true)
  _$$CreateNewAlarmStateImplCopyWith<_$CreateNewAlarmStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

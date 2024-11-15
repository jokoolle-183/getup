// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AlarmListState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<AlarmItem> get alarmItems => throw _privateConstructorUsedError;

  /// Create a copy of AlarmListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlarmListStateCopyWith<AlarmListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmListStateCopyWith<$Res> {
  factory $AlarmListStateCopyWith(
          AlarmListState value, $Res Function(AlarmListState) then) =
      _$AlarmListStateCopyWithImpl<$Res, AlarmListState>;
  @useResult
  $Res call({bool isLoading, List<AlarmItem> alarmItems});
}

/// @nodoc
class _$AlarmListStateCopyWithImpl<$Res, $Val extends AlarmListState>
    implements $AlarmListStateCopyWith<$Res> {
  _$AlarmListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlarmListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? alarmItems = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      alarmItems: null == alarmItems
          ? _value.alarmItems
          : alarmItems // ignore: cast_nullable_to_non_nullable
              as List<AlarmItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmListStateImplCopyWith<$Res>
    implements $AlarmListStateCopyWith<$Res> {
  factory _$$AlarmListStateImplCopyWith(_$AlarmListStateImpl value,
          $Res Function(_$AlarmListStateImpl) then) =
      __$$AlarmListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<AlarmItem> alarmItems});
}

/// @nodoc
class __$$AlarmListStateImplCopyWithImpl<$Res>
    extends _$AlarmListStateCopyWithImpl<$Res, _$AlarmListStateImpl>
    implements _$$AlarmListStateImplCopyWith<$Res> {
  __$$AlarmListStateImplCopyWithImpl(
      _$AlarmListStateImpl _value, $Res Function(_$AlarmListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlarmListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? alarmItems = null,
  }) {
    return _then(_$AlarmListStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      alarmItems: null == alarmItems
          ? _value._alarmItems
          : alarmItems // ignore: cast_nullable_to_non_nullable
              as List<AlarmItem>,
    ));
  }
}

/// @nodoc

class _$AlarmListStateImpl implements _AlarmListState {
  _$AlarmListStateImpl(
      {required this.isLoading, required final List<AlarmItem> alarmItems})
      : _alarmItems = alarmItems;

  @override
  final bool isLoading;
  final List<AlarmItem> _alarmItems;
  @override
  List<AlarmItem> get alarmItems {
    if (_alarmItems is EqualUnmodifiableListView) return _alarmItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alarmItems);
  }

  @override
  String toString() {
    return 'AlarmListState(isLoading: $isLoading, alarmItems: $alarmItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmListStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._alarmItems, _alarmItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_alarmItems));

  /// Create a copy of AlarmListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmListStateImplCopyWith<_$AlarmListStateImpl> get copyWith =>
      __$$AlarmListStateImplCopyWithImpl<_$AlarmListStateImpl>(
          this, _$identity);
}

abstract class _AlarmListState implements AlarmListState {
  factory _AlarmListState(
      {required final bool isLoading,
      required final List<AlarmItem> alarmItems}) = _$AlarmListStateImpl;

  @override
  bool get isLoading;
  @override
  List<AlarmItem> get alarmItems;

  /// Create a copy of AlarmListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlarmListStateImplCopyWith<_$AlarmListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

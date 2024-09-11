import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walk_it_up/alarm_list/alarm_item.dart';

part 'alarm_list_state.freezed.dart';

@freezed
class AlarmListState with _$AlarmListState {
  factory AlarmListState({
    required bool isLoading,
    required List<AlarmItem> alarmItems,
  }) = _AlarmListState;

  factory AlarmListState.initial() =>
      AlarmListState(isLoading: true, alarmItems: List.empty());
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_picker_state.freezed.dart';

@freezed
class TimePickerState with _$TimePickerState {
  factory TimePickerState({
    String? baseTime,
    String? endTime,
    int? baseTimeHoursIndex,
    int? baseTimeMinutesIndex,
    int? endTimeHoursIndex,
    int? endTimeMinutesIndex,
  }) = _TimePickerState;

  factory TimePickerState.initial({String? time, String? endTime}) {
    return TimePickerState(
      baseTime: time,
      endTime: endTime,
    );
  }
}

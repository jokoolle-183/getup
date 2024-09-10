import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pedometer/pedometer.dart';

part 'ring_alarm_state.freezed.dart';

@freezed
class RingAlarmState with _$RingAlarmState {
  factory RingAlarmState({
    required int steps,
    required String status,
    required bool completed,
  }) = _RingAlarmState;

  factory RingAlarmState.initial() => RingAlarmState(
        steps: 0,
        status: 'unknown',
        completed: false,
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:walk_it_up/data/model/weekdays.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/alarm_type/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';

part 'create_new_alarm_state.freezed.dart';

@freezed
class CreateNewAlarmState with _$CreateNewAlarmState {
  factory CreateNewAlarmState({
    required Pair<String, String> selectedTime,
    required AlarmType type,
    required String soundPath,
    required bool isVibrate,
    required List<Weekday> daysOfWeek,
    required int snoozeDuration,
    required bool isSnoozeEnabled,
    int? intervalBetweenAlarms,
    String? selectedDaysText,
    String? label,
  }) = _CreateNewAlarmState;

  factory CreateNewAlarmState.initial() {
    return CreateNewAlarmState(
      selectedTime: Pair(DateFormat('HH:mm').format(DateTime.now()), ''),
      type: AlarmType.regular,
      soundPath: 'assets/perfect_alarm.mp3',
      snoozeDuration: 5,
      isSnoozeEnabled: true,
      isVibrate: false,
      daysOfWeek: [],
    );
  }
}

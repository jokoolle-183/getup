import 'package:freezed_annotation/freezed_annotation.dart';
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
    String? selectedDaysText,
    int? snoozeDuration,
    String? label,
  }) = _CreateNewAlarmState;

  factory CreateNewAlarmState.initial() {
    final now = DateTime.now();

    return CreateNewAlarmState(
      selectedTime: Pair('', ''),
      type: AlarmType.regular,
      soundPath: '',
      isVibrate: false,
      daysOfWeek: [],
    );
  }
}

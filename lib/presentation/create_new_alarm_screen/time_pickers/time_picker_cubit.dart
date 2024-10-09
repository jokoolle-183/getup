import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/time_picker_state.dart';

class TimePickerCubit extends Cubit<TimePickerState> {
  TimePickerCubit() : super(TimePickerState.initial());

  void onTimeSelected(String time, Pair<int, int> hoursMinutes) {
    emit(state.copyWith(
      baseTime: time,
      baseTimeHoursIndex: hoursMinutes.left,
      baseTimeMinutesIndex: hoursMinutes.right,
    ));
  }

  void onEndTimeSelected(String endTime, Pair<int, int> hoursMinutes) {
    emit(state.copyWith(
      endTime: endTime,
      endTimeHoursIndex: hoursMinutes.left,
      endTimeMinutesIndex: hoursMinutes.right,
    ));
  }
}

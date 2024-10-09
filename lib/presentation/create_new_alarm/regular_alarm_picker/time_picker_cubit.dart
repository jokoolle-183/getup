import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/presentation/create_new_alarm/pair.dart';
import 'package:walk_it_up/presentation/create_new_alarm/regular_alarm_picker/time_picker_state.dart';

class TimePickerCubit extends Cubit<TimePickerState> {
  TimePickerCubit() : super(TimePickerState.initial());

  void onTimeSelected(String time, Pair<int, int> hoursMinutes) {
    print('Selected time: $time');
    emit(state.copyWith(
      baseTime: time,
      baseTimeHoursIndex: hoursMinutes.left,
      baseTimeMinutesIndex: hoursMinutes.right,
    ));
  }

  void onEndTimeSelected(String endTime, Pair<int, int> hoursMinutes) {
    print('Selected time: $endTime');
    emit(state.copyWith(
      endTime: endTime,
      endTimeHoursIndex: hoursMinutes.left,
      endTimeMinutesIndex: hoursMinutes.right,
    ));
  }
}

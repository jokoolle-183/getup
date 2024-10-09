import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/domain/time_store.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/time_pickers/time_picker_state.dart';

class TimePickerCubit extends Cubit<TimePickerState> {
  TimePickerCubit(this.timeStore) : super(TimePickerState.initial());

  final TimeStore timeStore;

  void onTimeSelected(String time, Pair<int, int> hoursMinutes) {
    timeStore.onTimeSelected(time);
    emit(state.copyWith(
      baseTime: time,
      baseTimeHoursIndex: hoursMinutes.left,
      baseTimeMinutesIndex: hoursMinutes.right,
    ));
  }

  void onEndTimeSelected(String endTime, Pair<int, int> hoursMinutes) {
    timeStore.onEndTimeSelected(endTime);
    emit(state.copyWith(
      endTime: endTime,
      endTimeHoursIndex: hoursMinutes.left,
      endTimeMinutesIndex: hoursMinutes.right,
    ));
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/data/model/weekdays.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';
import 'package:walk_it_up/domain/alarm_scheduler.dart';
import 'package:walk_it_up/domain/calculation_args.dart';
import 'package:walk_it_up/domain/time_selection_handler.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/alarm_type/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/create_new_alarm/create_new_alarm_state.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';

class CreateNewAlarmCubit extends Cubit<CreateNewAlarmState> {
  CreateNewAlarmCubit({
    required this.timeStore,
    required this.alarmSetRepository,
    required this.alarmScheduler,
  }) : super(CreateNewAlarmState.initial()) {
    _timeSubscription = timeStore.timeStream.listen((timePair) {
      emit(state.copyWith(
          selectedTime: timePair)); // Update the Cubit state with the new time
    });
  }

  final AlarmSetRepository alarmSetRepository;
  final TimeSelectionHandler timeStore;
  final AlarmScheduler alarmScheduler;
  late StreamSubscription<Pair<String, String>> _timeSubscription;

  void onTypeChanged(AlarmType selectedType) {
    emit(state.copyWith(type: selectedType));
  }

  void onSnoozeSettingsChanged(Pair<bool, int> snoozeSettings) {
    emit(state.copyWith(
      isSnoozeEnabled: snoozeSettings.left,
      snoozeDuration: snoozeSettings.right,
    ));
  }

  void onDaySelected(Weekday weekday) {
    final daysOfWeek = state.daysOfWeek;
    final newList = List<Weekday>.from(daysOfWeek);
    if (daysOfWeek.contains(weekday)) {
      newList.remove(weekday);
    } else {
      newList.add(weekday);
    }

    newList.sort((a, b) => a.index.compareTo(b.index));
    emit(state.copyWith(daysOfWeek: newList));
  }

  Future<void> scheduleAlarm() async {
    if (state.type == AlarmType.regular) {
      final selectedDateTime = convertStringToDate(state.selectedTime.left);

      final args = AlarmConfig(
        selectedTime: selectedDateTime,
        daysOfWeek: state.daysOfWeek,
        soundPath: state.soundPath,
        snoozeDuration: state.snoozeDuration,
        isVibrate: state.isVibrate,
      );
      await alarmScheduler.scheduleRegularAlarm(args);

      print('Alarm date: $selectedDateTime');
    } else {}
  }

  @override
  Future<void> close() {
    // Cancel the subscription when the Cubit is closed
    _timeSubscription.cancel();
    return super.close();
  }

  DateTime convertStringToDate(String selectedTime) {
    // Determine if selected time is before now or after
    print("Convert string to date, selectedTime: $selectedTime");
    final now = DateTime.now();
    final hoursAndMinutes = selectedTime.split(':');
    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(hoursAndMinutes[0]),
      int.parse(hoursAndMinutes[1]),
    );

    return selectedDateTime;
  }

  void onVibrateChanged(bool value) {
    emit(state.copyWith(isVibrate: value));
  }
}

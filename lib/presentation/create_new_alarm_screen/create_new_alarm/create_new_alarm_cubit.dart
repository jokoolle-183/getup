import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';
import 'package:walk_it_up/data/model/regular_alarm_model.dart';
import 'package:walk_it_up/data/model/weekdays.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';
import 'package:walk_it_up/domain/time_store.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/alarm_type/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/create_new_alarm/create_new_alarm_state.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';

class CreateNewAlarmCubit extends Cubit<CreateNewAlarmState> {
  CreateNewAlarmCubit({
    required this.timeStore,
    required this.alarmSetRepository,
    required this.regularAlarmRepository,
  }) : super(CreateNewAlarmState.initial()) {
    _timeSubscription = timeStore.timeStream.listen((timePair) {
      emit(state.copyWith(
          selectedTime: timePair)); // Update the Cubit state with the new time
    });
  }

  final AlarmSetRepository alarmSetRepository;
  final RegularAlarmRepository regularAlarmRepository;
  final TimeStore timeStore;
  late StreamSubscription<Pair<String, String>> _timeSubscription;

  void onTypeChanged(AlarmType selectedType) {
    emit(state.copyWith(type: selectedType));
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

  Future<void> setAlarm() async {
    if (state.type == AlarmType.regular) {
      final now = DateTime.now();
      DateTime selectedTime = convertStringToDate(state.selectedTime.left);

      if (selectedTime.isBefore(now)) {
        selectedTime = selectedTime.copyWith(day: selectedTime.day + 1);
      }

      final alarmId = await regularAlarmRepository.saveAlarm(
        RegularAlarmModel(
          time: selectedTime,
          audioPath: 'assets/perfect_alarm.mp3',
        ),
      );

      Alarm.set(
          alarmSettings: AlarmSettings(
              id: alarmId,
              dateTime: selectedTime,
              assetAudioPath: 'assets/perfect_alarm.mp3',
              notificationTitle: 'Get up',
              notificationBody: 'Walk it up! '));
    } else {}
  }

  @override
  Future<void> close() {
    _timeSubscription
        .cancel(); // Cancel the subscription when the Cubit is closed
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
}

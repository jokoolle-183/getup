import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Future<void> close() {
    _timeSubscription
        .cancel(); // Cancel the subscription when the Cubit is closed
    return super.close();
  }
}

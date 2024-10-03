import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';
import 'package:walk_it_up/presentation/create_new_alarm/alarm_type.dart';
import 'package:walk_it_up/presentation/create_new_alarm/create_new_alarm_state.dart';

class CreateNewAlarmCubit extends Cubit<CreateNewAlarmState> {
  CreateNewAlarmCubit({
    required this.alarmSetRepository,
    required this.regularAlarmRepository,
  }) : super(CreateNewAlarmState.initial());

  final AlarmSetRepository alarmSetRepository;
  final RegularAlarmRepository regularAlarmRepository;

  void onTypeChanged(AlarmType selectedType) {
    emit(state.copyWith(type: selectedType));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_item.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_list_state.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';

class AlarmListCubit extends Cubit<AlarmListState> {
  final AlarmSetRepository _alarmSetRepository;
  final RegularAlarmRepository _regularAlarmRepository;

  AlarmListCubit(
    this._alarmSetRepository,
    this._regularAlarmRepository,
  ) : super(AlarmListState.initial()) {
    _loadAlarms();
  }

  void _loadAlarms() async {
    final alarms = await _regularAlarmRepository.getRegularAlarms();

    final alarmItemList = alarms
        .map(
          (alarm) => AlarmItem(
            id: alarm.id,
            time: DateFormat('HH:mm').format(alarm.time),
            type: AlarmType.regular,
          ),
        )
        .toList();
    emit(state.copyWith(alarmItems: alarmItemList, isLoading: false));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_item.dart';
import 'package:walk_it_up/presentation/alarm_list/alarm_list_state.dart';
import 'package:walk_it_up/data/repository/alarm_repository.dart';

class AlarmListCubit extends Cubit<AlarmListState> {
  final AlarmRepository _alarmRepository;

  AlarmListCubit(this._alarmRepository) : super(AlarmListState.initial()) {
    _loadAlarms();
  }

  void _loadAlarms() async {
    final alarms = await _alarmRepository.getAlarms();

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

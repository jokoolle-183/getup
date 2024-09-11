import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:intl/intl.dart';
import 'package:walk_it_up/alarm_list/alarm_item.dart';
import 'package:walk_it_up/alarm_list/alarm_list_state.dart';
import 'package:walk_it_up/database/alarm_database.dart';

class AlarmListCubit extends Cubit<AlarmListState> {
  final AlarmDatabase _db = GetIt.instance<AlarmDatabase>();
  AlarmListCubit() : super(AlarmListState.initial()) {
    _loadAlarms();
  }

  void _loadAlarms() async {
    final alarms = await _db.allAlarms;

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

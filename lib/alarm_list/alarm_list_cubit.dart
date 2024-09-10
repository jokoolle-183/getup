import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getup/alarm_list/alarm_item.dart';
import 'package:getup/alarm_list/alarm_list_state.dart';
import 'package:getup/constants.dart';
import 'package:getup/ring_alarm/ring_alarm_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmListCubit extends Cubit<AlarmListState> {
  AlarmListCubit() : super(AlarmListState.initial()) {
    _loadAlarms();
  }

  void _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();

    final alarmsJson = prefs.getString(ALARMS);
    if (alarmsJson != null) {
      final alarmsDetailsList = decodeAlarmDetailsList(alarmsJson);
      final alarmItemList = alarmsDetailsList
          .map(
            (details) => AlarmItem(
              id: details.id,
              time: DateFormat('HH:mm').format(details.dateTime),
              type: AlarmType.dailyRecurring,
            ),
          )
          .toList();
      emit(state.copyWith(alarmItems: alarmItemList, isLoading: false));
    } else {
      emit(state.copyWith(alarmItems: List.empty(), isLoading: false));
    }
  }
}

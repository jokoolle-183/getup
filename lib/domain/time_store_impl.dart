import 'dart:async';

import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:walk_it_up/domain/time_selection_handler.dart';
import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';

class TimeSelectionHandlerImpl extends TimeSelectionHandler {
  final BehaviorSubject<Pair<String, String>> _timeSubject =
      BehaviorSubject<Pair<String, String>>.seeded(
          Pair(DateFormat('HH:mm').format(DateTime.now()), ''));

  @override
  void onEndTimeSelected(String endTime) {
    _timeSubject.add(currentTimePair.copyWith(right: endTime));
  }

  @override
  void onTimeSelected(String time) {
    _timeSubject.add(currentTimePair.copyWith(left: time));
  }

  @override
  void dispose() {
    _timeSubject.close();
  }

  Pair<String, String> get currentTimePair => _timeSubject.value;

  @override
  Stream<Pair<String, String>> get timeStream => _timeSubject.stream;
}

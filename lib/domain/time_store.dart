import 'package:walk_it_up/presentation/create_new_alarm_screen/pair.dart';

abstract class TimeStore {
  Stream<Pair<String, String>> get timeStream;
  void onTimeSelected(String time);
  void onEndTimeSelected(String endTime);
  void dispose();
}

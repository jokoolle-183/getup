import 'package:walk_it_up/utils/pair.dart';

abstract class TimeSelectionHandler {
  Stream<Pair<String, String>> get timeStream;
  void onTimeSelected(String time);
  void onEndTimeSelected(String endTime);
  void dispose();
}

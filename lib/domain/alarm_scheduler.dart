import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:walk_it_up/data/model/alarm_args.dart';
import 'package:walk_it_up/data/model/weekdays.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';
import 'package:walk_it_up/domain/calculation_args.dart';

class AlarmScheduler {
  RegularAlarmRepository _regularAlarmRepository;
  AlarmScheduler(this._regularAlarmRepository);

  Future<DateTime?> scheduleRegularAlarm(CalculationArgs args) async {
    final alarmDate = calculateDateTime(args);
    final scheduleSuccess = scheduleAlarm(alarmDate);
    return Future.value(alarmDate);
  }

  Future<DateTime?> scheduleNextRegularAlarm(CalculationArgs args) async {
    // It's a repeating alarm with designated weekdays
    if (args.daysOfWeek.isNotEmpty) {
      final nextDate = calculateDateTime(args);
      final scheduleSuccess = scheduleAlarm(nextDate);
      return Future.value(nextDate);
    }
    return Future.value(null);
  }

  Future<bool> scheduleAlarm(DateTime? alarmDate) async {
    if (alarmDate != null) {
      final alarmArgs = AlarmArgs(
          time: alarmDate,
          audioPath: 'assets/perfect_alarm.mp3',
          enabled: true);

      final alarmId = await _regularAlarmRepository.saveAlarm(alarmArgs);

      return await Alarm.set(
        alarmSettings: AlarmSettings(
          id: alarmId,
          dateTime: alarmDate,
          assetAudioPath: 'assets/perfect_alarm.mp3',
          notificationTitle: 'Get up',
          notificationBody: 'Walk it up! ',
        ),
      );
    }
    return Future.value(false);
  }

  DateTime? calculateDateTime(CalculationArgs args) {
    DateTime? selectedDateTime = convertStringToDate(args.selectedTime);
    final DateTime now = DateTime.now();

    if (selectedDateTime != null) {
      // If weekdays are not empty, schedule alarm for the correct day
      if (args.daysOfWeek.isNotEmpty) {
        final int today = Weekday.today(now.weekday).position;
        final nextDay = getNextScheduledDay(today, args.daysOfWeek);

        // Calculate the difference in days to the next scheduled day
        int daysToAdd = (nextDay - today + 7) % 7;
        if (daysToAdd == 0 && selectedDateTime.hour <= now.hour) {
          daysToAdd = 7;
        }

        selectedDateTime =
            selectedDateTime.copyWith(day: selectedDateTime.day + daysToAdd);
      } else {
        // No day selected, schdule alarm for today or tomorrow
        // If the selected hour is less than current hour, calculate tomorrow
        if (selectedDateTime.hour < now.hour) {
          selectedDateTime =
              selectedDateTime.copyWith(day: selectedDateTime.day + 1);
        }
      }
    }
    return selectedDateTime;
  }

  int getNextScheduledDay(int currentDay, List<Weekday> enabledDays) {
    // Sort enabled days by their corresponding int values for easy traversal
    final tmp = List.from(enabledDays);
    final sortedEnabledDays = tmp
      ..sort((a, b) => a.position.compareTo(b.position));

    // Find the first enabled day that is greater than the current day
    final nextDay = sortedEnabledDays.firstWhere(
      (day) => day.position > currentDay,
      orElse: () => sortedEnabledDays.first,
    );

    return nextDay.position;
  }

  DateTime? convertStringToDate(String selectedTime) {
    if (selectedTime.isNotEmpty) {
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
    return null;
  }
}

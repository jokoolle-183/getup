import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:walk_it_up/data/model/alarm_args.dart';
import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';
import 'package:walk_it_up/data/model/weekdays.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';
import 'package:walk_it_up/domain/calculation_args.dart';

class AlarmScheduler {
  final RegularAlarmRepository _regularAlarmRepository;
  AlarmScheduler(this._regularAlarmRepository);

  Future<DateTime?> scheduleRegularAlarm(AlarmConfig config) async {
    final alarmDate = _calculateDateTime(
      config.daysOfWeek,
      config.selectedTime,
    );
    final scheduleSuccess =
        await _scheduleAlarm(config.copyWith(selectedTime: alarmDate));
    return Future.value(alarmDate);
  }

  Future<bool> scheduleNextRegularAlarm(AlarmSettings settings) async {
    final currentAlarm =
        await _regularAlarmRepository.getAlarmByInstanceId(settings.id);

    if (currentAlarm != null && currentAlarm.daysOfWeek?.isNotEmpty == true) {
      final nextDate = _calculateDateTime(
        currentAlarm.daysOfWeek ?? [],
        settings.dateTime,
      );

      final scheduleSuccess = _scheduleNextAlarm(
        currentAlarm,
        nextDate,
      );

      return Future.value(scheduleSuccess);
    }
    return Future.value(false);
  }

  Future<bool> _scheduleAlarm(AlarmConfig config) async {
    if (config.selectedTime != null) {
      final alarmArgs = AlarmArgs(
        time: config.selectedTime!,
        audioPath: config.soundPath,
        enabled: true,
        daysOfWeek: config.daysOfWeek,
      );

      final alarmId = await _regularAlarmRepository.saveAlarm(alarmArgs);

      return await Alarm.set(
        alarmSettings: AlarmSettings(
          id: alarmId,
          dateTime: config.selectedTime!,
          assetAudioPath: config.soundPath,
          notificationTitle: 'Get up',
          notificationBody: 'Walk it up! ',
        ),
      );
    }
    return Future.value(false);
  }

  Future<bool> _scheduleNextAlarm(
    DbAlarmDto alarm,
    DateTime? alarmDate,
  ) async {
    if (alarmDate != null) {
      final id = await _regularAlarmRepository.updateAlarmInstance(
        alarm.id,
        alarm.alarmInstance.id,
        alarmDate,
      );

      return await Alarm.set(
        alarmSettings: AlarmSettings(
          id: id,
          dateTime: alarmDate,
          assetAudioPath: alarm.audioPath,
          notificationTitle: 'Get up',
          notificationBody: 'Walk it up! ',
        ),
      );
    }
    return Future.value(false);
  }

  DateTime? _calculateDateTime(
    List<Weekday> daysOfWeek,
    DateTime? selectedTime,
  ) {
    DateTime? selectedDateTime = selectedTime;
    final DateTime now = DateTime.now();

    if (selectedDateTime != null) {
      // If weekdays are not empty, schedule alarm for the correct day
      if (daysOfWeek.isNotEmpty) {
        final int today = Weekday.today(now.weekday).position;

        // Check if today is included in the scheduled days
        final isTodayScheduled = daysOfWeek.any((day) => day.position == today);

        // Check if the selected time is later today
        final isTimeInFuture = selectedDateTime.hour > now.hour ||
            (selectedDateTime.hour == now.hour &&
                selectedDateTime.minute > now.minute);

        if (isTodayScheduled && isTimeInFuture) {
          // If today is a scheduled day and the time is in the future, set for today
          return selectedDateTime;
        } else {
          // Otherwise, find the next scheduled day
          final nextDay = _getNextScheduledDay(today, daysOfWeek);

          // Calculate the difference in days to the next scheduled day
          int daysToAdd = (nextDay - today + 7) % 7;

          // Set the selected date to the calculated next day
          selectedDateTime = selectedDateTime.add(Duration(days: daysToAdd));
        }
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

  int _getNextScheduledDay(int currentDay, List<Weekday> enabledDays) {
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

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:collection/collection.dart';
import 'package:walk_it_up/data/model/alarm_args.dart';
import 'package:walk_it_up/data/model/alarm_set_args.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_dto.dart';
import 'package:walk_it_up/data/model/dto/alarm_instance_set_dto.dart';
import 'package:walk_it_up/data/model/dto/db_alarm_dto.dart';
import 'package:walk_it_up/data/model/weekdays.dart';
import 'package:walk_it_up/data/repository/alarm_set_repository.dart';
import 'package:walk_it_up/data/repository/regular_alarm_repository.dart';
import 'package:walk_it_up/domain/alarm_set_config.dart';
import 'package:walk_it_up/domain/calculation_args.dart';
import 'package:walk_it_up/utils/pair.dart';

class AlarmScheduler {
  final RegularAlarmRepository _regularAlarmRepository;
  final AlarmSetRepository _alarmSetRepository;
  AlarmScheduler(this._regularAlarmRepository, this._alarmSetRepository);

  Future<DateTime?> scheduleRegularAlarm(AlarmConfig config) async {
    final alarmDate = _calculateDateTime(
      config.daysOfWeek,
      config.selectedTime,
    );
    await _scheduleNewAlarm(config.copyWith(selectedTime: alarmDate));
    return Future.value(alarmDate);
  }

  Future<DateTime?> scheduleRecurringAlarm(AlarmSetConfig config) async {
    final startAlarmDate = _calculateDateTime(
      config.daysOfWeek,
      config.selectedStartTime,
    );

    final endAlarmDate = _calculateEndDateTime(
      startAlarmDate,
      config.selectedEndTime,
    );

    await _scheduleNewAlarmForSet(
      config.copyWith(
        selectedTime: startAlarmDate,
        selectedEndTime: endAlarmDate,
      ),
    );
    return Future.value(startAlarmDate);
  }

  Future<bool> _scheduleNewAlarm(AlarmConfig config) async {
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

  Future<Pair<DateTime?, bool>> scheduleNextAlarm(AlarmSettings settings) async {
    final currentlyFiredInstance = await _regularAlarmRepository.getAlarmInstanceById(settings.id);

    if (currentlyFiredInstance != null) {
      /// This alarm instance belongs to a regular alarm, so just schedule the next alarm instance using alarm options
      if (currentlyFiredInstance.alarmId != null) {
        final currentAlarm = await _regularAlarmRepository.getAlarmByInstanceId(settings.id);

        if (currentAlarm != null && currentAlarm.daysOfWeek?.isNotEmpty == true) {
          final nextDate = _calculateDateTime(
            currentAlarm.daysOfWeek ?? [],
            settings.dateTime,
          );

          final scheduleSuccess = _scheduleNextAlarmInstance(
            currentAlarm,
            nextDate,
          );

          return Future.value(scheduleSuccess);
        }
      }

      /// This alarm instance belongs to an alarm set, scheduling the next alarm instance from the instance set
      if (currentlyFiredInstance.alarmInstanceSetId != null) {
        final currentAlarmSet =
            await _alarmSetRepository.getAlarmInstanceSetById(currentlyFiredInstance.alarmInstanceSetId!);

        if (currentAlarmSet != null) {
          final nextAlarmInstance = currentAlarmSet.recurringAlarms
              .firstWhereOrNull((AlarmInstanceDto instance) => instance.time.isAfter(settings.dateTime));

          /// If it's an alarm instance from today's session, then just set the alarm for the next instance
          /// Otherwise if the last alarm instance was fired for today, update all instances of the set
          /// with corresponding dates and set the next day's first upcoming alarm.
          if (nextAlarmInstance == null) {
            if (currentAlarmSet.daysOfWeek?.isNotEmpty == true) {
              /// Last alarm from the set for today's session and there are more days of the week scheduled.
              /// Update all upcoming alarms and schedule the first upcoming alarm.
              final updatedAlarmInstances = currentAlarmSet.recurringAlarms.map((instance) {
                return instance.copyWith(
                  time: _calculateDateTime(currentAlarmSet.daysOfWeek ?? [], instance.time),
                );
              }).toList();

              final updatedAlarmInstanceSet = currentAlarmSet.copyWith(
                recurringAlarms: updatedAlarmInstances,
              );

              await _alarmSetRepository.updateAlarmSet(updatedAlarmInstanceSet);
              return _scheduleNextAlarmInstanceForAlarmSet(alarmInstanceSet: updatedAlarmInstanceSet);
            }
          } else {
            /// Not the last alarm from the set for today.
            /// Set the next upcoming alarm instance.
            return _scheduleNextAlarmInstanceForAlarmSet(
              alarmInstanceSet: currentAlarmSet,
              alarmInstance: nextAlarmInstance,
            );
          }
        }
      }
    }

    return Future.value(Pair(null, false));
  }

  Future<Pair<DateTime?, bool>> _scheduleNextAlarmInstanceForAlarmSet({
    required AlarmInstanceSetDto alarmInstanceSet,
    AlarmInstanceDto? alarmInstance,
  }) async {
    if (alarmInstance != null) {
      /// Schedule next alarm in today's alarm set session
      final result = await Alarm.set(
        alarmSettings: AlarmSettings(
          id: alarmInstance.id,
          dateTime: alarmInstance.time,
          assetAudioPath: alarmInstanceSet.audioPath,
          notificationTitle: 'Get up',
          notificationBody: 'Walk it up! ',
        ),
      );

      return Future.value(Pair(alarmInstance.time, result));
    } else {
      /// Schedule the first upcoming alarm in the next day's alarm set session
      final firstUpcomingAlarmInstance = alarmInstanceSet.recurringAlarms.firstOrNull;

      if (firstUpcomingAlarmInstance != null) {
        final result = await Alarm.set(
          alarmSettings: AlarmSettings(
            id: firstUpcomingAlarmInstance.id,
            dateTime: firstUpcomingAlarmInstance.time,
            assetAudioPath: alarmInstanceSet.audioPath,
            notificationTitle: 'Get up',
            notificationBody: 'Walk it up! ',
          ),
        );

        return Future.value(Pair(firstUpcomingAlarmInstance.time, result));
      }
    }

    return Future.value(Pair(null, false));
  }

  Future<Pair<DateTime?, bool>> _scheduleNextAlarmInstance(
    DbAlarmDto alarm,
    DateTime? alarmDate,
  ) async {
    if (alarmDate != null) {
      final id = await _regularAlarmRepository.updateAlarmInstance(
        alarm.id,
        alarm.alarmInstance.id,
        alarmDate,
      );

      final result = await Alarm.set(
        alarmSettings: AlarmSettings(
          id: id,
          dateTime: alarmDate,
          assetAudioPath: alarm.audioPath,
          notificationTitle: 'Get up',
          notificationBody: 'Walk it up! ',
        ),
      );

      return Future.value(Pair(alarmDate, result));
    }
    return Future.value(Pair(null, false));
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
            (selectedDateTime.hour == now.hour && selectedDateTime.minute > now.minute);

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
          selectedDateTime = selectedDateTime.copyWith(day: selectedDateTime.day + 1);
        }
      }
    }
    return selectedDateTime;
  }

  int _getNextScheduledDay(int currentDay, List<Weekday> enabledDays) {
    // Sort enabled days by their corresponding int values for easy traversal
    final tmp = List.from(enabledDays);
    final sortedEnabledDays = tmp..sort((a, b) => a.position.compareTo(b.position));

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

  DateTime? _calculateEndDateTime(DateTime? calculatedStartAlarmDate, DateTime? endAlarmDate) {
    DateTime? endAlarmDateTime = endAlarmDate;
    if (calculatedStartAlarmDate != null && endAlarmDate != null) {
      if (calculatedStartAlarmDate.day > endAlarmDate.day) {
        // Calculated start date is tomorrow
        endAlarmDateTime = endAlarmDateTime!.add(const Duration(days: 1));
      } else if (calculatedStartAlarmDate.day == endAlarmDate.day) {
        // If they're on the same day, we need to calculate following scenarios:
        // 1. If the start date is greater than or equal to the end date -> end date is tomorrow
        // 2. If the start date is lesser than the end date -> end date is today
        if (calculatedStartAlarmDate.isAfter(endAlarmDateTime!) ||
            calculatedStartAlarmDate == endAlarmDateTime) {
          endAlarmDateTime = endAlarmDateTime.add(const Duration(days: 1));
        }
      }
    }
    return endAlarmDateTime;
  }

  Future<bool> _scheduleNewAlarmForSet(AlarmSetConfig config) async {
    final alarmSetArgs = AlarmSetArgs(
      startTime: config.selectedStartTime,
      endTime: config.selectedEndTime,
      intervalBetweenAlarms: config.interval,
      recurringAlarmDates: config.alarmDates,
      audioPath: config.audioPath,
      daysOfWeek: config.daysOfWeek,
      isEnabled: config.isEnabled,
    );

    final alarmId = await _alarmSetRepository.saveAlarmSet(alarmSetArgs);

    if (alarmId != null) {
      return await Alarm.set(
        alarmSettings: AlarmSettings(
          id: alarmId,
          dateTime: config.selectedStartTime,
          assetAudioPath: config.soundPath,
          notificationTitle: 'Get up',
          notificationBody: 'Walk it up! ',
        ),
      );
    }
    return Future.value(false);
  }
}

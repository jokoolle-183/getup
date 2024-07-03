import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:gap/gap.dart';
import 'package:getup/alarm_details.dart';
import 'package:getup/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class EditAlarmScreen extends StatefulWidget {
  const EditAlarmScreen({super.key});
  static const routeName = '/edit-alarm';

  @override
  State<EditAlarmScreen> createState() => _EditAlarmScreenState();
}

class _EditAlarmScreenState extends State<EditAlarmScreen> {
  late List<AlarmSettings> alarms;
  TimeOfDay selectedFromTimeToday =
      TimeOfDay.fromDateTime(DateTime.now().copyWith(hour: 9, minute: 0));
  TimeOfDay selectedToTimeToday =
      TimeOfDay.fromDateTime(DateTime.now().copyWith(hour: 17, minute: 0));

  DateTime? selectedFromTimeDate;
  DateTime? selectedToTimeDate;

  Set<FocusDuration> focusDurations = <FocusDuration>{
    FocusDuration.ten,
  };
  Set<BreakDuration> breakDurations = <BreakDuration>{
    BreakDuration.five,
  };

  @override
  void initState() {
    super.initState();
    loadAlarms();
    selectedFromTimeDate = convertTimeOfDayToDateTime(selectedFromTimeToday);
    selectedToTimeDate = convertTimeOfDayToDateTime(selectedToTimeToday);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 48.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(24.0),
              const Text('Focus duration'),
              const Gap(16.0),
              SegmentedButton<FocusDuration>(
                showSelectedIcon: false,
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -1),
                ),
                segments: [
                  for (final dur in FocusDuration.values)
                    ButtonSegment(
                      value: dur,
                      label: Text('${dur.duration} min'),
                    ),
                ],
                selected: focusDurations,
                onSelectionChanged: (Set<FocusDuration> durations) {
                  setState(() {
                    focusDurations = durations;
                  });
                },
              ),
              const Gap(24.0),
              const Text('Break duration'),
              const Gap(16.0),
              SegmentedButton<BreakDuration>(
                showSelectedIcon: false,
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity(horizontal: -1, vertical: -1),
                ),
                segments: [
                  ButtonSegment(
                      value: BreakDuration.five,
                      label: Text('${BreakDuration.five.duration} min')),
                  ButtonSegment(
                      value: BreakDuration.ten,
                      label: Text('${BreakDuration.ten.duration} min')),
                  ButtonSegment(
                      value: BreakDuration.fifteen,
                      label: Text('${BreakDuration.fifteen.duration} min')),
                ],
                selected: breakDurations,
                onSelectionChanged: (Set<BreakDuration> durations) {
                  setState(() {
                    breakDurations = durations;
                  });
                },
              ),
              const Gap(24.0),
              const Text('Time frame'),
              Row(
                children: [
                  const Text('From: '),
                  ActionChip(
                    label: Text(selectedFromTimeToday.format(context)),
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: selectedFromTimeToday,
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      setState(() {
                        if (time != null) {
                          selectedFromTimeToday = time;
                          selectedFromTimeDate =
                              convertTimeOfDayToDateTime(selectedFromTimeToday);
                        }
                      });
                    },
                  ),
                  const Text(' To: '),
                  ActionChip(
                      label: Text(selectedToTimeToday.format(context)),
                      onPressed: () async {
                        final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: selectedToTimeToday,
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        setState(() {
                          if (time != null) {
                            selectedToTimeToday = time;
                            selectedToTimeDate =
                                convertTimeOfDayToDateTime(selectedToTimeToday);
                          }
                        });
                      }),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  if (selectedFromTimeDate != null &&
                      selectedToTimeDate != null) {
                    await _saveAlarms(
                      selectedFromTimeDate!,
                      selectedToTimeDate!,
                      focusDurations.first,
                      breakDurations.first,
                    );
                    // scheduleTaskAtTime(
                    //     selectedFromTimeToday, focusDurations.first);
                    loadAlarms();
                  }
                },
                child: const Text('Set alarm'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Alarm.stopAll();
                  loadAlarms();
                },
                child: const Text('Stop all alarms'),
              ),
              for (final alarm in alarms)
                Text('Alarm ${alarm.id} at ${alarm.dateTime}')
            ],
          ),
        ),
      ),
    );
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> _saveAlarms(
    DateTime selectedFromTime,
    DateTime selectedToTime,
    FocusDuration focusDuration,
    BreakDuration breakDuration,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Duration difference = selectedToTime.difference(selectedFromTime);
    int occurrences = difference.inMinutes ~/ focusDuration.duration;
    List<AlarmDetails> list = [];

    for (int i = 0; i < occurrences; i++) {
      DateTime newTime =
          selectedFromTime.add(Duration(minutes: focusDuration.duration * i));
      print("$newTime");
      final alarmDetails = AlarmDetails(
        id: UniqueKey().hashCode,
        dateTime: newTime,
        assetAudioPath: 'assets/perfect_alarm.mp3',
        loopAudio: true,
        vibrate: true,
        fadeDuration: 3.0,
        notificationTitle: 'Getup',
        notificationBody: 'Getcho ass up',
        enableNotificationOnKill: true,
      );
      list.add(alarmDetails);
    }

    list.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);

    if (list.isNotEmpty) {
      var nextAlarm = list.removeAt(0);
      await Alarm.set(
        alarmSettings: AlarmSettings(
          id: nextAlarm.id,
          vibrate: false,
          dateTime: nextAlarm.dateTime,
          assetAudioPath: nextAlarm.assetAudioPath,
          notificationTitle: nextAlarm.notificationTitle,
          notificationBody: nextAlarm.notificationBody,
        ),
      );

      String encodedList = encodeAlarmDetailsList(list);
      await prefs.setString(ALARMS, encodedList);
    }
  }

  String encodeAlarmDetailsList(List<AlarmDetails> alarms) {
    return jsonEncode(alarms.map((alarm) => alarm.toJson()).toList());
  }
}

DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay, [DateTime? date]) {
  final currentDate = date ?? DateTime.now();
  return DateTime(currentDate.year, currentDate.month, currentDate.day,
      timeOfDay.hour, timeOfDay.minute);
}

Future<tz.TZDateTime> convertDateTimeToTZDateTime(DateTime dateTime) async {
  tz.Location location =
      tz.getLocation(await FlutterTimezone.getLocalTimezone());
  return tz.TZDateTime.from(dateTime, location);
}

Future<String> getIANATimeZone() async {
  return await FlutterTimezone.getLocalTimezone();
}

enum FocusDuration {
  ten(10),
  fifteen(15),
  thirty(30),
  fortyFive(45),
  sixty(60);

  const FocusDuration(this.duration);

  final int duration;
}

enum BreakDuration {
  five(5),
  ten(10),
  fifteen(15);

  const BreakDuration(this.duration);

  final int duration;
}

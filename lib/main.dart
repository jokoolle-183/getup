import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:gap/gap.dart';
import 'package:getup/setup_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Native called background task: $task");
    await Alarm.init();
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  String timeZoneName = await getIANATimeZone();
  await Alarm.init();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SetupModel())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TimeOfDay selectedFromTimeToday =
      TimeOfDay.fromDateTime(DateTime.now().copyWith(hour: 9, minute: 0));
  TimeOfDay selectedToTimeToday =
      TimeOfDay.fromDateTime(DateTime.now().copyWith(hour: 17, minute: 0));

  final currentDate = DateTime.now();

  DateTime? selectedFromTimeDate;
  DateTime? selectedToTimeDate;

  Set<FocusDuration> focusDurations = <FocusDuration>{
    FocusDuration.thirty,
  };
  Set<BreakDuration> breakDurations = <BreakDuration>{
    BreakDuration.five,
  };

  StreamSubscription<AlarmSettings>? ringStream;
  int _currentAlarmId = 0;

  @override
  void initState() {
    super.initState();
    selectedFromTimeDate = convertTimeOfDayToDateTime(selectedFromTimeToday);
    selectedToTimeDate = convertTimeOfDayToDateTime(selectedToTimeToday);
    checkAndroidNotificationPermission();
    checkAndroidScheduleExactAlarmPermission();
    ringStream ??= Alarm.ringStream.stream.listen(handleAlarm);
  }

  @override
  void dispose() {
    ringStream?.cancel();
    super.dispose();
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
                  ButtonSegment(
                      value: FocusDuration.thirty,
                      label: Text('${FocusDuration.thirty.duration} min')),
                  ButtonSegment(
                      value: FocusDuration.fortyFive,
                      label: Text('${FocusDuration.fortyFive.duration} min')),
                  ButtonSegment(
                      value: FocusDuration.sixty,
                      label: Text('${FocusDuration.sixty.duration} min')),
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
                onPressed: () {
                  if (selectedFromTimeDate != null &&
                      selectedToTimeDate != null) {
                    _setAlarm(
                      selectedFromTimeDate!,
                      selectedToTimeDate!,
                      focusDurations.first,
                      breakDurations.first,
                    );
                    Workmanager().registerPeriodicTask(
                      "task-identifier",
                      "simpleTask",
                      backoffPolicy: BackoffPolicy.exponential,
                      backoffPolicyDelay: const Duration(seconds: 30),
                      frequency: const Duration(minutes: 18),
                    );
                  }
                },
                child: const Text('Set alarm'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print("Stopping alarm with id $_currentAlarmId");
                  await Alarm.stop(_currentAlarmId);
                },
                child: const Text('Stop alarm'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Alarm.stopAll();
                },
                child: const Text('Stop all'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not '}granted',
      );
    }
  }

  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    alarmPrint('Schedule exact alarm permission: $status.');
    if (status.isDenied) {
      alarmPrint('Requesting schedule exact alarm permission...');
      final res = await Permission.scheduleExactAlarm.request();
      alarmPrint(
        'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted',
      );
    }
  }

  void handleAlarm(AlarmSettings event) {
    setState(() {
      _currentAlarmId = event.id;
    });
  }
}

Future<String> getIANATimeZone() async {
  return await FlutterTimezone.getLocalTimezone();
}

Future<void> _setAlarm(
  DateTime selectedFromTime,
  DateTime selectedToTime,
  FocusDuration focusDuration,
  BreakDuration breakDuration,
) async {
  Duration difference = selectedToTime.difference(selectedFromTime);
  int occurrences = difference.inMinutes ~/ focusDuration.duration;

  for (int i = 1; i <= occurrences; i++) {
    DateTime newTime =
        selectedFromTime.add(Duration(minutes: focusDuration.duration * i));
    print("$newTime");
    final alarmSettings = AlarmSettings(
      id: i,
      dateTime: newTime,
      assetAudioPath: 'assets/perfect_alarm.mp3',
      loopAudio: true,
      vibrate: true,
      fadeDuration: 3.0,
      notificationTitle: 'Getup',
      notificationBody: 'Getcho ass up',
      enableNotificationOnKill: true,
    );
    await Alarm.set(alarmSettings: alarmSettings);
  }
}

enum FocusDuration {
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

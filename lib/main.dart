import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:gap/gap.dart';
import 'package:getup/ring_screen.dart';
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
    try {
      await Alarm.init();
      return Future.value(true);
    } on Exception catch (error, stacktrace) {
      return Future.error(error, stacktrace);
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(
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

  StreamSubscription<AlarmSettings>? ringStream;
  @override
  void initState() {
    super.initState();
    loadAlarms();
    selectedFromTimeDate = convertTimeOfDayToDateTime(selectedFromTimeToday);
    selectedToTimeDate = convertTimeOfDayToDateTime(selectedToTimeToday);
    checkAndroidNotificationPermission();
    checkAndroidScheduleExactAlarmPermission();
    ringStream ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    ringStream?.cancel();
    ringStream ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
    super.didUpdateWidget(oldWidget);
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
                    await _setAlarm(
                      selectedFromTimeDate!,
                      selectedToTimeDate!,
                      focusDurations.first,
                      breakDurations.first,
                    );
                    scheduleTaskAtTime(
                        selectedFromTimeToday, focusDurations.first);
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
              ElevatedButton(
                onPressed: () async {
                  await Workmanager().cancelAll();
                },
                child: const Text('Cancel all tasks'),
              ),
              for (final alarm in alarms)
                Text('Alarm ${alarm.id} at ${alarm.dateTime}')
            ],
          ),
        ),
      ),
    );
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) =>
            ExampleAlarmRingScreen(alarmSettings: alarmSettings),
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

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
      print(alarms);
    });
  }
}

Future<String> getIANATimeZone() async {
  return await FlutterTimezone.getLocalTimezone();
}

void scheduleTaskAtTime(
    TimeOfDay scheduledTime, FocusDuration focusDuration) async {
  final now = DateTime.now();
  final todayScheduledTime = DateTime(now.year, now.month, now.day,
      scheduledTime.hour, scheduledTime.minute + focusDuration.duration);
  Duration initialDelay1;
  Duration initialDelay2;

  DateTime actualStartTime;

  if (todayScheduledTime.isAfter(now)) {
    // Subtract 3 minutes from the scheduled time
    actualStartTime = todayScheduledTime.subtract(const Duration(minutes: 3));
    if (actualStartTime.isBefore(now)) {
      // If subtracting 3 minutes puts the start time in the past, set it for tomorrow
      actualStartTime = actualStartTime.add(const Duration(days: 1));
    }
  } else {
    // Scheduled time is for tomorrow but subtract 3 minutes
    actualStartTime = todayScheduledTime
        .add(Duration(days: 1))
        .subtract(Duration(minutes: 3));
  }

  // Calculate initial delay based on the adjusted actual start time
  initialDelay1 = actualStartTime.difference(now);
  initialDelay2 = initialDelay1 + Duration(minutes: focusDuration.duration);

  // await Workmanager().registerPeriodicTask(
  //   "task-identifier-1",
  //   "simpleTask1",
  //   backoffPolicy: BackoffPolicy.exponential,
  //   backoffPolicyDelay: const Duration(seconds: 30),
  //   initialDelay: initialDelay1,
  //   frequency: Duration(minutes: focusDuration.duration * 2),
  // );

  // await Workmanager().registerPeriodicTask(
  //   "task-identifier-2",
  //   "simpleTask2",
  //   backoffPolicy: BackoffPolicy.exponential,
  //   backoffPolicyDelay: const Duration(seconds: 30),
  //   initialDelay: initialDelay2,
  //   frequency: Duration(minutes: focusDuration.duration * 2),
  // );

  final DateTime startTime2 =
      actualStartTime.add(Duration(minutes: focusDuration.duration));
  print(
      "Task 1 to start at $actualStartTime, preceeding alarm at $todayScheduledTime, making initial delay equal to $initialDelay1");
  print(
      "Task 2  to start at $startTime2, making initial delay equal to $initialDelay2");
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
  five(5),
  ten(10),
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

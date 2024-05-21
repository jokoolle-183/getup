import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:alarm/utils/alarm_exception.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:gap/gap.dart';
import 'package:getup/alarm_details.dart';
import 'package:getup/ring.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

int _id = 0;

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

const ALARMS = 'alarms';

StreamController<String> taskController = StreamController.broadcast();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

StreamSubscription<AlarmSettings>? ringStream;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String timeZoneName = await getIANATimeZone();
  await Alarm.init();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  await flutterLocalNotificationsPlugin.initialize(notificationInit());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  void initState() {
    super.initState();
    loadAlarms();
    selectedFromTimeDate = convertTimeOfDayToDateTime(selectedFromTimeToday);
    selectedToTimeDate = convertTimeOfDayToDateTime(selectedToTimeToday);
    checkAndroidNotificationPermission();
    _isAndroidPermissionGranted();
    checkAndroidScheduleExactAlarmPermission();
    ignoreBatteryOptimizationsPermission();
    openBatteryOptimizationSettings();
    ringStream ??= Alarm.ringStream.stream.listen((AlarmSettings data) {
      navigateToRingScreen(data);
    });
  }

  @override
  void dispose() {
    ringStream?.cancel();
    super.dispose();
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

  void _requestPermissions() async {
    PermissionStatus status = await Permission.activityRecognition.request();

    if (status.isGranted) {
      print('Permission GRANTED');
    } else {
      // Handle the case when permission is not granted
      print('Permission not granted');
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

  Future<void> ignoreBatteryOptimizationsPermission() async {
    final status = await Permission.ignoreBatteryOptimizations.status;
    alarmPrint('Ignore battery optimization permission: $status.');
    if (status.isDenied) {
      alarmPrint('Requesting schedule exact alarm permission...');
      final res = await Permission.ignoreBatteryOptimizations.request();
      alarmPrint(
        'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted',
      );
    }
  }

  void openBatteryOptimizationSettings() {
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
        data:
            'package:com.example.getup', // Replace YOUR_PACKAGE_NAME with your app's package name
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );

      intent.launch().catchError((e) {
        print("Error launching battery optimization settings: $e");
      });
    }
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => RingScreen(alarmSettings: alarmSettings),
      ),
    ).then((value) => loadAlarms());
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
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

    for (int i = 1; i <= occurrences; i++) {
      DateTime newTime =
          selectedFromTime.add(Duration(minutes: focusDuration.duration * i));
      print("$newTime");
      final alarmDetails = AlarmDetails(
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

Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('getup_channel_id', 'Getup',
          channelDescription: 'Getup notification channel',
          importance: Importance.low,
          priority: Priority.min,
          ticker: 'ticker');
  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );
  await flutterLocalNotificationsPlugin.show(
      ++_id, title, body, notificationDetails);
}

InitializationSettings notificationInit() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  return initializationSettings;
}

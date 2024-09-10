import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:getup/alarm_list/alarm_list_screen.dart';
import 'package:getup/edit_alarm/edit_alarm_screen.dart';
import 'package:getup/ring_alarm/ring_alarm_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

int _id = 0;

const Uuid _uuid = Uuid();

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Getup',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: EditAlarmScreen.routeName,
      routes: {
        EditAlarmScreen.routeName: (context) => const EditAlarmScreen(),
        RingAlarmScreen.routeName: (context) => const RingAlarmScreen(),
      },
      home: const AlarmListScreen(),
    );
  }
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

Future<tz.TZDateTime> convertDateTimeToTZDateTime(DateTime dateTime) async {
  tz.Location location =
      tz.getLocation(await FlutterTimezone.getLocalTimezone());
  return tz.TZDateTime.from(dateTime, location);
}

Future<String> getIANATimeZone() async {
  return await FlutterTimezone.getLocalTimezone();
}

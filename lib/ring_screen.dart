import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getup/alarm_details.dart';
import 'package:getup/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExampleAlarmRingScreen extends StatelessWidget {
  const ExampleAlarmRingScreen({required this.alarmSettings, super.key});

  final AlarmSettings alarmSettings;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'You alarm (${alarmSettings.id}) is ringing...',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text('🔔', style: TextStyle(fontSize: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RawMaterialButton(
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? jsonString = prefs.getString(ALARMS);
                      if (jsonString != null) {
                        var list = decodeAlarmDetailsList(jsonString);
                        if (list.isNotEmpty) {
                          list.sort((a, b) =>
                              a.dateTime.isBefore(b.dateTime) ? 0 : 1);
                          var nextAlarm = list.removeAt(0);
                          await Alarm.set(
                              alarmSettings: AlarmSettings(
                                  id: nextAlarm.id,
                                  dateTime: nextAlarm.dateTime,
                                  assetAudioPath: nextAlarm.assetAudioPath,
                                  notificationTitle:
                                      nextAlarm.notificationTitle,
                                  notificationBody:
                                      nextAlarm.notificationBody));

                          String encodedList = encodeAlarmDetailsList(list);
                          await prefs.setString(ALARMS, encodedList);
                        }
                      }

                      await Alarm.stop(alarmSettings.id)
                          .then((value) => Navigator.of(context).pop());
                    },
                    child: Text(
                      'Stop',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<AlarmDetails> decodeAlarmDetailsList(String jsonString) {
  return (jsonDecode(jsonString) as List<dynamic>)
      .map<AlarmDetails>((item) => AlarmDetails.fromJson(item))
      .toList();
}

String encodeAlarmDetailsList(List<AlarmDetails> alarms) {
  return jsonEncode(alarms.map((alarm) => alarm.toJson()).toList());
}

import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getup/alarm_details.dart';
import 'package:getup/constants.dart';
import 'package:getup/ring_alarm/ring_alarm_cubit.dart';
import 'package:getup/ring_alarm/ring_alarm_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RingAlarmScreen extends StatelessWidget {
  const RingAlarmScreen({super.key});
  static const routeName = '/ring-alarm';
  @override
  Widget build(BuildContext context) {
    final alarmSettings =
        ModalRoute.of(context)!.settings.arguments as AlarmSettings;
    return BlocProvider(
      create: (_) => RingAlarmCubit(),
      child: BlocBuilder<RingAlarmCubit, RingAlarmState>(
        builder: (context, state) => PopScope(
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
                  Text(
                    'Steps:${state.steps}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (state.completed)
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
                                list.removeAt(0);
                                var nextAlarm = list.firstOrNull;
                                if (nextAlarm != null) {
                                  await Alarm.set(
                                      alarmSettings: AlarmSettings(
                                          id: nextAlarm.id,
                                          dateTime: nextAlarm.dateTime,
                                          assetAudioPath:
                                              nextAlarm.assetAudioPath,
                                          notificationTitle:
                                              nextAlarm.notificationTitle,
                                          notificationBody:
                                              nextAlarm.notificationBody));
                                  String encodedList =
                                      encodeAlarmDetailsList(list);
                                  await prefs.setString(ALARMS, encodedList);
                                }
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

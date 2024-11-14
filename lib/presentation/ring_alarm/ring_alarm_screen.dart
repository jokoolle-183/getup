import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_it_up/data/model/alarm_details_model.dart';
import 'package:walk_it_up/main.dart';
import 'package:walk_it_up/presentation/ring_alarm/ring_alarm_cubit.dart';
import 'package:walk_it_up/presentation/ring_alarm/ring_alarm_state.dart';

class RingAlarmScreen extends StatelessWidget {
  const RingAlarmScreen({super.key});
  static const routeName = '/ring-alarm';
  @override
  Widget build(BuildContext context) {
    final alarmSettings =
        ModalRoute.of(context)!.settings.arguments as AlarmSettings;
    return BlocProvider(
      create: (_) => RingAlarmCubit(getIt.get()),
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
                            context
                                .read<RingAlarmCubit>()
                                .scheduleNextAlarm(alarmSettings)
                                .then((scheduleSuccess) async {
                              await Alarm.stop(alarmSettings.id);
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            });
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

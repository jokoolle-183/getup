import 'dart:async';
import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:getup/main.dart';
import 'package:getup/ring_screen.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sensors_plus/sensors_plus.dart';

class RingScreen extends StatefulWidget {
  const RingScreen({required this.alarmSettings, super.key});

  final AlarmSettings alarmSettings;

  @override
  State<RingScreen> createState() => _RingScreenState();
}

class _RingScreenState extends State<RingScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    showNotification('Pedometer steps counter', 'Steps count: ${event.steps}');
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    showNotification('Pedometer status', event.status);
    setState(() {
      if (event.status == 'walking') {
        _completed = true;
      }
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    showNotification('Pedometer status error ', error.toString());
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    showNotification('Pedometer steps counter error ', error.toString());
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

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
                'You alarm (${widget.alarmSettings.id}) is ringing...',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text('🔔', style: TextStyle(fontSize: 50)),
              Text(
                'Steps:$_steps ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (_completed)
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

                        await Alarm.stop(widget.alarmSettings.id)
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

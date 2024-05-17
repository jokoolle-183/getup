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
  int steps = 0;
  double stride = 0.0;
  double avgStride = 0.0;
  double velocity = 0.0;
  double displacement = 0.0;
  double distance = 0.0;
  double accelAvg = 0.0;
  List<double> accelData = List.filled(100, 0.0);
  double maxAvg = -10000.0;
  double minAvg = 10000.0;
  double newMax = -10000.0;
  double newMin = 10000.0;
  double oldAvg = 0.0;
  double newAvg = 0.0;
  int cycleCount = 0;
  int totalSamples = 0;
  double avgThresh = 0.05;
  double walkFudge = 0.0249;
  double stepThresh = 0.1;
  int avgConst = 1;
  int latency = 4;
  int avgLen = 8;
  int stepFlag = 2;
  double currentTime = 0.0;
  double lastTime = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((AccelerometerEvent event) {
      try {
        processAccelerometerData(event);
      } on Exception catch (e) {
        resetState();
      }
    });
  }

  void resetState() {
    setState(() {
      accelData = List.filled(200, 0.0);
      maxAvg = -10000.0;
      minAvg = 10000.0;
      newMax = -10000.0;
      newMin = 10000.0;
      oldAvg = 0.0;
      newAvg = 0.0;
      cycleCount = 0;
      totalSamples = 0;
      accelAvg = 0.0;
      velocity = 0.0;
      displacement = 0.0;
      stepFlag = 2;
    });
  }

  void processAccelerometerData(AccelerometerEvent event) {
    double x = event.x - 9.81;
    double y = event.y - 9.81;
    double rssData = sqrt((x * x + y * y) / 16.0);
    accelData[cycleCount] = rssData;

    if (totalSamples > 7) {
      oldAvg = newAvg;
      newAvg -= accelData[cycleCount - avgLen];
    }
    newAvg += rssData;

    if ((newAvg - oldAvg).abs() < avgThresh) {
      newAvg = oldAvg;
    }

    if (rssData > newMax) newMax = rssData;
    if (rssData < newMin) newMin = rssData;

    totalSamples++;
    cycleCount++;

    if (totalSamples > 8) {
      if (isStep(newAvg, oldAvg)) {
        for (int i = latency; i < (cycleCount - latency); i++) {
          accelAvg += accelData[i];
        }
        accelAvg /= (cycleCount - avgLen);

        for (int i = latency; i < (cycleCount - latency); i++) {
          velocity += (accelData[i] - accelAvg);
          displacement += velocity;
        }

        stride = displacement * (newMax - newMin) / (accelAvg - newMin);
        stride = sqrt(stride.abs()) * walkFudge;

        if (steps < 2) {
          avgStride = stride;
        } else {
          avgStride = ((avgConst - 1) * avgStride + stride) / avgConst;
        }

        setState(() {
          ++steps;
        });

        distance += avgStride;

        for (int i = 0; i < avgLen; i++) {
          accelData[i] = accelData[cycleCount + i - avgLen - 1];
        }
        cycleCount = avgLen;
        newMax = -10000.0;
        newMin = 10000.0;
        maxAvg = -10000.0;
        minAvg = 10000.0;
        accelAvg = 0;
        velocity = 0;
        displacement = 0;
      }
    }
  }

  bool isStep(double newAvg, double oldAvg) {
    if (stepFlag == 2) {
      if (newAvg > (oldAvg + stepThresh)) stepFlag = 1;
      if (newAvg < (oldAvg - stepThresh)) stepFlag = 0;
      return false;
    }

    if (stepFlag == 1) {
      if ((maxAvg > minAvg) &&
          (newAvg > ((maxAvg + minAvg) / 2)) &&
          (oldAvg < ((maxAvg + minAvg) / 2))) {
        return true;
      }
      if (newAvg < (oldAvg - stepThresh)) {
        stepFlag = 0;
        if (oldAvg > maxAvg) maxAvg = oldAvg;
      }
      return false;
    }

    if (stepFlag == 0) {
      if (newAvg > (oldAvg + stepThresh)) {
        stepFlag = 1;
        if (oldAvg < minAvg) minAvg = oldAvg;
      }
      return false;
    }

    return false;
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
              // Text(
              //   'Status:$_status ',
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              Text(
                'Steps:$steps ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
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

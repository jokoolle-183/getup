import 'dart:math';

import 'package:getup/main.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Processing {
  int steps = 0;
  double stride = 0.0;
  double avgStride = 0.0;
  double velocity = 0.0;
  double displacement = 0.0;
  double distance = 0.0;
  double accelAvg = 0.0;
  List<double> accelData = List.filled(200, 0.0);
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

  int processAccelerometerData(AccelerometerEvent event) {
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

        steps++;
        // showNotification("Step counter", "Steps: $steps");
        distance += avgStride;

        for (int i = 0; i < avgLen; i++) {
          accelData[i] = accelData[cycleCount + i - avgLen];
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
    return steps;
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
}

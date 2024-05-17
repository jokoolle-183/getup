import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerService {
  static const double _threshold =
      7.0; // Adjusted threshold for better accuracy
  static const int _sampleSize = 10; // Number of samples to average

  // Gravity components
  static double _gravityX = 0.0;
  static double _gravityY = 0.0;
  static double _gravityZ = 0.0;

  // Alpha constant for filtering gravity
  static const double _alpha = 0.8;

  static List<double> _accelerationBuffer = [];

  static bool isDeviceStill(AccelerometerEvent event) {
    // Isolate the force of gravity with the low-pass filter.
    _gravityX = _alpha * _gravityX + (1 - _alpha) * event.x;
    _gravityY = _alpha * _gravityY + (1 - _alpha) * event.y;
    _gravityZ = _alpha * _gravityZ + (1 - _alpha) * event.z;

    // Remove the gravity contribution with the high-pass filter.
    double linearAccelerationX = event.x - _gravityX;
    double linearAccelerationY = event.y - _gravityY;
    double linearAccelerationZ = event.z - _gravityZ;

    // Calculate the magnitude of the linear acceleration vector
    double linearAcceleration = sqrt(linearAccelerationX * linearAccelerationX +
        linearAccelerationY * linearAccelerationY +
        linearAccelerationZ * linearAccelerationZ);

    // Add the current acceleration to the buffer
    _accelerationBuffer.add(linearAcceleration);

    // Maintain a buffer of the last N samples
    if (_accelerationBuffer.length > _sampleSize) {
      _accelerationBuffer.removeAt(0);
    }

    // Calculate the average acceleration
    double averageAcceleration = _accelerationBuffer.reduce((a, b) => a + b) /
        _accelerationBuffer.length;

    // Check if the average acceleration is within the stillness threshold
    return averageAcceleration < _threshold;
  }
}

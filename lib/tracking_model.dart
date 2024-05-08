import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getup/kalman.dart';

class TrackingModel extends ChangeNotifier {
  final KalmanLatLong kalmanFilter = KalmanLatLong(6.0); // idealno
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
  Position? _startPosition;
  Position? _currentPosition;
  double _totalDistance = 0.0;

  Future<void> _checkPermissions() async {
    LocationPermission permission = await _geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return; // Permissions are denied, next steps not executed
      }
    }
  }

  void _startTracking() async {
    _startPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    _geolocator.getPositionStream().listen((Position position) {
      if (kalmanFilter.variance < 0) {
        kalmanFilter.setState(position.latitude, position.longitude,
            position.accuracy, position.timestamp.millisecondsSinceEpoch);
      } else {
        kalmanFilter.process(position.latitude, position.longitude,
            position.accuracy, position.timestamp.millisecondsSinceEpoch);
      }
      _currentPosition = position;
      if (_startPosition == null) {
        _startPosition = position; // Set start position if not already set
      } else {
        _totalDistance = Geolocator.distanceBetween(
          _startPosition!.latitude,
          _startPosition!.longitude,
          kalmanFilter.latitude,
          kalmanFilter.longitude,
        );
      }
      notifyListeners();
    });
  }
}

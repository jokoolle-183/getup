import 'dart:math';

class KalmanLatLong {
  final double minAccuracy = 1.0;

  double qMetresPerSecond;
  int timeStampMilliseconds = 0;
  double lat = 0.0;
  double lng = 0.0;
  double variance = -1.0; // P matrix. Negative means object uninitialized.

  KalmanLatLong(this.qMetresPerSecond);

  int get timeStamp => timeStampMilliseconds;
  double get latitude => lat;
  double get longitude => lng;
  double get accuracy => (variance < 0) ? double.infinity : sqrt(variance);

  void setState(
      double lat, double lng, double accuracy, int timeStampMilliseconds) {
    this.lat = lat;
    this.lng = lng;
    variance = accuracy * accuracy;
    this.timeStampMilliseconds = timeStampMilliseconds;
  }

  void process(double latMeasurement, double lngMeasurement, double accuracy,
      int timeStampMilliseconds) {
    if (accuracy < minAccuracy) {
      accuracy = minAccuracy;
    }
    if (variance < 0) {
      // If variance < 0, object is uninitialized, so initialize with current values
      this.timeStampMilliseconds = timeStampMilliseconds;
      lat = latMeasurement;
      lng = lngMeasurement;
      variance = accuracy * accuracy;
    } else {
      // Else apply Kalman filter methodology

      int timeIncMilliseconds =
          timeStampMilliseconds - this.timeStampMilliseconds;
      if (timeIncMilliseconds > 0) {
        // Time has moved on, so the uncertainty in the current position increases
        variance +=
            timeIncMilliseconds * qMetresPerSecond * qMetresPerSecond / 1000;
        this.timeStampMilliseconds = timeStampMilliseconds;
        // TODO: Use velocity information here to get a better estimate of current position
      }

      // Kalman gain matrix K = Variance / (Variance + MeasurementVariance)
      double k = variance / (variance + accuracy * accuracy);
      // Apply K
      lat += k * (latMeasurement - lat);
      lng += k * (lngMeasurement - lng);
      // New covariance matrix is (IdentityMatrix - K) * Covariance
      variance = (1 - k) * variance;
    }
  }
}

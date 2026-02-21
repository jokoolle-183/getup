import 'dart:math';

/// Represents a single accelerometer reading.
class AccelerometerEvent {
  final double x, y, z;
  final DateTime timestamp;

  AccelerometerEvent(this.x, this.y, this.z, this.timestamp);
}

/// Configuration for the step detection algorithm.
/// These defaults are tuned for alarm-dismissal scenarios
/// (phone in hand, short walking bursts).
class StepCounterConfig {
  /// Minimum acceleration magnitude deviation from gravity to consider as a
  /// potential step peak. Lower = more sensitive, higher = fewer false positives.
  /// Unit: m/s². Typical range: [1.5, 3.0]
  final double peakThreshold;

  /// Minimum time between two consecutive steps.
  /// Prevents double-counting from a single footfall's dual-peak
  /// (heel strike + toe-off).
  /// Human gait minimum: ~350ms (fast jog) to ~800ms (slow walk).
  final Duration minStepInterval;

  /// Maximum time allowed between the gait lock candidate and the confirming
  /// step. If exceeded, the candidate is discarded (it was a one-off motion
  /// like picking up the phone, not the start of walking).
  final Duration maxGaitLockInterval;

  /// After a step is detected, ignore all peaks for this duration.
  /// This is the primary defense against double-counting from a single
  /// footfall. Should be slightly less than [minStepInterval].
  final Duration refractoryPeriod;

  /// Cutoff frequency for the low-pass filter (Hz).
  /// Walking frequency is 1.5–2.5 Hz; we cut at 4 Hz to aggressively
  /// remove noise while preserving the step signal.
  final double lowPassCutoffHz;

  /// Accelerometer sampling rate (Hz). Must match your sensor stream.
  final double samplingRateHz;

  /// Number of initial samples to use for dynamic threshold calibration.
  /// During these samples, we measure the user's baseline noise floor.
  final int calibrationSamples;

  /// Minimum slope (rate of change) of the filtered signal leading into a
  /// peak for it to qualify as a step. This filters out gradual, smooth
  /// oscillations that aren't real footfalls.
  /// Unit: m/s² per sample. Typical range: [0.1, 0.5]
  final double minPeakSlope;

  /// Duration after gait is lost (no step within this window) before
  /// re-engaging the gait lock requirement. This prevents false positives
  /// when the user stops walking and then makes a one-off motion
  /// (e.g., putting the phone down).
  final Duration gaitTimeoutDuration;

  const StepCounterConfig({
    this.peakThreshold = 1.8,
    this.minStepInterval = const Duration(milliseconds: 380),
    this.maxGaitLockInterval = const Duration(milliseconds: 1200),
    this.refractoryPeriod = const Duration(milliseconds: 300),
    this.lowPassCutoffHz = 4.0,
    this.samplingRateHz = 50.0,
    this.calibrationSamples = 15,
    this.minPeakSlope = 0.15,
    this.gaitTimeoutDuration = const Duration(seconds: 2),
  });
}

/// Internal representation of a detected peak awaiting confirmation.
class _PeakCandidate {
  final DateTime timestamp;
  final double magnitude;

  _PeakCandidate(this.timestamp, this.magnitude);
}

/// The current state of the gait detection state machine.
enum _GaitState {
  /// No walking detected yet, or gait was lost. The next valid peak
  /// will be held as a candidate, not counted.
  waitingForGait,

  /// One peak candidate is being held. If a second peak arrives within
  /// [StepCounterConfig.maxGaitLockInterval], both are confirmed as steps
  /// and we transition to [walking].
  candidateHeld,

  /// Active walking detected. Steps are counted immediately.
  /// If no step arrives within [StepCounterConfig.gaitTimeoutDuration],
  /// we transition back to [waitingForGait].
  walking,
}

/// A short-lived, high-accuracy step counter designed for real-time
/// step detection over brief periods (10–120 seconds).
///
/// Unlike OS-level step counters, this operates directly on raw
/// accelerometer data with zero warm-up time, making it ideal for
/// "walk N steps to dismiss alarm" use cases.
///
/// ## Gait Lock Mechanism
///
/// To prevent false positives from transitional motions (picking up phone,
/// standing up), the counter uses a state machine:
///
/// ```
/// [waitingForGait] ──peak──► [candidateHeld] ──peak within interval──► [walking]
///        ▲                        │                                        │
///        │                        │ timeout (no second peak)               │
///        └────────────────────────┘                                        │
///        ▲                                                                │
///        │                        timeout (no step for 2s)                │
///        └────────────────────────────────────────────────────────────────┘
/// ```
///
/// When gait is confirmed, only the confirming step is counted (not the
/// held candidate), producing a smooth `0 → 1` transition. This trades
/// a maximum ±1 step accuracy for significantly better perceived UX.
///
/// ## Usage:
/// ```dart
/// final counter = AlarmStepCounter(
///   targetSteps: 30,
///   onStepDetected: (count) => print('Step $count'),
///   onTargetReached: () => dismissAlarm(),
/// );
///
/// // Feed accelerometer data from sensors_plus or similar:
/// accelerometerEvents.listen((event) {
///   counter.addAccelerometerReading(event.x, event.y, event.z);
/// });
///
/// // When done:
/// counter.dispose();
/// ```
class AlarmStepCounter {
  final int targetSteps;
  final StepCounterConfig config;
  final void Function(int currentSteps)? onStepDetected;
  final void Function()? onTargetReached;

  int _stepCount = 0;

  // Low-pass filter state (2nd order Butterworth)
  double _filterX1 = 0, _filterX2 = 0;
  double _filterY1 = 0, _filterY2 = 0;
  // Filter coefficients (computed in constructor)
  late final double _a0, _a1, _a2, _b1, _b2;

  // Peak detection state — sliding window of 5 samples
  final List<double> _filteredWindow = [];
  static const int _windowSize = 5;
  int _sampleCount = 0;

  // Gait state machine
  _GaitState _gaitState = _GaitState.waitingForGait;
  _PeakCandidate? _heldCandidate;
  DateTime? _lastStepTime;

  // Dynamic threshold calibration
  final List<double> _calibrationBuffer = [];
  double _dynamicThreshold = 0;
  bool _isCalibrated = false;

  // Lifecycle
  bool _isDisposed = false;
  bool _targetReached = false;

  int get currentSteps => _stepCount;
  bool get isTargetReached => _targetReached;
  bool get isDisposed => _isDisposed;

  AlarmStepCounter({
    required this.targetSteps,
    this.config = const StepCounterConfig(),
    this.onStepDetected,
    this.onTargetReached,
  }) {
    _computeFilterCoefficients();
  }

  /// Precompute 2nd-order Butterworth low-pass filter coefficients.
  void _computeFilterCoefficients() {
    final double fs = config.samplingRateHz;
    final double fc = config.lowPassCutoffHz;

    final double wc = tan(pi * fc / fs);
    final double wc2 = wc * wc;
    final double sqrt2 = sqrt(2.0);

    final double k = wc2 + sqrt2 * wc + 1.0;

    _a0 = wc2 / k;
    _a1 = 2.0 * _a0;
    _a2 = _a0;
    _b1 = 2.0 * (wc2 - 1.0) / k;
    _b2 = (wc2 - sqrt2 * wc + 1.0) / k;
  }

  /// Feed a raw accelerometer reading into the step detection pipeline.
  void addAccelerometerReading(double x, double y, double z, [DateTime? timestamp]) {
    if (_isDisposed || _targetReached) return;

    final now = timestamp ?? DateTime.now();

    // Step 1: Compute acceleration magnitude
    final double magnitude = sqrt(x * x + y * y + z * z);

    // Step 2: Compute deviation from gravity
    final double deviation = (magnitude - 9.81).abs();

    // Step 3: Apply low-pass filter
    final double filtered = _applyLowPassFilter(deviation);

    // Step 4: Dynamic calibration during initial samples
    if (!_isCalibrated) {
      _calibrationBuffer.add(filtered);
      if (_calibrationBuffer.length >= config.calibrationSamples) {
        _calibrate();
      }
      _addToWindow(filtered);
      _sampleCount++;
      return;
    }

    // Step 5: Check for gait timeout while in walking state
    _checkGaitTimeout(now);

    // Step 6: Add to sliding window and attempt peak detection
    _addToWindow(filtered);
    _sampleCount++;

    if (_filteredWindow.length == _windowSize) {
      _detectPeak(now);
    }
  }

  /// Apply 2nd-order Butterworth low-pass filter.
  double _applyLowPassFilter(double input) {
    final double output = _a0 * input + _a1 * _filterX1 + _a2 * _filterX2 - _b1 * _filterY1 - _b2 * _filterY2;

    _filterX2 = _filterX1;
    _filterX1 = input;
    _filterY2 = _filterY1;
    _filterY1 = output;

    return output;
  }

  /// Maintain a sliding window of filtered samples.
  void _addToWindow(double value) {
    _filteredWindow.add(value);
    if (_filteredWindow.length > _windowSize) {
      _filteredWindow.removeAt(0);
    }
  }

  /// Calibrate the dynamic threshold based on initial noise floor.
  void _calibrate() {
    final double mean = _calibrationBuffer.reduce((a, b) => a + b) / _calibrationBuffer.length;
    final double variance = _calibrationBuffer.map((v) => (v - mean) * (v - mean)).reduce((a, b) => a + b) /
        _calibrationBuffer.length;
    final double stdDev = sqrt(variance);

    _dynamicThreshold = max(config.peakThreshold, mean + 3.0 * stdDev);
    _isCalibrated = true;
  }

  /// Check if gait has timed out (user stopped walking).
  void _checkGaitTimeout(DateTime now) {
    if (_gaitState == _GaitState.walking && _lastStepTime != null) {
      final elapsed = now.difference(_lastStepTime!);
      if (elapsed > config.gaitTimeoutDuration) {
        _gaitState = _GaitState.waitingForGait;
        _heldCandidate = null;
      }
    }

    // Also expire a held candidate that was never confirmed
    if (_gaitState == _GaitState.candidateHeld && _heldCandidate != null) {
      final elapsed = now.difference(_heldCandidate!.timestamp);
      if (elapsed > config.maxGaitLockInterval) {
        _gaitState = _GaitState.waitingForGait;
        _heldCandidate = null;
      }
    }
  }

  /// Detect a peak using a 5-sample sliding window.
  void _detectPeak(DateTime timestamp) {
    final w = _filteredWindow;

    final double center = w[2];
    final double left1 = w[1];
    final double left2 = w[0];
    final double right1 = w[3];
    final double right2 = w[4];

    // Check 1: Local maximum
    final bool isLocalMax = center > left1 && center > right1 && center >= left2 && center >= right2;

    if (!isLocalMax) return;

    // Check 2: Amplitude threshold
    if (center < _dynamicThreshold) return;

    // Check 3: Slope check
    final double slopeLeft = center - left1;
    final double slopeRight = center - right1;
    final double maxSlope = max(slopeLeft, slopeRight);

    if (maxSlope < config.minPeakSlope) return;

    // Check 4: Refractory / min interval
    if (_lastStepTime != null) {
      final elapsed = timestamp.difference(_lastStepTime!);
      if (elapsed < config.refractoryPeriod) return;
      if (elapsed < config.minStepInterval) return;
    }

    // Valid peak — route through gait state machine
    _handleValidPeak(timestamp, center);
  }

  /// Route a validated peak through the gait state machine.
  void _handleValidPeak(DateTime timestamp, double magnitude) {
    switch (_gaitState) {
      case _GaitState.waitingForGait:
        // Hold this peak as a candidate — don't count it yet.
        _heldCandidate = _PeakCandidate(timestamp, magnitude);
        _gaitState = _GaitState.candidateHeld;
        break;

      case _GaitState.candidateHeld:
        // A second peak arrived while we're holding a candidate.
        final interval = timestamp.difference(_heldCandidate!.timestamp);

        if (interval >= config.minStepInterval && interval <= config.maxGaitLockInterval) {
          // Gait confirmed! Count only this confirming step.
          // The held candidate is intentionally not counted — it may have
          // been a transition motion (phone pickup, standing up), and even
          // if it was a real step, ±1 accuracy is an acceptable trade-off
          // for the smooth 0 → 1 UX.
          _gaitState = _GaitState.walking;
          _heldCandidate = null;

          _stepCount++;
          _lastStepTime = timestamp;
          onStepDetected?.call(_stepCount);

          _checkTarget();
        } else {
          // Interval doesn't match walking — discard old candidate,
          // hold this one instead.
          _heldCandidate = _PeakCandidate(timestamp, magnitude);
        }
        break;

      case _GaitState.walking:
        // Active walking — count immediately.
        _stepCount++;
        _lastStepTime = timestamp;
        onStepDetected?.call(_stepCount);

        _checkTarget();
        break;
    }
  }

  /// Check if the target step count has been reached.
  void _checkTarget() {
    if (_stepCount >= targetSteps) {
      _targetReached = true;
      onTargetReached?.call();
    }
  }

  /// Reset the counter to zero.
  void reset() {
    _stepCount = 0;
    _lastStepTime = null;
    _targetReached = false;
    _sampleCount = 0;
    _filteredWindow.clear();
    _filterX1 = _filterX2 = 0;
    _filterY1 = _filterY2 = 0;
    _calibrationBuffer.clear();
    _isCalibrated = false;
    _dynamicThreshold = 0;
    _gaitState = _GaitState.waitingForGait;
    _heldCandidate = null;
  }

  /// Dispose of the counter. No further readings will be processed.
  void dispose() {
    _isDisposed = true;
  }
}

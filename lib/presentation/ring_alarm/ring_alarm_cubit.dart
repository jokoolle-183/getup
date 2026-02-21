import 'dart:async';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:walk_it_up/domain/alarm_scheduler.dart';
import 'package:walk_it_up/domain/step_counter.dart';
import 'package:walk_it_up/utils/pair.dart';
import 'package:walk_it_up/presentation/ring_alarm/ring_alarm_state.dart';

class RingAlarmCubit extends Cubit<RingAlarmState> {
  RingAlarmCubit(this._alarmScheduler) : super(RingAlarmState.initial()) {
    initStreams();
  }

  final AlarmScheduler _alarmScheduler;
  AlarmStepCounter? _stepCounter;
  StreamSubscription? _accelSubscription;
  int stepCount = 0;
  bool isWalking = false;
  int? initialStepCount;

  void initStreams() {
    _stepCounter = AlarmStepCounter(
      targetSteps: 30,
      onStepDetected: (count) {
        emit(
          state.copyWith(
            steps: count,
            completed: count >= 5,
          ),
        );
      },
      onTargetReached: () {
        _accelSubscription?.cancel();
      },
    );

    _accelSubscription = accelerometerEventStream(
      samplingPeriod: const Duration(milliseconds: 20), // 50 Hz
    ).listen((event) {
      _stepCounter?.addAccelerometerReading(event.x, event.y, event.z);
    });
  }

  Future<Pair<DateTime?, bool>> scheduleNextAlarm(AlarmSettings settings) async {
    return _alarmScheduler.scheduleNextAlarm(settings);
  }
}

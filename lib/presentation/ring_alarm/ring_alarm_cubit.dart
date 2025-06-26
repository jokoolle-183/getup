import 'dart:async';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walk_it_up/domain/alarm_scheduler.dart';
import 'package:walk_it_up/utils/pair.dart';
import 'package:walk_it_up/presentation/ring_alarm/ring_alarm_state.dart';

class RingAlarmCubit extends Cubit<RingAlarmState> {
  RingAlarmCubit(this._alarmScheduler) : super(RingAlarmState.initial()) {
    initStreams();
  }

  final AlarmScheduler _alarmScheduler;

  StreamSubscription<StepCount>? _stepsSubscription;
  StreamSubscription<PedestrianStatus>? _statusSubscription;
  int stepCount = 0;
  bool isWalking = false;
  int? initialStepCount;

  void initStreams() {
    _stepsSubscription = Pedometer.stepCountStream.listen((event) {
      initialStepCount ??= event.steps;

      int totalSteps = event.steps - (initialStepCount ?? 0);
      print('Step counter reports: $totalSteps steps');
    });

    _statusSubscription = Pedometer.pedestrianStatusStream.listen((status) {
      print('Pedestrian status: ${status.status}');

      if (status.status == 'walking') {
        isWalking = true;
      } else if (status.status == 'stopped') {
        isWalking = false;
      }
    });

    Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (isWalking) {
        stepCount++;
        emit(
          state.copyWith(
            steps: stepCount,
            completed: stepCount >= 5,
          ),
        );
      }
    });
  }

  void onStepsChanged(StepCount stepCount) async {}

  Future<Pair<DateTime?, bool>> scheduleNextAlarm(AlarmSettings settings) async {
    return _alarmScheduler.scheduleNextAlarm(settings);
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    _stepsSubscription?.cancel();
    return super.close();
  }
}

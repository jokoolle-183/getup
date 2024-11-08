import 'dart:async';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedometer/pedometer.dart';
import 'package:walk_it_up/domain/alarm_scheduler.dart';
import 'package:walk_it_up/presentation/ring_alarm/ring_alarm_state.dart';

class RingAlarmCubit extends Cubit<RingAlarmState> {
  RingAlarmCubit(this._alarmScheduler) : super(RingAlarmState.initial()) {
    initStreams();
  }

  final AlarmScheduler _alarmScheduler;

  StreamSubscription<StepCount>? _stepsSubscription;
  StreamSubscription<PedestrianStatus>? _statusSubscription;
  int? _initialStepCount;

  void initStreams() {
    _stepsSubscription = Pedometer.stepCountStream.listen(onStepsChanged);
    _statusSubscription = Pedometer.pedestrianStatusStream.listen((status) {
      emit(state.copyWith(status: status.status));
    });
  }

  void onStepsChanged(StepCount stepCount) {
    _initialStepCount ??= stepCount.steps;
    final stepsSinceStart = stepCount.steps - _initialStepCount!;
    emit(
      state.copyWith(
        steps: stepsSinceStart,
        completed: stepsSinceStart >= 5,
      ),
    );
  }

  Future<bool> scheduleNextAlarm(AlarmSettings settings) async {
    return _alarmScheduler.scheduleNextRegularAlarm(settings);
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    _stepsSubscription?.cancel();
    return super.close();
  }
}

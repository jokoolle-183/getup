import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedometer/pedometer.dart';
import 'package:walk_it_up/ring_alarm/ring_alarm_state.dart';

class RingAlarmCubit extends Cubit<RingAlarmState> {
  RingAlarmCubit() : super(RingAlarmState.initial()) {
    initStreams();
  }

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

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    _stepsSubscription?.cancel();
    return super.close();
  }
}

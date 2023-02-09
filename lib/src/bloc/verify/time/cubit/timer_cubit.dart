import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock/wakelock.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerInitial());
  Timer? _timer;
  startTimer([int? time]) {
    Wakelock.enable();
    if (time != null) {
      emit(TimerProgress(time));
    } else {
      // emit(const TimerProgress(0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  onTick(Timer timer) {
    if (state is TimerProgress) {
      if (state.elapsed! > 0) {
        emit(TimerProgress(state.elapsed! - 1));
      } else {
        _timer!.cancel();
        Wakelock.disable();
        emit(const TimerInitial());
      }
    }
  }

  dispose() {
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
        Wakelock.disable();
        emit(const TimerInitial());
      }
    }
  }
}

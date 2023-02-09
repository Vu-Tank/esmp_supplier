part of 'timer_cubit.dart';

abstract class TimerState extends Equatable {
  final int? elapsed;
  const TimerState(this.elapsed);

  @override
  List<Object?> get props => [elapsed];
}

class TimerInitial extends TimerState {
  const TimerInitial() : super(60);
  @override
  List<Object?> get props => [];
}

class TimerProgress extends TimerState {
  const TimerProgress(int? elapsed) : super(elapsed);
  @override
  List<Object?> get props => [elapsed];
}

part of 'verify_bloc.dart';

class VerifyState extends Equatable {
  const VerifyState();

  @override
  List<Object> get props => [];
}

class VerifyInitial extends VerifyState {
  final int time;
  const VerifyInitial(this.time);
  @override
  List<Object> get props => [time];
}

class Verifying extends VerifyState {}

class VerifySuccess extends VerifyState {}

class VerifyOtpFailed extends VerifyState {
  final String msg;
  const VerifyOtpFailed(this.msg);
  @override
  List<Object> get props => [msg];
}

class VerifyFailed extends VerifyState {
  final String msg;
  const VerifyFailed(this.msg);
  @override
  List<Object> get props => [msg];
}

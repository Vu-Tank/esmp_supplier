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
  // TODO: implement props
  List<Object> get props => [time];
}

class Verifying extends VerifyState {}

class VerifySuccess extends VerifyState {}

class VerifyFailed extends VerifyState {
  final String msg;
  const VerifyFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

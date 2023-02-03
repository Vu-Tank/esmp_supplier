part of 'verify_bloc.dart';

class VerifyEvent extends Equatable {
  const VerifyEvent();

  @override
  List<Object> get props => [];
}

class VerifyPressed extends VerifyEvent {
  final String otp;
  final Function onSuccess;
  const VerifyPressed(this.otp, this.onSuccess);
  @override
  // TODO: implement props
  List<Object> get props => [otp, onSuccess];
}

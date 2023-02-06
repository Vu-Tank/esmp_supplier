part of 'verify_bloc.dart';

class VerifyEvent extends Equatable {
  const VerifyEvent();

  @override
  List<Object> get props => [];
}

class VerifyPressed extends VerifyEvent {
  final String otp;
  final String phone;
  final String verificationId;
  final bool isLogin;
  final Function onLogin;
  final Function onRegister;
  const VerifyPressed(
      {required this.otp,
      required this.phone,
      required this.verificationId,
      required this.isLogin,
      required this.onLogin,
      required this.onRegister});
  @override
  List<Object> get props =>
      [otp, phone, verificationId, isLogin, onLogin, onRegister];
}

class ReSendPressed extends VerifyEvent {
  final String phone;
  const ReSendPressed({required this.phone});
  @override
  List<Object> get props => [phone];
}

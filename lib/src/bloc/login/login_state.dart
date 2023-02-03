import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class Logining extends LoginState {}

class LoginFailed extends LoginState {
  final String? phoneError;
  final String? errormsg;
  const LoginFailed({required this.phoneError, required this.errormsg});
  @override
  // TODO: implement props
  List<Object?> get props => [phoneError, errormsg];
}

class LoginSuccess extends LoginState {}

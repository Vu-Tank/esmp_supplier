import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class Registering extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String? phoneError;
  final String? errormsg;
  const RegisterFailed({this.phoneError, this.errormsg});
  @override
  // TODO: implement props
  List<Object?> get props => [phoneError, errormsg];
}

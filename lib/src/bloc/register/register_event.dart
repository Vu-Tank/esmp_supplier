import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterPressed extends RegisterEvent {
  final String phone;
  final Function onSuccess;
  const RegisterPressed({required this.phone, required this.onSuccess});
  @override
  List<Object?> get props => [phone, onSuccess];
}

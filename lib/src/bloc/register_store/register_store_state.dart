part of 'register_store_bloc.dart';

abstract class RegisterStoreState extends Equatable {
  const RegisterStoreState();

  @override
  List<Object?> get props => [];
}

class RegisterStoreInitial extends RegisterStoreState {}

class RegisterStoreing extends RegisterStoreState {}

class RegisterStoreSuccess extends RegisterStoreState {}

class RegisterStoreFailed extends RegisterStoreState {
  final String? msg;
  final String? storeNameError;
  final String? emailError;
  final String? addressError;
  final String? imageError;
  const RegisterStoreFailed(
      {this.msg,
      this.storeNameError,
      this.emailError,
      this.addressError,
      this.imageError});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [msg, storeNameError, emailError, addressError, imageError];
}

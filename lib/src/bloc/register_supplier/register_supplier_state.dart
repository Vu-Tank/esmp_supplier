part of 'register_supplier_bloc.dart';

abstract class RegisterSupplierState extends Equatable {
  const RegisterSupplierState({this.genders, this.provinces});
  final List<String>? genders;
  final List<Province>? provinces;
  @override
  List<Object?> get props => [];
}

class RegisterSupplierInitial extends RegisterSupplierState {
  RegisterSupplierInitial.fromOldState(RegisterSupplierState oldState,
      {genders, gender, provinces, province})
      : super(
          genders: genders ?? oldState.genders,
          provinces: provinces ?? oldState.provinces,
        );
}

class RegisterSuppliering extends RegisterSupplierState {
  RegisterSuppliering.fromOldState(RegisterSupplierState oldState)
      : super(
          genders: oldState.genders,
          provinces: oldState.provinces,
        );
}

class RegisterSupplierloading extends RegisterSupplierState {}

class RegisterSupplierFailed extends RegisterSupplierState {
  final String? fullNameError;
  final String? emailError;
  final String? dobError;
  final String? addressError;
  final String? agreeError;
  final String? msg;
  RegisterSupplierFailed.fromOldState(RegisterSupplierState oldState,
      {this.fullNameError,
      this.emailError,
      this.msg,
      this.dobError,
      this.addressError,
      this.agreeError})
      : super(
          genders: oldState.genders,
          provinces: oldState.provinces,
        );
  @override
  List<Object?> get props =>
      [fullNameError, emailError, dobError, msg, addressError, agreeError];
}

class RegisterSupplierSuccess extends RegisterSupplierState {
  final User user;
  const RegisterSupplierSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

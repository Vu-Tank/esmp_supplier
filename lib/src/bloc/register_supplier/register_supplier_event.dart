// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_supplier_bloc.dart';

abstract class RegisterSupplierEvent extends Equatable {
  const RegisterSupplierEvent();

  @override
  List<Object?> get props => [];
}

class RegisterSupplierInit extends RegisterSupplierEvent {}

class RegisterSupplierPressed extends RegisterSupplierEvent {
  final String fullName;
  final String email;
  final DateTime? dob;
  final String address;
  final String gender;
  final Province province;
  final District? district;
  final Ward? ward;
  final bool isAgree;
  final String token;
  final String uid;
  final String phone;
  final Function onSuccess;
  const RegisterSupplierPressed({
    required this.fullName,
    required this.email,
    required this.dob,
    required this.address,
    required this.gender,
    required this.province,
    required this.district,
    required this.ward,
    required this.isAgree,
    required this.token,
    required this.uid,
    required this.phone,
    required this.onSuccess,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        fullName,
        email,
        dob,
        address,
        gender,
        province,
        district,
        ward,
        isAgree,
        token,
        onSuccess
      ];
}

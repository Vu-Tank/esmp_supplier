part of 'register_store_bloc.dart';

abstract class RegisterStoreEvent extends Equatable {
  const RegisterStoreEvent();

  @override
  List<Object?> get props => [];
}

class RegisterStorePressed extends RegisterStoreEvent {
  final String storeName;
  final String email;
  final String contextAddress;
  final int userID;
  final XFile? image;
  final Province? province;
  final District? district;
  final Ward? ward;
  final String token;
  final String phone;
  final String uid;
  final Function onSuccess;
  const RegisterStorePressed(
      {required this.storeName,
      required this.email,
      required this.contextAddress,
      required this.userID,
      required this.uid,
      this.image,
      this.district,
      this.province,
      this.ward,
      required this.token,
      required this.phone,
      required this.onSuccess});
  @override
  // TODO: implement props
  List<Object?> get props => [
        storeName,
        email,
        contextAddress,
        userID,
        image,
        province,
        district,
        ward,
        token,
        phone,
        onSuccess,
      ];
}

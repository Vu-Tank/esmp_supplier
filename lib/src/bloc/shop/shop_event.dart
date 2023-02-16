part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class ShopLogin extends ShopEvent {
  final int userID;
  final String token;
  const ShopLogin({required this.userID, required this.token});
  @override
  // TODO: implement props
  List<Object> get props => [userID, token];
}

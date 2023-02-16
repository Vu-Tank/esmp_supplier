part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopCreated extends ShopState {
  final Store store;
  const ShopCreated(this.store);
  @override
  // TODO: implement props
  List<Object> get props => [store];
}

class ShopLoading extends ShopState {}

class ShopLoginFailed extends ShopState {
  final String msg;
  const ShopLoginFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

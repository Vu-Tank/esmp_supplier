part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopCreated extends ShopState {
  final Store store;
  final double priceActice;
  const ShopCreated(this.store, this.priceActice);
  @override
  // TODO: implement props
  List<Object> get props => [store, priceActice];
}

class ShopLoading extends ShopState {}

class ShopLoginFailed extends ShopState {
  final String msg;
  const ShopLoginFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class ShopPaymentFailed extends ShopState {
  final String msg;
  final int storeID;
  const ShopPaymentFailed(this.msg, this.storeID);
  @override
  // TODO: implement props
  List<Object> get props => [msg, storeID];
}

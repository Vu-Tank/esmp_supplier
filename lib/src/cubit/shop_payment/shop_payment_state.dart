part of 'shop_payment_cubit.dart';

abstract class ShopPaymentState extends Equatable {
  const ShopPaymentState();

  @override
  List<Object> get props => [];
}

class ShopPaymentInitial extends ShopPaymentState {}

class ShopPaymentLoading extends ShopPaymentState {}

class ShopPaymentLoaded extends ShopPaymentState {
  final double price;
  const ShopPaymentLoaded(this.price);
  @override
  // TODO: implement props
  List<Object> get props => [price];
}

class ShopPaymentLoadFaild extends ShopPaymentState {
  final String msg;
  const ShopPaymentLoadFaild(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

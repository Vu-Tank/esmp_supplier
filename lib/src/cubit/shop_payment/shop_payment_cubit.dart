import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/repositories/system_repositories.dart';

part 'shop_payment_state.dart';

class ShopPaymentCubit extends Cubit<ShopPaymentState> {
  ShopPaymentCubit() : super(ShopPaymentInitial());
  loadPaymentDialog() async {
    ApiResponse apiResponse = await SystemRepositories.getPriceActice();
    if (apiResponse.isSuccess!) {
      emit(ShopPaymentLoaded(apiResponse.data));
    } else {
      emit(ShopPaymentLoadFaild(apiResponse.msg!));
    }
  }
}

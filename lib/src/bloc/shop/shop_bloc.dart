import 'package:equatable/equatable.dart';
import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/model/store.dart';
import 'package:esmp_supplier/src/repositories/store_repositories.dart';
import 'package:esmp_supplier/src/repositories/system_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial()) {
    on<ShopLogin>((event, emit) async {
      emit(ShopLoading());
      ApiResponse apiResponse = await StoreRepositories.storeLogin(
          userId: event.userID, token: event.token);
      if (apiResponse.isSuccess!) {
        Store store = apiResponse.data;
        if (store.store_Status.item_StatusID == 1) {
          emit(ShopCreated(apiResponse.data, 0));
        } else {
          apiResponse = await SystemRepositories.getPriceActice();
          if (apiResponse.isSuccess!) {
            emit(ShopCreated(store, apiResponse.data));
          } else {
            emit(ShopLoginFailed(apiResponse.msg!));
          }
        }
      } else {
        emit(ShopLoginFailed(apiResponse.msg!));
      }
    });
    on<ShopPayment>((event, emit) async {
      emit(ShopLoading());
      ApiResponse apiResponse = await StoreRepositories.storeLogin(
          userId: event.storeID, token: event.token);
      if (apiResponse.isSuccess!) {
        Store store = apiResponse.data;
        if (store.store_Status.item_StatusID == 1) {
          emit(ShopCreated(apiResponse.data, 0));
        } else {
          apiResponse = await SystemRepositories.getPriceActice();
          if (apiResponse.isSuccess!) {
            emit(ShopCreated(store, apiResponse.data));
          } else {
            emit(ShopPaymentFailed(apiResponse.msg!, store.storeID));
          }
        }
      }
    });
  }
}

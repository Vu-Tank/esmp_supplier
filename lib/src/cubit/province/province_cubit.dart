import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esmp_supplier/src/model/address/province.dart';
import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/repositories/address_repositories.dart';

part 'province_state.dart';

class ProvinceCubit extends Cubit<ProvinceState> {
  ProvinceCubit() : super(ProvinceInitial());
  loadProvince() async {
    emit(ProvinceLoading());
    ApiResponse apiResponse = await AddressRepository.getProvince();
    if (apiResponse.isSuccess!) {
      emit(ProvinceLoaded(apiResponse.data));
    } else {
      emit(ProvinceError(apiResponse.msg!));
    }
  }
}

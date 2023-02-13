import 'package:equatable/equatable.dart';
import 'package:esmp_supplier/src/model/address/district.dart';
import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/repositories/address_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'district_state.dart';

class DistrictCubit extends Cubit<DistrictState> {
  DistrictCubit() : super(DistrictInitial());
  selectedProvince(String provinceId) async {
    emit(DistrictLoading());
    ApiResponse apiResponse = await AddressRepository.getDistrict(provinceId);
    if (apiResponse.isSuccess!) {
      emit(DistrictLoaded(apiResponse.data));
    } else {
      emit(DistrictError(apiResponse.msg!));
    }
  }
}

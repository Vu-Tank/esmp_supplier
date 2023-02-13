import 'package:equatable/equatable.dart';
import 'package:esmp_supplier/src/model/address/ward.dart';
import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/repositories/address_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ward_state.dart';

class WardCubit extends Cubit<WardState> {
  WardCubit() : super(WardInitial());
  selectDistrict(String districtId) async {
    emit(WardLoading());
    ApiResponse apiResponse = await AddressRepository.getWard(districtId);
    if (apiResponse.isSuccess!) {
      emit(WardLoaded(apiResponse.data!));
    } else {
      emit(WardError(apiResponse.msg!));
    }
  }
}

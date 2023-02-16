import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:esmp_supplier/src/model/address/district.dart';
import 'package:esmp_supplier/src/model/address/province.dart';
import 'package:esmp_supplier/src/model/address/ward.dart';
import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/model/store.dart';
import 'package:esmp_supplier/src/repositories/cloud_firestore_service.dart';
import 'package:esmp_supplier/src/repositories/store_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/address/goong_address.dart';
import '../../model/validation_item.dart';
import '../../repositories/goong_repositories.dart';
import '../../utils/validations.dart';

part 'register_store_event.dart';
part 'register_store_state.dart';

class RegisterStoreBloc extends Bloc<RegisterStoreEvent, RegisterStoreState> {
  RegisterStoreBloc() : super(RegisterStoreInitial()) {
    on<RegisterStorePressed>((event, emit) async {
      emit(RegisterStoreing());
      bool check = true;
      ValidationItem fullName = Validations.validUserName(event.storeName);
      if (fullName.error != null) check = false;
      ValidationItem email = Validations.valEmail(event.email);
      if (email.error != null) check = false;
      ValidationItem address =
          Validations.valAddressContext(event.contextAddress);
      if (address.error != null) check = false;
      ValidationItem province = Validations.valProvince(event.province!);
      if (province.error != null) check = false;
      ValidationItem district = Validations.valDistrict(event.district);
      if (district.error != null) check = false;
      ValidationItem ward = Validations.valWard(event.ward);
      if (ward.error != null) check = false;
      if (event.image == null) check = false;
      if (check) {
        try {
          String? placeID = await GoongRepositories().getPlaceIdFromText(
              '${event.contextAddress}, ${event.province!.value}, ${event.district!.value}, ${event.ward!.value}');
          if (placeID == null) throw Exception('Không thể lấy địa chỉ');
          GoongAddress? goongAddress =
              await GoongRepositories().getPlace(placeID);
          if (goongAddress == null) throw Exception('Không thể lấy địa chỉ');
          double lat = goongAddress.lat;
          double lng = goongAddress.lng;
          ApiResponse apiResponse = await StoreRepositories.storeRegister(
              userID: event.userID,
              file: event.image!,
              token: event.token,
              storeName: event.storeName,
              email: event.email,
              phone: event.phone,
              contextAddress: event.contextAddress,
              province: event.province!.value,
              district: event.district!.value,
              ward: event.ward!.value,
              latitude: lat,
              longitude: lng);
          if (apiResponse.isSuccess!) {
            Store store = apiResponse.data;
            await CloudFirestoreService(
              uid: event.uid,
            ).createUserCloud(
                imageUrl: store.image.path, userName: store.storeName);
            emit(RegisterStoreSuccess());
            event.onSuccess(store);
          } else {
            emit(RegisterStoreFailed(msg: apiResponse.msg));
          }
        } catch (e) {
          emit(RegisterStoreFailed(msg: e.toString()));
        }
      } else {
        emit(RegisterStoreFailed(
            storeNameError: fullName.error,
            emailError: email.error,
            addressError:
                province.error ?? district.error ?? ward.error ?? address.error,
            imageError: (event.image == null)
                ? 'Vui lòng chọn ảnh đại diện cho cửa hàng'
                : null));
      }
    });
  }
}

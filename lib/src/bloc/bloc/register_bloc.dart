import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:esmp_supplier/src/bloc/bloc/register_event.dart';
import 'package:esmp_supplier/src/bloc/bloc/register_state.dart';
import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/model/validation_item.dart';
import 'package:esmp_supplier/src/repositories/firebase_auth.dart';
import 'package:esmp_supplier/src/repositories/user_repositories.dart';
import 'package:esmp_supplier/src/utils/utils.dart';
import 'package:esmp_supplier/src/utils/validations.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterPressed>((event, emit) async {
      emit(Registering());
      ValidationItem phone = Validations.valPhoneNumber(event.phone);
      if (phone.error != null) {
        emit(RegisterFailed(phoneError: phone.error));
      } else {
        ApiResponse apiResponse = await UserRepositories.checkUserExist(
            phone: Utils.convertToDB(phone.value!));
        if (!apiResponse.isSuccess!) {
          try {
            await FirebaseAuthService().verifyPhone(
                phoneNumber: Utils.convertToFirebase(phone.value),
                onSuccess: () {
                  log("thành công");
                },
                onFailed: () {
                  log("thất bại");
                });
          } catch (e) {
            log(e.toString());
          }
        } else {
          emit(RegisterFailed(errormsg: apiResponse.msg!));
        }
      }
    });
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/model/validation_item.dart';
import 'package:esmp_supplier/src/repositories/user_repositories.dart';
import 'package:esmp_supplier/src/utils/utils.dart';
import 'package:esmp_supplier/src/utils/validations.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginPressed>(
      (event, emit) async {
        emit(Logining());
        ValidationItem phone = Validations.valPhoneNumber(event.phoneNumber);
        if (phone.error != null) {
          emit(LoginFailed(phoneError: phone.error, errormsg: null));
        } else {
          ApiResponse apiResponse = await UserRepositories.checkUserExist(
              phone: phone.value.toString());
          if (apiResponse.isSuccess!) {
            emit(LoginSuccess());
            event.onSuccess();
          } else {
            emit(LoginFailed(phoneError: null, errormsg: apiResponse.msg));
          }
        }
      },
    );
  }
}

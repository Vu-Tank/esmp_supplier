import 'dart:developer';

import 'package:esmp_supplier/src/bloc/register/register_event.dart';
import 'package:esmp_supplier/src/bloc/register/register_state.dart';
import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/model/validation_item.dart';
import 'package:esmp_supplier/src/repositories/firebase_auth.dart';
import 'package:esmp_supplier/src/repositories/user_repositories.dart';
import 'package:esmp_supplier/src/utils/utils.dart';
import 'package:esmp_supplier/src/utils/validations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuthService _authService;
  RegisterBloc()
      : _authService = FirebaseAuthService(),
        super(RegisterInitial()) {
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
            await _authService.verifyPhone(
                phoneNumber: Utils.convertToFirebase(event.phone),
                onFailed: (String msg) {
                  emit(RegisterFailed(errormsg: msg));
                },
                onSendCode: (String verificationId) {
                  emit(RegisterSuccess());
                  event.onSuccess(verificationId);
                });
          } catch (e) {
            emit(RegisterFailed(errormsg: e.toString()));
          }
        } else {
          emit(RegisterFailed(errormsg: apiResponse.msg!));
        }
      }
    });
  }
}

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:esmp_supplier/src/bloc/login/login_state.dart';
import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/model/user.dart';
import 'package:esmp_supplier/src/repositories/firebase_auth.dart';
import 'package:esmp_supplier/src/repositories/user_repositories.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_event.dart';
part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final FirebaseAuthService _authService;
  VerifyBloc()
      : _authService = FirebaseAuthService(),
        super(const VerifyInitial(60)) {
    on<VerifyPressed>((event, emit) async {
      emit(Verifying());
      try {
        if (event.otp.isEmpty || event.otp.length != 6) {
          emit(const VerifyOtpFailed('Vui Lòng nhập mã OTP'));
        } else {
          await _authService.verifyOTP(
              otp: event.otp,
              phoneNumber: event.phone,
              verificationId: event.verificationId,
              isLogin: event.isLogin,
              onFailed: (String msg) {
                emit(VerifyOtpFailed(msg));
              },
              onLogin: (User user) async {
                emit(VerifySuccess());
                event.onLogin(user);
              },
              onRegister: (String firebaseToken, String uid) {
                emit(VerifySuccess());
                event.onRegister(firebaseToken, uid);
              });
        }
      } catch (e) {
        emit(VerifyFailed(e.toString()));
      }
    });
    on<ReSendPressed>((event, emit) async {
      try {
        await _authService.verifyPhone(
            phoneNumber: event.phone,
            onFailed: (String msg) {
              emit(VerifyFailed(msg));
            },
            onSendCode: (String verificationId) {});
      } catch (e) {
        emit(VerifyFailed(e.toString()));
      }
    });
  }
}

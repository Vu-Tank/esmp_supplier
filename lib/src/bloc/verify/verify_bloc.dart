import 'package:equatable/equatable.dart';
import 'package:esmp_supplier/src/repositories/firebase_auth.dart';
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
        await _authService.verifyOTP(
            otp: event.otp,
            phoneNumber: event.phone,
            verificationId: event.verificationId,
            isLogin: event.isLogin,
            onFailed: (String msg) {
              emit(VerifyOtpFailed(msg));
            },
            onLogin: () {
              emit(VerifySuccess());
              event.onLogin();
            },
            onRegister: () {
              emit(VerifySuccess());
              event.onRegister();
            });
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

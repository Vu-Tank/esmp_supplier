import 'package:equatable/equatable.dart';
import 'package:esmp_supplier/src/repositories/user_repositories.dart';
import 'package:esmp_supplier/src/utils/user_shared_pre.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/api_response.dart';
import '../../model/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthNotAuthenticated()) {
    on<UserLoggedIn>(((event, emit) async {
      await UserSharedPre.saveUser(event.user);
      emit(AuthAuthenticated(user: event.user));
    }));
    on<UserLoggedOut>(((event, emit) async {
      UserSharedPre.removeUser();
      emit(AuthNotAuthenticated());
    }));
    on<AppLoaded>((event, emit) async {
      emit(AuthLoading());
      try {
        await Future.delayed(
            const Duration(milliseconds: 500)); // a simulated delay
        int? userID = await UserSharedPre.getUserId();
        String? token = await UserSharedPre.getUsertoken();
        if (userID != null && token != null) {
          final ApiResponse apiResponse =
              await UserRepositories.refeshToken(token: token, userID: userID);
          if (apiResponse.isSuccess!) {
            emit(AuthAuthenticated(user: apiResponse.data));
          } else {
            emit(AuthNotAuthenticated());
          }
        } else {
          emit(AuthNotAuthenticated());
        }
      } catch (e) {
        emit(AuthNotAuthenticated());
      }
    });
  }
}

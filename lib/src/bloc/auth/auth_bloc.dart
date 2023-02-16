import 'package:equatable/equatable.dart';
import 'package:esmp_supplier/src/repositories/user_repositories.dart';
import 'package:esmp_supplier/src/utils/local_Storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/api_response.dart';
import '../../model/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthNotAuthenticated()) {
    on<UserLoggedIn>(((event, emit) async {
      // await UserSharedPre.saveUser(event.user);
      LocalStorage.saveValue('userID', event.user.userID.toString());
      LocalStorage.saveValue('token', event.user.token);
      emit(AuthAuthenticated(user: event.user));
    }));
    on<UserLoggedOut>(((event, emit) async {
      // UserSharedPre.removeUser();
      LocalStorage.clearAll();
      emit(AuthNotAuthenticated());
    }));
    on<AppLoaded>((event, emit) async {
      try {
        if (state is AuthAuthenticated) return;
        emit(AuthLoading());
        String? userID = LocalStorage.getValue('userID');
        String? token = LocalStorage.getValue('token');
        if (userID != null && token != null) {
          final ApiResponse apiResponse = await UserRepositories.refeshToken(
              token: token, userID: int.parse(userID));
          if (apiResponse.isSuccess!) {
            User user = apiResponse.data;
            LocalStorage.saveValue('token', user.token);
            emit(AuthAuthenticated(user: user));
          } else {
            LocalStorage.clearAll();
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

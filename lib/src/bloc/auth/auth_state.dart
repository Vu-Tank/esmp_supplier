part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthNotAuthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  const AuthAuthenticated({required this.user});
  @override
  // TODO: implement props
  List<Object> get props => [user];
}

part of 'register_store_bloc.dart';

abstract class RegisterStoreState extends Equatable {
  const RegisterStoreState();
  
  @override
  List<Object> get props => [];
}

class RegisterStoreInitial extends RegisterStoreState {}

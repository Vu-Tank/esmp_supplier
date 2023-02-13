import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_store_event.dart';
part 'register_store_state.dart';

class RegisterStoreBloc extends Bloc<RegisterStoreEvent, RegisterStoreState> {
  RegisterStoreBloc() : super(RegisterStoreInitial()) {
    on<RegisterStoreEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

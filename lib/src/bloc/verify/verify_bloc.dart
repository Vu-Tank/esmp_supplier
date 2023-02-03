import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verify_event.dart';
part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  VerifyBloc() : super(const VerifyInitial(60)) {
    on<VerifyPressed>((event, emit) {
      // TODO: implement event handler
    });
  }
}

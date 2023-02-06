import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_supplier_event.dart';
part 'register_supplier_state.dart';

class RegisterSupplierBloc
    extends Bloc<RegisterSupplierEvent, RegisterSupplierState> {
  RegisterSupplierBloc() : super(RegisterSupplierInitial()) {
    on<RegisterSupplierEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

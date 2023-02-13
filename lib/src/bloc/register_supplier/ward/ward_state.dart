part of 'ward_cubit.dart';

abstract class WardState extends Equatable {
  const WardState();

  @override
  List<Object> get props => [];
}

class WardInitial extends WardState {}

class WardLoading extends WardState {}

class WardLoaded extends WardState {
  final List<Ward> ward;
  const WardLoaded(this.ward);
  @override
  // TODO: implement props
  List<Object> get props => [ward];
}

class WardError extends WardState {
  final String msg;
  const WardError(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

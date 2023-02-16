part of 'district_cubit.dart';

abstract class DistrictState extends Equatable {
  const DistrictState();

  @override
  List<Object> get props => [];
}

class DistrictInitial extends DistrictState {}

class DistrictLoading extends DistrictState {}

class DistrictLoaded extends DistrictState {
  final List<District> districts;
  const DistrictLoaded(this.districts);
  @override
  // TODO: implement props
  List<Object> get props => [districts];
}

class DistrictError extends DistrictState {
  final String msg;
  const DistrictError(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

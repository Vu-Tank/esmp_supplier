part of 'pick_image_cubit.dart';

abstract class PickImageState extends Equatable {
  const PickImageState();

  @override
  List<Object> get props => [];
}

class PickImageInitial extends PickImageState {}

class PickImageSuccess extends PickImageState {
  final XFile image;
  final Uint8List data;
  const PickImageSuccess({required this.image, required this.data});
  @override
  // TODO: implement props
  List<Object> get props => [image, data];
}

class PickImageing extends PickImageState {}

class PickImageFailed extends PickImageState {
  final String msg;
  const PickImageFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

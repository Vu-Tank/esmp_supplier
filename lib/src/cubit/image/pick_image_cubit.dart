import 'dart:developer';

import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(PickImageInitial());
  pickImage() async {
    emit(PickImageing());
    try {
      final ImagePicker picker = ImagePicker();

      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var data = await image.readAsBytes();
        emit(PickImageSuccess(image: image, data: data));
      } else {
        emit(const PickImageFailed('Không có hình ảnh được chọn'));
        log('Không có hình ảnh được chọn');
      }
    } catch (e) {
      emit(PickImageFailed(e.toString()));
    }
  }
}

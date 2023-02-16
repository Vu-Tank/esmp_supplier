import 'dart:developer';
import 'dart:io';
// import 'dart:io';

import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(PickImageInitial());
  pickImage() async {
    emit(PickImageing());
    try {
      final ImagePicker picker = ImagePicker();
      // final FilePickerResult? image = await FilePicker.platform.pickFiles();

      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var data = await image.readAsBytes();
        // // File i = File.fromRawPath(file);
        // inspect(image);
        // File _image = File(image.path);
        // inspect(image.readAsString());
        // inspect(File.fromRawPath(file));
        emit(PickImageSuccess(image: image, data: data));
      } else {
        // emit(PickImageFailed('Không có hình ảnh được chọn'));
        log('Không có hình ảnh được chọn');
      }
    } catch (e) {
      emit(PickImageFailed(e.toString()));
    }
  }
}

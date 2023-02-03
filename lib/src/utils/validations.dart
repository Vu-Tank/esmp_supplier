import '../model/validation_item.dart';

class Validations {
  static ValidationItem valPhoneNumber(String? value) {
    ValidationItem validationItem = ValidationItem(null, null);
    String pattern = r'^(0|84|\+84){1}([3|5|7|8|9]){1}([0-9]{8})\b';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      validationItem = ValidationItem(null, "Vui lòng Nhập số điện thoại");
    } else if (!regExp.hasMatch(value)) {
      validationItem = ValidationItem(null, "Số điện thoại không chính xác");
    } else {
      validationItem = ValidationItem(value, null);
    }
    return validationItem;
  }
}

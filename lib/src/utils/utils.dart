import 'package:intl/intl.dart';

class Utils {
  static String convertToFirebase(String value) {
    if (value.indexOf('0') == 0) {
      value = value.replaceFirst("0", "+84");
    } else if (value.indexOf("8") == 0) {
      value = value.replaceFirst("8", "+8");
    }
    return value;
  }

  static String convertToDB(String value) {
    if (value.indexOf('0') == 0) {
      value = value.replaceFirst("0", "+84");
    } else if (value.indexOf("8") == 0) {
      value = value.replaceFirst("8", "+8");
    }
    if (value.indexOf('+') == 0) {
      value = value.replaceFirst("+", "");
    }
    return value;
  }

  static String convertDateTimeToString(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(dateTime);
  }
}

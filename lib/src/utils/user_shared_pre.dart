import 'package:esmp_supplier/src/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPre {
  UserSharedPre._();
  static Future<bool> saveUser(User user) async {
    bool result = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setInt("userID", user.userID);
      prefs.setString("token", user.token);
    } catch (e) {
      result = false;
    }
    return result;
  }

  static Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("userID");
    return userId;
  }

  static Future<String?> getUsertoken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

  static void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userID");
    prefs.remove("token");
  }
}

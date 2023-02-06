import 'package:flutter/material.dart';

class AppStyle {
  static TextStyle apptitle = const TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h1 = apptitle.copyWith(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static TextStyle h2 = h1.copyWith(
    fontSize: 18,
  );
  static TextStyle errorStyle = h1.copyWith(
    color: Colors.red,
  );
  static Color appColor = const Color(0xFFeb6440);
  static TextStyle buttom = const TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
  static ButtonStyle myButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: appColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
  );
}

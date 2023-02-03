import 'package:flutter/material.dart';

class MyDialog {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 5),
        ),
      );
  }
}

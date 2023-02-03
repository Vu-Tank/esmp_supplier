// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:esmp_supplier/src/utils/app_style.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({
    Key? key,
    required this.verificationId,
    required this.isLogin,
  }) : super(key: key);
  final String verificationId;
  final bool isLogin;
  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Xác thực',
          style: AppStyle.apptitle,
        ),
        centerTitle: true,
        backgroundColor: AppStyle.appColor,
      ),
      body: Container(),
    );
  }
}

import 'package:esmp_supplier/src/utils/app_style.dart';
import 'package:flutter/material.dart';

class RegisterStorePage extends StatefulWidget {
  const RegisterStorePage({super.key});

  @override
  State<RegisterStorePage> createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đăng ký cửa hàng',
          style: AppStyle.apptitle,
        ),
        centerTitle: true,
        backgroundColor: AppStyle.appColor,
      ),
      body: Center(child: SingleChildScrollView()),
    );
  }
}

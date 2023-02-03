import 'package:esmp_supplier/src/router/app_router_constants.dart';
import 'package:esmp_supplier/src/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  GoRouter.of(context)
                      .pushNamed(AppRouterConstants.loginRouteName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyle.appColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                child: Text(
                  'Đăng nhập',
                  style: AppStyle.buttom,
                )),
            ElevatedButton(
                onPressed: () {
                  GoRouter.of(context)
                      .pushNamed(AppRouterConstants.registerRouteName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyle.appColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                child: Text(
                  'Đăng ký',
                  style: AppStyle.buttom,
                )),
          ],
        ),
      ),
    );
  }
}

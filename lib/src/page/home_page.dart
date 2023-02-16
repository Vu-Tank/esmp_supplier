import 'dart:developer';

import 'package:esmp_supplier/src/bloc/auth/auth_bloc.dart';
import 'package:esmp_supplier/src/bloc/shop/shop_bloc.dart';
import 'package:esmp_supplier/src/model/store.dart';
import 'package:esmp_supplier/src/model/user.dart';
import 'package:esmp_supplier/src/router/app_router_constants.dart';
import 'package:esmp_supplier/src/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          User user = state.user;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Trang chủ',
                style: AppStyle.apptitle,
              ),
              backgroundColor: AppStyle.appColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              actions: [
                ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(UserLoggedOut());
                    },
                    style: AppStyle.myButtonStyle.copyWith(
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.white)))),
                    child: Text(
                      'Đăng xuất',
                      style: AppStyle.buttom,
                    )),
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                  child: (state.user.storeID == -1)
                      ? Container(
                          child: Column(children: [
                            Text(
                              'Bạn chưa tiến hành tạo cửa hàng!',
                              style: AppStyle.h2,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            SizedBox(
                              height: 56.0,
                              width: 150.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  GoRouter.of(context).pushNamed(
                                      AppRouterConstants.registerStore);
                                },
                                style: AppStyle.myButtonStyle,
                                child: Text(
                                  'Tạo cửa hàng',
                                  style: AppStyle.buttom,
                                ),
                              ),
                            ),
                          ]),
                        )
                      : BlocProvider(
                          create: (context) => ShopBloc()
                            ..add(
                              ShopLogin(userID: user.userID, token: user.token),
                            ),
                          child: BlocBuilder<ShopBloc, ShopState>(
                            builder: (context, state) {
                              if (state is ShopCreated) {
                                return shopView(context, state.store);
                              } else if (state is ShopLoginFailed) {
                                return Center(
                                  child: Column(children: [
                                    Text(
                                      state.msg,
                                      style: AppStyle.h2
                                          .copyWith(color: Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    SizedBox(
                                      height: 54.0,
                                      width: 350,
                                      child: ElevatedButton(
                                        onPressed: () => context
                                            .read<ShopBloc>()
                                            .add(ShopLogin(
                                                userID: user.storeID,
                                                token: user.token)),
                                        style: AppStyle.myButtonStyle,
                                        child: Text(
                                          'Thử lại',
                                          style: AppStyle.buttom,
                                        ),
                                      ),
                                    )
                                  ]),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        )),
            ),
          );
        } else if (state is AuthLoading) {
          return Scaffold(
            body: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                            onPressed: () {
                              GoRouter.of(context)
                                  .pushNamed(AppRouterConstants.loginRouteName);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppStyle.appColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            child: Text(
                              'Đăng nhập',
                              style: AppStyle.buttom,
                            )),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                  AppRouterConstants.registerRouteName);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppStyle.appColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            child: Text(
                              'Đăng ký',
                              style: AppStyle.buttom,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget shopView(BuildContext context, Store store) {
    return Center(
      child: Text(
        store.storeName,
        style: AppStyle.h2,
      ),
    );
  }
}

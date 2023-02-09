import 'dart:developer';

import 'package:esmp_supplier/src/bloc/auth/auth_bloc.dart';
import 'package:esmp_supplier/src/bloc/login/login_event.dart';
import 'package:esmp_supplier/src/router/app_router_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_state.dart';
import '../../utils/app_style.dart';
import '../../utils/my_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // log('aa');
          GoRouter.of(context)
              .pushReplacementNamed(AppRouterConstants.homeRouteName);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Đăng nhập',
                style: AppStyle.apptitle,
              ),
              centerTitle: true,
              backgroundColor: AppStyle.appColor,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailed && state.errormsg != null) {
                      MyDialog.showSnackBar(context, state.errormsg!);
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 8.0,
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Chào mừng đến với ESMP',
                              style: AppStyle.h1,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            //phoneNumber
                            TextField(
                              controller: _phoneController,
                              textAlign: TextAlign.left,
                              style: AppStyle.h2,
                              maxLines: 1,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                              ],
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone),
                                label: Text(
                                  'Số điện thoại',
                                  style: AppStyle.h2,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: (state is LoginFailed &&
                                              state.phoneError != null)
                                          ? Colors.red
                                          : Colors.black),
                                ),
                              ),
                            ),
                            //error
                            (state is LoginFailed && state.phoneError != null)
                                ? Text(
                                    state.phoneError!,
                                    style: AppStyle.errorStyle,
                                  )
                                : Container(),
                            const SizedBox(
                              height: 8.0,
                            ),
                            //button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: (state is Logining)
                                    ? null
                                    : () async => context
                                        .read<LoginBloc>()
                                        .add(LoginPressed(
                                            phoneNumber: _phoneController.text,
                                            onSuccess: (String verificationId) {
                                              GoRouter.of(context).pushNamed(
                                                  AppRouterConstants
                                                      .verifyRouteName,
                                                  queryParams: {
                                                    'verificationId':
                                                        verificationId,
                                                    'isLogin': true.toString(),
                                                    'phone': _phoneController
                                                        .text
                                                        .trim(),
                                                  });
                                            })),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppStyle.appColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                ),
                                child: (state is Logining)
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Đăng Nhập',
                                        style: AppStyle.buttom,
                                      ),
                              ),
                            ),
                          ]),
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

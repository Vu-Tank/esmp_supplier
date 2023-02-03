import 'dart:developer';

import 'package:esmp_supplier/src/bloc/bloc/register_bloc.dart';
import 'package:esmp_supplier/src/utils/app_style.dart';
import 'package:esmp_supplier/src/utils/my_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/bloc/register_event.dart';
import '../../bloc/bloc/register_state.dart';
import '../../router/app_router_constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đăng ký',
          style: AppStyle.apptitle,
        ),
        centerTitle: true,
        backgroundColor: AppStyle.appColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: BlocConsumer<RegisterBloc, RegisterState>(
          builder: (context, state) => Padding(
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
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      label: Text(
                        'Số điện thoại',
                        style: AppStyle.h2,
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: (state is RegisterFailed &&
                                    state.phoneError != null)
                                ? Colors.red
                                : Colors.black),
                      ),
                    ),
                  ),
                  //error
                  (state is RegisterFailed && state.phoneError != null)
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
                      onPressed: (state is Registering)
                          ? null
                          : () async {
                              context.read<RegisterBloc>().add(RegisterPressed(
                                  phone: _phoneController.text,
                                  onSuccess: (String verificationId) {
                                    GoRouter.of(context).pushNamed(
                                        AppRouterConstants.verifyRouteName,
                                        queryParams: {
                                          'verificationId': verificationId,
                                          'isLogin': false,
                                        });
                                  }));
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyle.appColor,
                        disabledBackgroundColor:
                            AppStyle.appColor.withOpacity(0.2),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                      child: (state is Registering)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Đăng nhập',
                              style: AppStyle.buttom,
                            ),
                    ),
                  ),
                ]),
          ),
          listener: (context, state) {
            if (state is RegisterFailed && state.errormsg != null) {
              MyDialog.showSnackBar(context, state.errormsg!);
            }
          },
        )),
      ),
    );
  }
}

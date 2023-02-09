// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:esmp_supplier/src/bloc/auth/auth_bloc.dart';
import 'package:esmp_supplier/src/bloc/verify/time/cubit/timer_cubit.dart';
import 'package:esmp_supplier/src/bloc/verify/verify_bloc.dart';
import 'package:esmp_supplier/src/model/user.dart';
import 'package:esmp_supplier/src/router/app_router_constants.dart';
import 'package:esmp_supplier/src/utils/app_style.dart';
import 'package:esmp_supplier/src/utils/my_dialog.dart';
import 'package:esmp_supplier/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({
    Key? key,
    required this.verificationId,
    required this.isLogin,
    required this.phone,
  }) : super(key: key);
  final String phone;
  final String verificationId;
  final bool isLogin;
  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController _pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        // border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        color: const Color(0xFFeef2f9),
        border: Border.all(
          color: AppStyle.appColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      // border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      border: Border.all(
        color: AppStyle.appColor,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        // color: Color.fromRGBO(234, 239, 243, 1),
        color: AppStyle.appColor,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Xác thực',
          style: AppStyle.apptitle,
        ),
        centerTitle: true,
        backgroundColor: AppStyle.appColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppStyle.buttom.color),
          onPressed: () {
            context.read<TimerCubit>().dispose();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocConsumer<VerifyBloc, VerifyState>(
        listener: (context, state) {
          if (state is VerifyFailed) {
            MyDialog.showSnackBar(context, state.msg);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 200,
                    color: AppStyle.appColor,
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Text("Xác Thực OTP", style: AppStyle.h2),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Số điện thoại ${widget.phone}',
                    style: AppStyle.h2,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Pinput(
                    length: 6,
                    keyboardType: TextInputType.number,
                    controller: _pinController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    errorText: (state is VerifyOtpFailed) ? state.msg : null,
                    // pinputAutovalidateMode: null,
                    textInputAction: TextInputAction.next,
                    showCursor: true,
                    // validator: (s) {
                    //   print('validating code: ');
                    // },
                    onCompleted: null,
                  ),
                  if (state is VerifyOtpFailed)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        state.msg,
                        style: AppStyle.h2.copyWith(color: Colors.red),
                      ),
                    ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Không nhận được OTP? ', style: AppStyle.h2),
                      BlocBuilder<TimerCubit, TimerState>(
                        builder: (context, state) {
                          if (state is TimerProgress) {
                            return Text(
                              'Thử lại sau ${state.elapsed}s',
                              style: AppStyle.h2,
                            );
                          } else {
                            return TextButton(
                              child: Text('Gửi lại',
                                  style: AppStyle.h2
                                      .copyWith(color: AppStyle.appColor)),
                              onPressed: () {
                                context.read<TimerCubit>().startTimer(60);
                                context.read<VerifyBloc>().add(ReSendPressed(
                                    phone:
                                        Utils.convertToFirebase(widget.phone)));
                              },
                            );
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (state is Verifying)
                          ? null
                          : () => context.read<VerifyBloc>().add(VerifyPressed(
                              otp: _pinController.text,
                              phone: widget.phone,
                              verificationId: widget.verificationId,
                              isLogin: widget.isLogin,
                              onLogin: (User user) {
                                context.read<TimerCubit>().dispose();
                                context
                                    .read<AuthBloc>()
                                    .add(UserLoggedIn(user: user));
                                GoRouter.of(context).pushReplacementNamed(
                                  AppRouterConstants.homeRouteName,
                                );
                              },
                              onRegister: (String firebaseToken, String uid) {
                                context.read<TimerCubit>().dispose();
                                GoRouter.of(context).pushReplacementNamed(
                                    AppRouterConstants
                                        .registerSupplierRouteName,
                                    queryParams: {
                                      'firebaseToken': firebaseToken,
                                      'uid': uid,
                                      'phone': widget.phone
                                    });
                              })),
                      style: AppStyle.myButtonStyle,
                      child: (state is Verifying)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text('Xác thực', style: AppStyle.buttom),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:esmp_supplier/src/bloc/auth/auth_bloc.dart';
import 'package:esmp_supplier/src/bloc/register/register_bloc.dart';
import 'package:esmp_supplier/src/bloc/register_supplier/register_supplier_bloc.dart';
import 'package:esmp_supplier/src/bloc/verify/time/cubit/timer_cubit.dart';
import 'package:esmp_supplier/src/bloc/verify/verify_bloc.dart';
import 'package:esmp_supplier/src/page/auth/register_page.dart';
import 'package:esmp_supplier/src/page/auth/register_supplier_page.dart';
import 'package:esmp_supplier/src/page/auth/verify_page.dart';
import 'package:esmp_supplier/src/page/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/login/login_bloc.dart';
import '../page/auth/login_page.dart';
import '../page/home_page.dart';
import 'app_router_constants.dart';

class AppRouter {
  static final AuthBloc _auth = AuthBloc()..add(AppLoaded());
  GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          name: AppRouterConstants.homeRouteName,
          pageBuilder: (context, state) {
            return MaterialPage(
                child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => _auth,
                )
              ],
              child: const HomePage(),
            ));
            // return const MaterialPage(
            //     child: RegisterSupplierPage(firebaseToken: 'firebaseToken'));
          },
          routes: <GoRoute>[
            GoRoute(
              path: AppRouterConstants.loginRouteName,
              name: AppRouterConstants.loginRouteName,
              pageBuilder: (context, state) {
                return MaterialPage(
                  child: BlocProvider<LoginBloc>(
                    create: (context) => LoginBloc(),
                    child: const LoginPage(),
                  ),
                );
              },
            ),
            GoRoute(
              path: AppRouterConstants.registerRouteName,
              name: AppRouterConstants.registerRouteName,
              pageBuilder: (context, state) {
                return MaterialPage(
                  child: BlocProvider<RegisterBloc>(
                    create: (context) => RegisterBloc(),
                    child: const RegisterPage(),
                  ),
                );
              },
            ),
            GoRoute(
              path: AppRouterConstants.registerSupplierRouteName,
              name: AppRouterConstants.registerSupplierRouteName,
              pageBuilder: (context, state) {
                String? firebaseToken = state.queryParams['firebaseToken'];
                String? uid = state.queryParams['uid'];
                String? phone = state.queryParams['phone'];
                if (firebaseToken == null || uid == null || phone == null) {
                  return const MaterialPage(
                      child: ErrorPage(errorMessage: '404'));
                } else {
                  return MaterialPage(
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => RegisterSupplierBloc()
                            ..add(RegisterSupplierInit()),
                        ),
                        BlocProvider(
                          create: (context) => _auth,
                        )
                      ],
                      child: RegisterSupplierPage(
                        firebaseToken: firebaseToken,
                        phone: phone,
                        uid: uid,
                      ),
                    ),
                  );
                }
              },
            ),
            GoRoute(
              path: AppRouterConstants.verifyRouteName,
              name: AppRouterConstants.verifyRouteName,
              pageBuilder: (context, state) {
                String? verificationId = state.queryParams['verificationId'];
                String? isLogin = state.queryParams['isLogin'];
                String? phone = state.queryParams['phone'];
                if (verificationId == null ||
                    isLogin == null ||
                    phone == null) {
                  return const MaterialPage(
                      child: ErrorPage(errorMessage: '404'));
                } else {
                  try {
                    return MaterialPage(
                      child: MultiBlocProvider(
                        providers: [
                          //
                          BlocProvider(
                            create: (context) => _auth,
                          ),
                          BlocProvider(
                            create: (context) => VerifyBloc(),
                          ),
                          BlocProvider(
                            create: (context) {
                              return TimerCubit()..startTimer(60);
                            },
                          )
                        ],
                        child: VerifyPage(
                            isLogin: isLogin == 'true',
                            verificationId: verificationId,
                            phone: phone),
                      ),
                    );
                  } catch (e) {
                    return MaterialPage(
                        child: ErrorPage(errorMessage: e.toString()));
                  }
                }
              },
            ),
          ]),
    ],
  );
}

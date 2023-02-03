import 'package:esmp_supplier/src/bloc/bloc/register_bloc.dart';
import 'package:esmp_supplier/src/bloc/verify/verify_bloc.dart';
import 'package:esmp_supplier/src/page/auth/register_page.dart';
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
  GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          name: AppRouterConstants.homeRouteName,
          pageBuilder: (context, state) {
            return const MaterialPage(child: HomePage());
          },
          routes: <GoRoute>[
            GoRoute(
              path: AppRouterConstants.loginRouteName,
              name: AppRouterConstants.loginRouteName,
              pageBuilder: (context, state) {
                return MaterialPage(
                  child: BlocProvider(
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
                  child: BlocProvider(
                    create: (context) => RegisterBloc(),
                    child: const RegisterPage(),
                  ),
                );
              },
            ),
            GoRoute(
              path: AppRouterConstants.verifyRouteName,
              name: AppRouterConstants.verifyRouteName,
              pageBuilder: (context, state) {
                String? verificationId = state.queryParams['verificationId'];
                String? isLogin = state.queryParams['isLogin'];
                if (verificationId == null || isLogin == null) {
                  return const MaterialPage(
                      child: ErrorPage(errorMessage: '404'));
                } else {
                  try {
                    return MaterialPage(
                      child: BlocProvider(
                        create: (context) => VerifyBloc(),
                        child: VerifyPage(
                            isLogin: isLogin as bool,
                            verificationId: verificationId),
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

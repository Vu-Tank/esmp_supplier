import 'dart:developer';

import 'package:esmp_supplier/src/bloc/auth/auth_bloc.dart';
import 'package:esmp_supplier/src/bloc/register/register_bloc.dart';
import 'package:esmp_supplier/src/bloc/register_store/register_store_bloc.dart';
import 'package:esmp_supplier/src/bloc/register_supplier/register_supplier_bloc.dart';
import 'package:esmp_supplier/src/bloc/verify/time/cubit/timer_cubit.dart';
import 'package:esmp_supplier/src/bloc/verify/verify_bloc.dart';
import 'package:esmp_supplier/src/cubit/image/pick_image_cubit.dart';
import 'package:esmp_supplier/src/cubit/province/province_cubit.dart';
import 'package:esmp_supplier/src/page/auth/register_page.dart';
import 'package:esmp_supplier/src/page/auth/register_supplier_page.dart';
import 'package:esmp_supplier/src/page/auth/verify_page.dart';
import 'package:esmp_supplier/src/page/error_page.dart';
import 'package:esmp_supplier/src/page/store/register_store_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/login/login_bloc.dart';
import '../cubit/district/district_cubit.dart';
import '../cubit/ward/ward_cubit.dart';
import '../page/auth/login_page.dart';
import '../page/home_page.dart';
import 'app_router_constants.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          name: AppRouterConstants.homeRouteName,
          builder: (context, state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>.value(
                  value: BlocProvider.of<AuthBloc>(context),
                )
              ],
              child: const HomePage(),
            );
          },
          routes: <GoRoute>[
            //login
            GoRoute(
              path: AppRouterConstants.loginRouteName,
              name: AppRouterConstants.loginRouteName,
              builder: (context, state) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => LoginBloc(),
                    ),
                    BlocProvider<AuthBloc>.value(
                      value: BlocProvider.of<AuthBloc>(context),
                    )
                  ],
                  child: const LoginPage(),
                );
              },
            ),
            //register
            GoRoute(
              path: AppRouterConstants.registerRouteName,
              name: AppRouterConstants.registerRouteName,
              builder: (context, state) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<RegisterBloc>(
                      create: (context) => RegisterBloc(),
                    ),
                    BlocProvider<AuthBloc>.value(
                      value: BlocProvider.of<AuthBloc>(context),
                    )
                  ],
                  child: const RegisterPage(),
                );
              },
            ),
            //register supplier
            GoRoute(
              path: AppRouterConstants.registerSupplierRouteName,
              name: AppRouterConstants.registerSupplierRouteName,
              builder: (context, state) {
                String? firebaseToken = state.queryParams['firebaseToken'];
                String? uid = state.queryParams['uid'];
                String? phone = state.queryParams['phone'];
                if (firebaseToken == null || uid == null || phone == null) {
                  return const ErrorPage(errorMessage: '404');
                } else {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            RegisterSupplierBloc()..add(RegisterSupplierInit()),
                      ),
                      BlocProvider(
                        create: (context) => DistrictCubit(),
                      ),
                      BlocProvider<AuthBloc>.value(
                        value: BlocProvider.of<AuthBloc>(context),
                      ),
                      BlocProvider(
                        create: (context) => WardCubit(),
                      ),
                    ],
                    child: RegisterSupplierPage(
                      firebaseToken: firebaseToken,
                      phone: phone,
                      uid: uid,
                    ),
                  );
                }
              },
            ),
            //VE
            GoRoute(
              path: AppRouterConstants.verifyRouteName,
              name: AppRouterConstants.verifyRouteName,
              builder: (context, state) {
                String? verificationId = state.queryParams['verificationId'];
                String? isLogin = state.queryParams['isLogin'];
                String? phone = state.queryParams['phone'];
                if (verificationId == null ||
                    isLogin == null ||
                    phone == null) {
                  return const ErrorPage(errorMessage: '404');
                } else {
                  try {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<AuthBloc>.value(
                          value: BlocProvider.of<AuthBloc>(context),
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
                    );
                  } catch (e) {
                    return ErrorPage(errorMessage: e.toString());
                  }
                }
              },
            ),
            GoRoute(
              path: AppRouterConstants.registerStore,
              name: AppRouterConstants.registerStore,
              builder: (context, state) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => RegisterStoreBloc(),
                    ),
                    BlocProvider(
                      create: (context) => PickImageCubit(),
                    ),
                    BlocProvider<AuthBloc>.value(
                      value: BlocProvider.of<AuthBloc>(context),
                    ),
                    BlocProvider(
                      create: (context) => ProvinceCubit()..loadProvince(),
                    ),
                    BlocProvider(
                      create: (context) => DistrictCubit(),
                    ),
                    BlocProvider(
                      create: (context) => WardCubit(),
                    ),
                  ],
                  child: const RegisterStorePage(),
                );
              },
            ),
          ]),
    ],
    errorBuilder: (context, state) => ErrorPage(
      errorMessage: state.error.toString(),
    ),
  );
  GoRouter getRouter() {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
            path: '/',
            name: AppRouterConstants.homeRouteName,
            builder: (context, state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<AuthBloc>.value(
                    value: BlocProvider.of<AuthBloc>(context),
                  )
                ],
                child: const HomePage(),
              );
            },
            routes: <GoRoute>[
              //login
              GoRoute(
                path: AppRouterConstants.loginRouteName,
                name: AppRouterConstants.loginRouteName,
                builder: (context, state) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => LoginBloc(),
                      ),
                      BlocProvider<AuthBloc>.value(
                        value: BlocProvider.of<AuthBloc>(context),
                      )
                    ],
                    child: const LoginPage(),
                  );
                },
              ),
              //register
              GoRoute(
                path: AppRouterConstants.registerRouteName,
                name: AppRouterConstants.registerRouteName,
                builder: (context, state) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<RegisterBloc>(
                        create: (context) => RegisterBloc(),
                      ),
                      // BlocProvider(
                      //   create: (context) => _auth,
                      // ),
                      BlocProvider<AuthBloc>.value(
                        value: BlocProvider.of<AuthBloc>(context),
                      )
                    ],
                    child: const RegisterPage(),
                  );
                },
              ),
              //register supplier
              GoRoute(
                path: AppRouterConstants.registerSupplierRouteName,
                name: AppRouterConstants.registerSupplierRouteName,
                builder: (context, state) {
                  String? firebaseToken = state.queryParams['firebaseToken'];
                  String? uid = state.queryParams['uid'];
                  String? phone = state.queryParams['phone'];
                  if (firebaseToken == null || uid == null || phone == null) {
                    return const ErrorPage(errorMessage: '404');
                  } else {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => RegisterSupplierBloc()
                            ..add(RegisterSupplierInit()),
                        ),
                        BlocProvider(
                          create: (context) => DistrictCubit(),
                        ),
                        BlocProvider<AuthBloc>.value(
                          value: BlocProvider.of<AuthBloc>(context),
                        ),
                        BlocProvider(
                          create: (context) => WardCubit(),
                        ),
                      ],
                      child: RegisterSupplierPage(
                        firebaseToken: firebaseToken,
                        phone: phone,
                        uid: uid,
                      ),
                    );
                  }
                },
              ),
              //VE
              GoRoute(
                path: AppRouterConstants.verifyRouteName,
                name: AppRouterConstants.verifyRouteName,
                builder: (context, state) {
                  String? verificationId = state.queryParams['verificationId'];
                  String? isLogin = state.queryParams['isLogin'];
                  String? phone = state.queryParams['phone'];
                  if (verificationId == null ||
                      isLogin == null ||
                      phone == null) {
                    return ErrorPage(errorMessage: '404');
                  } else {
                    try {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider<AuthBloc>.value(
                            value: BlocProvider.of<AuthBloc>(context),
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
                      );
                    } catch (e) {
                      return ErrorPage(errorMessage: e.toString());
                    }
                  }
                },
              ),
              GoRoute(
                path: AppRouterConstants.registerStore,
                name: AppRouterConstants.registerStore,
                builder: (context, state) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => RegisterStoreBloc(),
                      ),
                      BlocProvider(
                        create: (context) => PickImageCubit(),
                      ),
                      BlocProvider<AuthBloc>.value(
                        value: BlocProvider.of<AuthBloc>(context),
                      ),
                      BlocProvider(
                        create: (context) => ProvinceCubit()..loadProvince(),
                      ),
                      BlocProvider(
                        create: (context) => DistrictCubit(),
                      ),
                      BlocProvider(
                        create: (context) => WardCubit(),
                      ),
                    ],
                    child: const RegisterStorePage(),
                  );
                },
              ),
            ]),
      ],
      errorBuilder: (context, state) => ErrorPage(
        errorMessage: state.error.toString(),
      ),
    );
  }
}

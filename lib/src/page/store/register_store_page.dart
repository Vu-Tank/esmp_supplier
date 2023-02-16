import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:esmp_supplier/src/bloc/auth/auth_bloc.dart';
import 'package:esmp_supplier/src/bloc/register_store/register_store_bloc.dart';
import 'package:esmp_supplier/src/cubit/image/pick_image_cubit.dart';
import 'package:esmp_supplier/src/cubit/province/province_cubit.dart';
import 'package:esmp_supplier/src/model/address/district.dart';
import 'package:esmp_supplier/src/model/address/province.dart';
import 'package:esmp_supplier/src/model/address/ward.dart';
import 'package:esmp_supplier/src/model/user.dart';
import 'package:esmp_supplier/src/router/app_router_constants.dart';
import 'package:esmp_supplier/src/utils/app_style.dart';
import 'package:esmp_supplier/src/utils/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubit/district/district_cubit.dart';
import '../../cubit/ward/ward_cubit.dart';

class RegisterStorePage extends StatefulWidget {
  const RegisterStorePage({super.key});

  @override
  State<RegisterStorePage> createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  final TextEditingController _storeName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  Province? _province;
  District? _district;
  Ward? _ward;
  XFile? _image;
  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AuthState state = context.read<AuthBloc>().state;
      if (state is AuthNotAuthenticated) {
        GoRouter.of(context).push(AppRouterConstants.loginRouteName);
      } else if (state is AuthAuthenticated) {
        user = state.user;
        inspect(user);
      }
    });
  }

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
      body: Center(
          child: SingleChildScrollView(
        child: BlocConsumer<RegisterStoreBloc, RegisterStoreState>(
          listener: (context, state) {
            if (state is RegisterStoreFailed && state.msg != null) {
              MyDialog.showSnackBar(context, state.msg!);
            }
          },
          builder: (context, state) {
            return BlocBuilder<ProvinceCubit, ProvinceState>(
              builder: (context, provinceState) {
                if (provinceState is ProvinceLoaded) {
                  _province ??= provinceState.province.first;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        //image
                        Container(
                          height: 350,
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: BlocBuilder<PickImageCubit, PickImageState>(
                            builder: (context, state) {
                              if (state is PickImageing) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is PickImageFailed) {
                                return Center(
                                  child: Text(
                                    state.msg,
                                    style: AppStyle.errorStyle,
                                  ),
                                );
                              } else if (state is PickImageSuccess) {
                                _image ??= state.image;
                                return Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [
                                    SizedBox(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: Image.memory(
                                        state.data,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<PickImageCubit>()
                                            .pickImage();
                                      },
                                      style: AppStyle.myButtonStyle,
                                      child: Text(
                                        'Chọn lại',
                                        style: AppStyle.h2
                                            .copyWith(color: Colors.white),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return dottedBroder(color: AppStyle.appColor);
                              }
                            },
                          ),
                        ),
                        // store name
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: _storeName,
                          textAlign: TextAlign.left,
                          style: AppStyle.h2,
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.store),
                            errorText: (state is RegisterStoreFailed &&
                                    state.storeNameError != null)
                                ? state.storeNameError
                                : null,
                            errorStyle:
                                AppStyle.errorStyle.copyWith(fontSize: 15),
                            label: Text(
                              'Tên cửa hàng',
                              style: AppStyle.h2,
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        //email
                        TextField(
                          controller: _email,
                          textAlign: TextAlign.left,
                          style: AppStyle.h2,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail),
                            label: Text(
                              'Email',
                              style: AppStyle.h2,
                            ),
                            errorText: (state is RegisterStoreFailed &&
                                    state.emailError != null)
                                ? state.emailError
                                : null,
                            errorStyle:
                                AppStyle.errorStyle.copyWith(fontSize: 15),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Địa chỉ cửa hàng',
                          style: AppStyle.h2,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Column(
                          children: <Widget>[
                            //tinh
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: DropdownButtonFormField(
                                value: _province,
                                icon: const Icon(Icons.arrow_downward),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(40)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppStyle.appColor, width: 2),
                                      borderRadius: BorderRadius.circular(40)),
                                ),
                                borderRadius: BorderRadius.circular(20),
                                isExpanded: true,
                                elevation: 16,
                                style: AppStyle.h2,
                                onChanged: (Province? value) {
                                  if (value != null) {
                                    setState(() {
                                      _province = value;
                                      if (value.key != '-1') {
                                        context
                                            .read<DistrictCubit>()
                                            .selectedProvince(value.key);
                                      }
                                      _district = null;

                                      _ward = null;
                                    });
                                  }
                                },
                                items: provinceState.province
                                    .map<DropdownMenuItem<Province>>(
                                        (Province value) {
                                  return DropdownMenuItem<Province>(
                                    value: value,
                                    child: Text(
                                      value.value,
                                      style: AppStyle.h2,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            // quan
                            if (_province != null && _province!.key != '-1')
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child:
                                    BlocBuilder<DistrictCubit, DistrictState>(
                                  builder: (context, state) {
                                    if (state is DistrictError) {
                                      return Center(
                                        child: Text(
                                          state.msg,
                                          style: AppStyle.h2
                                              .copyWith(color: Colors.red),
                                        ),
                                      );
                                    } else if (state is DistrictLoaded) {
                                      _district =
                                          _district ?? state.districts.first;
                                      return DropdownButtonFormField(
                                        value: _district,
                                        icon: const Icon(Icons.arrow_downward),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey, width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppStyle.appColor,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                        isExpanded: true,
                                        elevation: 16,
                                        style: AppStyle.h2,
                                        onChanged: (District? value) {
                                          if (value != null) {
                                            setState(() {
                                              _district = value;
                                              if (value.key != '-1') {
                                                context
                                                    .read<WardCubit>()
                                                    .selectDistrict(value.key);
                                              }
                                              _ward = null;
                                            });
                                          }
                                        },
                                        items: state.districts
                                            .map<DropdownMenuItem<District>>(
                                                (District value) {
                                          return DropdownMenuItem<District>(
                                            value: value,
                                            child: Text(
                                              value.value,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              style: AppStyle.h2,
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            // phuong
                            if (_district != null && _district!.key != '-1')
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: BlocBuilder<WardCubit, WardState>(
                                  builder: (context, wardState) {
                                    if (wardState is WardError) {
                                      return Center(
                                        child: Text(
                                          wardState.msg,
                                          style: AppStyle.h2
                                              .copyWith(color: Colors.red),
                                        ),
                                      );
                                    } else if (wardState is WardLoaded) {
                                      _ward ??= wardState.ward.first;
                                      return DropdownButtonFormField(
                                        value: _ward,
                                        icon: const Icon(Icons.arrow_downward),
                                        isExpanded: true,
                                        elevation: 16,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey, width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppStyle.appColor,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                        style: AppStyle.h2,
                                        onChanged: (Ward? value) {
                                          setState(() {
                                            _ward = value;
                                          });
                                        },
                                        items: wardState.ward
                                            .map<DropdownMenuItem<Ward>>(
                                                (Ward value) {
                                          return DropdownMenuItem<Ward>(
                                            value: value,
                                            child: Text(
                                              value.value,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              style: AppStyle.h2,
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            if (_ward != null && _ward!.key != '-1')
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TextField(
                                  controller: _address,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.h2,
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.location_on),
                                    label: Text(
                                      'Địa chỉ (số nhà, tên đường)',
                                      style: AppStyle.h2,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            (state is RegisterStoreFailed &&
                                    state.addressError != null)
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      state.addressError!,
                                      style: AppStyle.errorStyle
                                          .copyWith(fontSize: 15),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        SizedBox(
                          height: 56.0,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (state is RegisterStoreing)
                                  ? null
                                  : () {
                                      context.read<RegisterStoreBloc>().add(
                                          RegisterStorePressed(
                                              storeName: _storeName.text.trim(),
                                              email: _email.text.trim(),
                                              contextAddress:
                                                  _address.text.trim(),
                                              userID: user.userID,
                                              token: user.token,
                                              phone: user.phone,
                                              uid: user.firebaseID,
                                              image: _image,
                                              province: _province,
                                              district: _district,
                                              ward: _ward,
                                              onSuccess: () {}));
                                    },
                              style: AppStyle.myButtonStyle,
                              child: (state is RegisterStoreing)
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Tạo cửa hàng',
                                      style: AppStyle.buttom,
                                    )),
                        )
                      ],
                    ),
                  );
                } else if (provinceState is ProvinceError) {
                  return Text(
                    provinceState.msg,
                    style: AppStyle.h2.copyWith(color: Colors.red),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      )),
    );
  }

  Widget dottedBroder({required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        color: color,
        dashPattern: const [6.7],
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  color: color,
                  size: 50,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton(
                    onPressed: () {
                      context.read<PickImageCubit>().pickImage();
                    },
                    child: Text(
                      'Chọn ảnh',
                      style: AppStyle.h2,
                    ))
              ]),
        ),
      ),
    );
  }
}

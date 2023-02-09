import 'dart:developer';

import 'package:esmp_supplier/src/bloc/auth/auth_bloc.dart';
import 'package:esmp_supplier/src/bloc/register_supplier/register_supplier_bloc.dart';
import 'package:esmp_supplier/src/model/address/district.dart';
import 'package:esmp_supplier/src/model/address/province.dart';
import 'package:esmp_supplier/src/model/address/ward.dart';
import 'package:esmp_supplier/src/model/user.dart';
import 'package:esmp_supplier/src/utils/app_constants.dart';
import 'package:esmp_supplier/src/utils/app_style.dart';
import 'package:esmp_supplier/src/utils/my_dialog.dart';
import 'package:esmp_supplier/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterSupplierPage extends StatefulWidget {
  const RegisterSupplierPage(
      {super.key,
      required this.firebaseToken,
      required this.phone,
      required this.uid});
  final String firebaseToken;
  final String phone;
  final String uid;
  @override
  State<RegisterSupplierPage> createState() => _RegisterSupplierPageState();
}

class _RegisterSupplierPageState extends State<RegisterSupplierPage> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  DateTime? _dob;
  Province? _province;
  District? _district;
  Ward? _ward;
  String? _gender;
  bool? _isOk = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đăng ký',
          style: AppStyle.apptitle,
        ),
        centerTitle: true,
        backgroundColor: AppStyle.appColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: BlocConsumer<RegisterSupplierBloc, RegisterSupplierState>(
              listener: (context, state) {
                if (state is RegisterSupplierFailed && state.msg != null) {
                  MyDialog.showSnackBar(context, state.msg!);
                }
              },
              builder: (context, state) {
                if (state is RegisterSupplierloading) {
                  return const CircularProgressIndicator();
                } else {
                  _gender = _gender ?? state.genders!.first;
                  _province = _province ?? state.provinces!.first;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox.fromSize(
                          size: const Size.fromRadius(100),
                          child: Image.network(
                            AppConstants.defaultAvatar,
                            fit: BoxFit.cover,
                          )),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: _fullName,
                        textAlign: TextAlign.left,
                        style: AppStyle.h2,
                        maxLines: 1,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          errorText: (state is RegisterSupplierFailed &&
                                  state.fullNameError != null)
                              ? state.fullNameError
                              : null,
                          errorStyle:
                              AppStyle.errorStyle.copyWith(fontSize: 15),
                          label: Text(
                            'Họ và tên',
                            style: AppStyle.h2,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      // (state is RegisterSupplierFailed &&
                      //         state.fullNameError != null)
                      //     ? Padding(
                      //         padding: const EdgeInsets.only(top: 8.0),
                      //         child: Text(
                      //           state.fullNameError!,
                      //           style: AppStyle.errorStyle,
                      //         ),
                      //       )
                      //     : Container(),
                      const SizedBox(
                        height: 8.0,
                      ),
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
                          errorText: (state is RegisterSupplierFailed &&
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
                      Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (state is RegisterSupplierFailed &&
                                        state.dobError != null)
                                    ? Colors.red
                                    : Colors.black)),
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 8.0,
                              ),
                              const Icon(
                                Icons.cake,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'Ngày sinh',
                                style: AppStyle.h2,
                              ),
                              if (_dob != null)
                                Text(
                                  ': ${Utils.convertDateTimeToString(_dob!)}',
                                  style: AppStyle.h2,
                                ),
                              (state is RegisterSupplierFailed &&
                                      state.dobError != null)
                                  ? Text(
                                      state.dobError!,
                                      style: AppStyle.errorStyle
                                          .copyWith(fontSize: 15),
                                    )
                                  : Container(),
                            ],
                          ),
                          onTap: () async {
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime(DateTime.now().year - 14,
                                  DateTime.now().month, DateTime.now().day),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(DateTime.now().year + 1),
                              helpText: 'Ngày sinh',
                              selectableDayPredicate: (DateTime? date) {
                                if (DateTime.now().year - date!.year >= 14) {
                                  if (DateTime.now().year - date.year == 14 &&
                                      DateTime.now().month < date.month) {
                                    return false;
                                  } else if (DateTime.now().year - date.year ==
                                          14 &&
                                      DateTime.now().month == date.month &&
                                      DateTime.now().day < date.day) {
                                    return false;
                                  }
                                  return true;
                                }
                                return false;
                              },
                            ).then((value) {
                              setState(() {
                                _dob = value;
                              });
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      //gioi tinh
                      SizedBox(
                        height: 56,
                        width: double.infinity,
                        // decoration:
                        //     BoxDecoration(border: Border.all(color: Colors.black)),
                        child: Row(
                          children: <Widget>[
                            Text("Giới tính", style: AppStyle.h2),
                            SizedBox(
                              width: width * 1 / 5,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                value: _gender,
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
                                elevation: 16,
                                style: AppStyle.h2,
                                onChanged: (String? value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                                items: state.genders!
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: AppStyle.h2,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // địa chỉ
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
                                    if (value.code != '-1') {
                                      _district = _province!.listDistrict.first;
                                    } else {
                                      _district = null;
                                    }
                                    _ward = null;
                                  });
                                }
                              },
                              items: state.provinces!
                                  .map<DropdownMenuItem<Province>>(
                                      (Province value) {
                                return DropdownMenuItem<Province>(
                                  value: value,
                                  child: Text(
                                    value.name,
                                    style: AppStyle.h2,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          // quan
                          if (_province != null && _province!.code != '-1')
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: DropdownButtonFormField(
                                value: _district,
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
                                isExpanded: true,
                                elevation: 16,
                                style: AppStyle.h2,
                                onChanged: (District? value) {
                                  if (value != null) {
                                    setState(() {
                                      _district = value;
                                      if (value.code != '-1') {
                                        _ward = value.listWard.first;
                                      } else {
                                        _ward = null;
                                      }
                                    });
                                  }
                                },
                                items: _province!.listDistrict
                                    .map<DropdownMenuItem<District>>(
                                        (District value) {
                                  return DropdownMenuItem<District>(
                                    value: value,
                                    child: Text(
                                      value.name_with_type,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: AppStyle.h2,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          // phuong
                          if (_district != null && _district!.code != '-1')
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: DropdownButtonFormField(
                                value: _ward,
                                icon: const Icon(Icons.arrow_downward),
                                isExpanded: true,
                                elevation: 16,
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
                                style: AppStyle.h2,
                                onChanged: (Ward? value) {
                                  setState(() {
                                    _ward = value;
                                  });
                                },
                                items: _district!.listWard
                                    .map<DropdownMenuItem<Ward>>((Ward value) {
                                  return DropdownMenuItem<Ward>(
                                    value: value,
                                    child: Text(
                                      value.name_with_type,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: AppStyle.h2,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          if (_ward != null && _ward!.code != '-1')
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
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          (state is RegisterSupplierFailed &&
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
                      //checkbox
                      const SizedBox(
                        height: 8.0,
                      ),
                      CheckboxListTile(
                        value: _isOk,
                        onChanged: (value) {
                          setState(() {
                            _isOk = value;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Row(
                          children: <Widget>[
                            Text(
                              'Đồng ý với các ',
                              style: AppStyle.h2,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Điều khoản',
                                  style:
                                      AppStyle.h2.copyWith(color: Colors.blue),
                                )),
                            Text(
                              ' của ESMP',
                              style: AppStyle.h2,
                            ),
                          ],
                        ),
                      ),
                      (state is RegisterSupplierFailed &&
                              state.agreeError != null)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                state.agreeError!,
                                style:
                                    AppStyle.errorStyle.copyWith(fontSize: 15),
                              ),
                            )
                          : Container(),
                      //buttom
                      const SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        height: 56.0,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (state is RegisterSuppliering)
                              ? null
                              : () => context
                                  .read<RegisterSupplierBloc>()
                                  .add(RegisterSupplierPressed(
                                    fullName: _fullName.text.trim(),
                                    email: _email.text.trim(),
                                    dob: _dob,
                                    address: _address.text.trim(),
                                    gender: _gender!,
                                    province: _province!,
                                    district: _district,
                                    ward: _ward,
                                    isAgree: _isOk!,
                                    token: widget.firebaseToken,
                                    phone: widget.phone,
                                    uid: widget.uid,
                                    onSuccess: (User user) {
                                      context
                                          .read<AuthBloc>()
                                          .add(UserLoggedIn(user: user));
                                    },
                                  )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppStyle.appColor,
                            disabledBackgroundColor:
                                AppStyle.appColor.withOpacity(0.2),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          child: (state is RegisterSuppliering)
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Đăng ký',
                                  style: AppStyle.buttom,
                                ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          )),
        ),
      ),
    );
  }
}

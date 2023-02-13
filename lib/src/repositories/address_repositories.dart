import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/address/district.dart';
import '../model/address/province.dart';
import '../model/address/ward.dart';

class AddressRepository {
  static Future<List<Province>> getProvince() async {
    List<Province> list = [];
    try {
      var data =
          await rootBundle.loadString('assets/hanh_chinh_vn/tinh_tp_full.json');
      var body = json.decode(data);
      Map<String, dynamic> map = Map.from(body);
      list.add(Province(
          name: 'Chọn Tỉnh/thành phố',
          slug: 'chon tinh',
          type: 'tinh',
          name_with_type: 'Chọn tỉnh',
          code: '-1',
          listDistrict: []));
      await Future.forEach(map.values, (element) async {
        Province province = await Province.fromJson(element);
        list.add(province);
      });
    } catch (e) {
      rethrow;
    }
    return list;
  }

  static Future<List<District>> getDistrict(String provinceCode) async {
    List<District> list = [
      District(
          name: 'Chọn Quận/huyện',
          type: "",
          name_with_type: "Chọn Quận/huyện",
          code: "-1",
          path_with_type: "",
          listWard: [])
    ];
    try {
      var data = await rootBundle
          .loadString('assets/hanh_chinh_vn/quan_huyen/$provinceCode.json');
      var body = json.decode(data);
      Map<String, dynamic> map = Map.from(body);
      await Future.forEach(map.values, (element) async {
        District district = await District.fromJson(element);
        list.add(district);
      });
    } catch (e) {
      rethrow;
    }
    return list;
  }

  static Future<List<Ward>> getWard(String districtCode) async {
    List<Ward> list = [
      Ward(
          name: 'Chọn Phường/xã',
          type: "",
          name_with_type: "Chọn Phường/xã",
          path_with_type: "",
          code: '-1')
    ];
    try {
      var data = await rootBundle
          .loadString('assets/hanh_chinh_vn/xa_phuong/$districtCode.json');
      var body = json.decode(data);
      Map<String, dynamic> map = Map.from(body);
      map.forEach((key, value) {
        list.add(Ward.fromJson(value));
      });
    } catch (e) {
      rethrow;
    }
    return list;
  }
}

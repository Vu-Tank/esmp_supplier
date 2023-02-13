import 'dart:convert';

import 'package:esmp_supplier/src/model/api_response.dart';
import 'package:esmp_supplier/src/repositories/api_setting.dart';
import 'package:esmp_supplier/src/repositories/app_url.dart';
import 'package:http/http.dart' as http;
import '../model/address/district.dart';
import '../model/address/province.dart';
import '../model/address/ward.dart';

class AddressRepository {
  static Future<ApiResponse> getProvince() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      // var data =
      //     await rootBundle.loadString('assets/hanh_chinh_vn/tinh_tp_full.json');
      // var body = json.decode(data);
      // Map<String, dynamic> map = Map.from(body);
      // list.add(Province(
      //     name: 'Chọn Tỉnh/thành phố',
      //     slug: 'chon tinh',
      //     type: 'tinh',
      //     name_with_type: 'Chọn tỉnh',
      //     code: '-1',
      //     listDistrict: []));
      // await Future.forEach(map.values, (element) async {
      //   Province province = await Province.fromJson(element);
      //   list.add(province);
      // });
      final response = await http.get(Uri.parse(AppUrl.province), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          List<Province> provinces = [
            Province(key: '-1', value: 'Chọn Tỉnh/thành phố')
          ];
          provinces.addAll((body['data'] as List)
              .map((model) => Province.fromMap(model))
              .toList());
          apiResponse.data = provinces;
        }
      } else {
        apiResponse.isSuccess = false;
        apiResponse.msg = json.decode(response.body)['errors'].toString();
      }
    } catch (e) {
      apiResponse.isSuccess = false;
      apiResponse.msg = e.toString();
    }
    return apiResponse;
  }

  static Future<ApiResponse> getDistrict(String provinceCode) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {'tpid': provinceCode};
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.district}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          List<District> list = [District(key: '-1', value: 'Chọn Quận/huyện')];
          list.addAll((body['data'] as List)
              .map((model) => District.fromMap(model))
              .toList());
          apiResponse.data = list;
        }
      } else {
        apiResponse.isSuccess = false;
        apiResponse.msg = json.decode(response.body)['errors'].toString();
      }
    } catch (e) {
      apiResponse.isSuccess = false;
      apiResponse.msg = e.toString();
    }
    return apiResponse;
  }

  static Future<ApiResponse> getWard(String districtCode) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {'qhid': districtCode};
      String queryString = Uri(queryParameters: queryParams).query;
      final response =
          await http.get(Uri.parse('${AppUrl.ward}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          List<Ward> list = [Ward(key: '-1', value: 'Chọn Phường/xã')];
          list.addAll((body['data'] as List)
              .map((model) => Ward.fromMap(model))
              .toList());
          apiResponse.data = list;
        }
      } else {
        apiResponse.isSuccess = false;
        apiResponse.msg = json.decode(response.body)['errors'].toString();
      }
    } catch (e) {
      apiResponse.isSuccess = false;
      apiResponse.msg = e.toString();
    }
    return apiResponse;
  }
}

import 'dart:convert';

import 'package:esmp_supplier/src/model/api_response.dart';

import 'package:http/http.dart' as http;

import 'api_setting.dart';
import 'app_url.dart';

class SystemRepositories {
  static Future<ApiResponse> getPriceActice() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response =
          await http.get(Uri.parse(AppUrl.getPriceActice), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = body['data'] as double;
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

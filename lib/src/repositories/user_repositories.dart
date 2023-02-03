import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/api_response.dart';
import 'api_setting.dart';
import 'app_url.dart';

class UserRepositories {
  static Future<ApiResponse> checkUserExist({required String phone}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {'phone': phone, 'roleID': '2'};
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .post(Uri.parse('${AppUrl.checkExistUser}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
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

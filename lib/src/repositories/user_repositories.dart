import 'dart:convert';
import 'dart:developer';

import 'package:esmp_supplier/src/model/user.dart';
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

  static Future<ApiResponse> supplierRegister(
      {required String token,
      required String fullName,
      required String email,
      required String phone,
      required String imageName,
      required String imagepath,
      required String contextAddress,
      required String dateOfBirth,
      required String gender,
      required double latitude,
      required double longitude,
      required String province,
      required String district,
      required String ward,
      required String firebaseID,
      required String fcMFirebase}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(
        Uri.parse(AppUrl.supplierRegister),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "userName": fullName,
          "email": email,
          "phone": phone,
          "imageName": imageName,
          "imagepath": imagepath,
          "contextAddress": contextAddress,
          "dateOfBirth": dateOfBirth,
          "gender": gender,
          "latitude": latitude,
          "longitude": longitude,
          "province": province,
          "district": district,
          "ward": ward,
          "firebaseID": firebaseID,
          "fcM_Firebase": fcMFirebase,
        }),
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = User.fromMap(body['data']);
          inspect(body['data']);
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

  static Future<ApiResponse> login(
      {required String phone,
      required String fcM_Firebase,
      required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {'phone': phone, 'fcM_Firebase': fcM_Firebase};
      // String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .post(Uri.parse(AppUrl.login),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(queryParams))
          .timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = User.fromMap(body['data']);
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

  static Future<ApiResponse> refeshToken(
      {required int userID, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'userID': userID.toString(),
        "token": token,
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var response = await http.post(
        Uri.parse('${AppUrl.refeshtoken}?$queryString'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = User.fromMap(body['data']);
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

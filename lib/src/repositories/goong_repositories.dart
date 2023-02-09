import 'package:esmp_supplier/src/model/address/goong_address.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GoongRepositories {
  final String _key = "JPqKdDZwdTYCSC4lYyqGyYgCmQk7nTtqnp7galEn";
  Future<String?> getPlaceIdFromText(String input) async {
    String? placeID;
    String url =
        'https://rsapi.goong.io/Place/AutoComplete?api_key=$_key&input=$input&radius=50';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      if (json['status'].toString() == "OK") {
        placeID = json['predictions'][0]['place_id'] as String;
      }
    }
    return placeID;
  }

  Future<String?> getPlaceIdFromLoation(double lat, double lng) async {
    String? placeID;
    String url =
        'https://rsapi.goong.io/Geocode?latlng=$lat,%20$lng&api_key=$_key';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      if (json['status'].toString() == "OK") {
        // var jsons=json['results'] as List;
        // if(jsons.length>1) {
        //   placeID=json['results'][1]['place_id'];
        // } else {
        placeID = json['results'][0]['place_id'];
        // }
      }
    }
    return placeID;
  }

  Future<GoongAddress?> getPlace(String placeId) async {
    GoongAddress? result;
    final String url =
        'https://rsapi.goong.io/Place/Detail?place_id=$placeId&api_key=$_key';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      if (json['status'] == 'OK') {
        result = GoongAddress.fromJson(json['result']);
      }
    }
    return result;
  }
}

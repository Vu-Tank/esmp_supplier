// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:esmp_supplier/src/model/address/ward.dart';

import '../../repositories/address_repositories.dart';

class District {
  String name;
  String type;
  String name_with_type;
  String code;
  String path_with_type;
  List<Ward> listWard;
  District(
      {required this.name,
      required this.type,
      required this.name_with_type,
      required this.code,
      required this.path_with_type,
      required this.listWard});

  static Future<District> fromJson(Map<String, dynamic> json) async {
    String districtCode = json['code'];
    List<Ward> listWard = await AddressRepository.getWard(districtCode);
    // log(listWard.length.toString());
    return District(
      name: json['name'],
      type: json['type'],
      name_with_type: json['name_with_type'],
      code: json['code'],
      path_with_type: json['path_with_type'],
      listWard: listWard,
    );
  }

  @override
  String toString() {
    return 'District(name: $name, type: $type, name_with_type: $name_with_type, code: $code, path_with_type: $path_with_type, listWard: $listWard)';
  }
}

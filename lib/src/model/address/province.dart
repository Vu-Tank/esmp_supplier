// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:esmp_supplier/src/model/address/district.dart';

import '../../repositories/address_repositories.dart';

class Province {
  String name;
  String slug;
  String type;
  String name_with_type;
  String code;
  List<District> listDistrict;

  Province(
      {required this.name,
      required this.slug,
      required this.type,
      required this.name_with_type,
      required this.code,
      required this.listDistrict});

  static Future<Province> fromJson(Map<String, dynamic> json) async {
    String code = json['code'];
    List<District> listDistrict = await AddressRepository.getDistrict(code);
    // log(listDistrict.toString());
    return Province(
      name: json['name'],
      slug: json['slug'],
      type: json['type'],
      name_with_type: json['name_with_type'],
      code: json['code'],
      listDistrict: listDistrict,
    );
  }

  @override
  String toString() {
    return 'Province(name: $name, slug: $slug, type: $type, name_with_type: $name_with_type, code: $code, listDistrict: $listDistrict)';
  }
}

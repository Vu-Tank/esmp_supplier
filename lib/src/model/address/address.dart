import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Adderss {
  final int addressID;
  final String userName;
  final String phone;
  final String context;
  final String province;
  final String district;
  final String ward;
  final double latitude;
  final double longitude;
  final bool isActive;
  Adderss({
    required this.addressID,
    required this.userName,
    required this.phone,
    required this.context,
    required this.province,
    required this.district,
    required this.ward,
    required this.latitude,
    required this.longitude,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressID': addressID,
      'userName': userName,
      'phone': phone,
      'context': context,
      'province': province,
      'district': district,
      'ward': ward,
      'latitude': latitude,
      'longitude': longitude,
      'isActive': isActive,
    };
  }

  factory Adderss.fromMap(Map<String, dynamic> map) {
    return Adderss(
      addressID: map['addressID'] as int,
      userName: map['userName'] as String,
      phone: map['phone'] as String,
      context: map['context'] as String,
      province: map['province'] as String,
      district: map['district'] as String,
      ward: map['ward'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Adderss.fromJson(String source) =>
      Adderss.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Adderss(addressID: $addressID, userName: $userName, phone: $phone, context: $context, province: $province, district: $district, ward: $ward, latitude: $latitude, longitude: $longitude, isActive: $isActive)';
  }
}

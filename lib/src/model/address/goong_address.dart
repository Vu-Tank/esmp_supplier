class GoongAddress {
  final String formattedAddress;
  final double lat;
  final double lng;

  GoongAddress(
      {required this.formattedAddress, required this.lat, required this.lng});

  factory GoongAddress.fromJson(Map<String, dynamic> json) {
    return GoongAddress(
        formattedAddress: json['formatted_address'] as String,
        lat: json['geometry']['location']['lat'] as double,
        lng: json['geometry']['location']['lng'] as double);
  }

  @override
  String toString() {
    return 'GoongAddress{formattedAddress: $formattedAddress, lat: $lat, lng: $lng}';
  }
}

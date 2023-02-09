// ignore_for_file: public_member_api_docs, sort_constructors_first
class Ward {
  String name;
  String type;
  String name_with_type;
  String path_with_type;
  String code;

  Ward(
      {required this.name,
      required this.type,
      required this.name_with_type,
      required this.path_with_type,
      required this.code});

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
        name: json['name'],
        type: json['type'],
        name_with_type: json['name_with_type'],
        path_with_type: json['path_with_type'],
        code: json['code']);
  }

  @override
  String toString() {
    return 'Ward(name: $name, type: $type, name_with_type: $name_with_type, path_with_type: $path_with_type, code: $code)';
  }
}

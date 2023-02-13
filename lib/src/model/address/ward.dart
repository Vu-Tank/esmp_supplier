import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// class Ward {
//   String name;
//   String type;
//   String name_with_type;
//   String path_with_type;
//   String code;

//   Ward(
//       {required this.name,
//       required this.type,
//       required this.name_with_type,
//       required this.path_with_type,
//       required this.code});

//   factory Ward.fromJson(Map<String, dynamic> json) {
//     return Ward(
//         name: json['name'],
//         type: json['type'],
//         name_with_type: json['name_with_type'],
//         path_with_type: json['path_with_type'],
//         code: json['code']);
//   }

//   @override
//   String toString() {
//     return 'Ward(name: $name, type: $type, name_with_type: $name_with_type, path_with_type: $path_with_type, code: $code)';
//   }
// }
class Ward {
  final String key;
  final String value;
  Ward({
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
    };
  }

  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      key: map['key'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ward.fromJson(String source) =>
      Ward.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Ward(key: $key, value: $value)';
}

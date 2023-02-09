import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Role {
  final int roleID;
  final String roleName;
  final bool isActive;
  Role({
    required this.roleID,
    required this.roleName,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roleID': roleID,
      'roleName': roleName,
      'isActive': isActive,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      roleID: map['roleID'] as int,
      roleName: map['roleName'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) =>
      Role.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Role(roleID: $roleID, roleName: $roleName, isActive: $isActive)';
}

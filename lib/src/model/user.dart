import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final int userID;
  final String uid;
  final String phoneNumber;
  final String? fmcToken;
  final String token;
  User({
    required this.userID,
    required this.uid,
    required this.phoneNumber,
    this.fmcToken,
    required this.token,
  });

  @override
  String toString() {
    return 'User(userID: $userID, uid: $uid, phoneNumber: $phoneNumber, fmcToken: $fmcToken, token: $token)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'fmcToken': fmcToken,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userID: map['userID'] as int,
      uid: map['uid'] as String,
      phoneNumber: map['phoneNumber'] as String,
      fmcToken: map['fmcToken'] != null ? map['fmcToken'] as String : null,
      token: map['token'] as String,
    );
  }
}

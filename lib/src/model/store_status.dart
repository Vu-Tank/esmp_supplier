import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StoreStatus {
  final int item_StatusID;
  final String statusName;
  StoreStatus({
    required this.item_StatusID,
    required this.statusName,
  });

  @override
  String toString() =>
      'StoreStatus(item_StatusID: $item_StatusID, statusName: $statusName)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_StatusID': item_StatusID,
      'statusName': statusName,
    };
  }

  factory StoreStatus.fromMap(Map<String, dynamic> map) {
    return StoreStatus(
      item_StatusID: map['item_StatusID'] as int,
      statusName: map['statusName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreStatus.fromJson(String source) =>
      StoreStatus.fromMap(json.decode(source) as Map<String, dynamic>);
}

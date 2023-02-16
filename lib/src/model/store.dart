// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:esmp_supplier/src/model/address/address.dart';
import 'package:esmp_supplier/src/model/image.dart';
import 'package:esmp_supplier/src/model/store_status.dart';

class Store {
  final int storeID;
  final String storeName;
  final String create_date;
  final String email;
  final String phone;
  final int pick_date;
  final int userID;
  final Adderss address;
  final StoreStatus store_Status;
  final Image image;
  final double asset;
  final int? momoTransactionID;
  final String actice_Date;
  final double actice_Amount;
  final String firebaseID;
  final String? fcM_Firebase;
  final int totalActiveItem;
  final int totalBlockItem;
  final int totalWatingItem;
  final int totalOrder;
  final int totalCancelOrder;
  final double totalRating;
  Store({
    required this.storeID,
    required this.storeName,
    required this.create_date,
    required this.email,
    required this.phone,
    required this.pick_date,
    required this.userID,
    required this.address,
    required this.store_Status,
    required this.image,
    required this.asset,
    required this.momoTransactionID,
    required this.actice_Date,
    required this.actice_Amount,
    required this.firebaseID,
    required this.fcM_Firebase,
    required this.totalActiveItem,
    required this.totalBlockItem,
    required this.totalWatingItem,
    required this.totalOrder,
    required this.totalCancelOrder,
    required this.totalRating,
  });

  @override
  String toString() {
    return 'Store(storeID: $storeID, storeName: $storeName, create_date: $create_date, email: $email, phone: $phone, pick_date: $pick_date, userID: $userID, address: $address, store_Status: $store_Status, image: $image, asset: $asset, momoTransactionID: $momoTransactionID, actice_Date: $actice_Date, actice_Amount: $actice_Amount, firebaseID: $firebaseID, fcM_Firebase: $fcM_Firebase, totalActiveItem: $totalActiveItem, totalBlockItem: $totalBlockItem, totalWatingItem: $totalWatingItem, totalOrder: $totalOrder, totalCancelOrder: $totalCancelOrder, totalRating: $totalRating)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storeID': storeID,
      'storeName': storeName,
      'create_date': create_date,
      'email': email,
      'phone': phone,
      'pick_date': pick_date,
      'userID': userID,
      'address': address.toMap(),
      'store_Status': store_Status.toMap(),
      'image': image.toMap(),
      'asset': asset,
      'momoTransactionID': momoTransactionID,
      'actice_Date': actice_Date,
      'actice_Amount': actice_Amount,
      'firebaseID': firebaseID,
      'fcM_Firebase': fcM_Firebase,
      'totalActiveItem': totalActiveItem,
      'totalBlockItem': totalBlockItem,
      'totalWatingItem': totalWatingItem,
      'totalOrder': totalOrder,
      'totalCancelOrder': totalCancelOrder,
      'totalRating': totalRating,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      storeID: map['storeID'] as int,
      storeName: map['storeName'] as String,
      create_date: map['create_date'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      pick_date: map['pick_date'] as int,
      userID: map['userID'] as int,
      address: Adderss.fromMap(map['address'] as Map<String, dynamic>),
      store_Status:
          StoreStatus.fromMap(map['store_Status'] as Map<String, dynamic>),
      image: Image.fromMap(map['image'] as Map<String, dynamic>),
      asset: map['asset'] as double,
      momoTransactionID: map['momoTransactionID'] != null
          ? map['momoTransactionID'] as int
          : null,
      actice_Date: map['actice_Date'] as String,
      actice_Amount: map['actice_Amount'] as double,
      firebaseID: map['firebaseID'] as String,
      fcM_Firebase:
          map['fcM_Firebase'] != null ? map['fcM_Firebase'] as String : null,
      totalActiveItem: map['totalActiveItem'] as int,
      totalBlockItem: map['totalBlockItem'] as int,
      totalWatingItem: map['totalWatingItem'] as int,
      totalOrder: map['totalOrder'] as int,
      totalCancelOrder: map['totalCancelOrder'] as int,
      totalRating: map['totalRating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) =>
      Store.fromMap(json.decode(source) as Map<String, dynamic>);
}

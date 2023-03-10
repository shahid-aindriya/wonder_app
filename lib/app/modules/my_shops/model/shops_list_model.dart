// To parse this JSON data, do
//
//     final shopsListModel = shopsListModelFromJson(jsonString);

import 'dart:convert';

ShopsListModel shopsListModelFromJson(String str) =>
    ShopsListModel.fromJson(json.decode(str));

String shopsListModelToJson(ShopsListModel data) => json.encode(data.toJson());

class ShopsListModel {
  ShopsListModel({
    required this.shopData,
  });

  List<ShopDatum> shopData;

  factory ShopsListModel.fromJson(Map<String, dynamic> json) => ShopsListModel(
        shopData: List<ShopDatum>.from(
            json["shop_data"].map((x) => ShopDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shop_data": List<dynamic>.from(shopData.map((x) => x.toJson())),
      };
}

class ShopDatum {
  ShopDatum({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.category,
    required this.gstNumber,
    required this.licenseNumber,
    required this.address,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.isFeatured,
    required this.featuredImage,
    required this.gstImage,
    required this.licenseImage,
    required this.commission,
    required this.walletAmount,
    required this.status,
    required this.gstPct,
    required this.bankData,
  });

  int id;
  String name;
  int categoryId;
  String category;
  String gstNumber;
  String licenseNumber;
  String address;
  String location;
  String latitude;
  String longitude;
  String radius;
  bool isFeatured;
  String featuredImage;
  String gstImage;
  String licenseImage;
  String commission;
  String walletAmount;
  String status;
  String gstPct;
  BankData bankData;

  factory ShopDatum.fromJson(Map<String, dynamic> json) => ShopDatum(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        category: json["category"],
        gstNumber: json["gst_number"],
        licenseNumber: json["license_number"],
        address: json["address"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        radius: json["radius"],
        isFeatured: json["is_featured"],
        featuredImage: json["featured_image"],
        gstImage: json["gst_image"],
        licenseImage: json["license_image"],
        commission: json["commission"],
        walletAmount: json["wallet_amount"],
        status: json["status"],
        gstPct: json["gst_pct"] ?? "null",
        bankData: BankData.fromJson(json["bank_data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "category": category,
        "gst_number": gstNumber,
        "license_number": licenseNumber,
        "address": address,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
        "is_featured": isFeatured,
        "featured_image": featuredImage,
        "gst_image": gstImage,
        "license_image": licenseImage,
        "commission": commission,
        "wallet_amount": walletAmount,
        "status": status,
        "gst_pct": gstPct,
        "bank_data": bankData.toJson(),
      };
}

class BankData {
  BankData({
    required this.bankId,
    required this.name,
    required this.accountNumber,
    required this.accountType,
    required this.ifscCode,
    required this.chequeCopy,
    required this.shopId,
    required this.shopName,
    required this.vendorId,
    required this.vendorName,
  });

  dynamic bankId;
  String name;
  String accountNumber;
  String accountType;
  String ifscCode;
  String chequeCopy;
  dynamic shopId;
  String shopName;
  dynamic vendorId;
  String vendorName;

  factory BankData.fromJson(Map<String, dynamic> json) => BankData(
        bankId: json["bank_id"] ?? "null",
        name: json["name"] ?? "null",
        accountNumber: json["account_number"] ?? "null",
        accountType: json["account_type"] ?? "null",
        ifscCode: json["ifsc_code"] ?? "null",
        chequeCopy: json["cheque_copy"] ?? "null",
        shopId: json["shop_id"] ?? "null",
        shopName: json["shop_name"] ?? "null",
        vendorId: json["vendor_id"] ?? "null",
        vendorName: json["vendor_name"] ?? "null",
      );

  Map<String, dynamic> toJson() => {
        "bank_id": bankId,
        "name": name,
        "account_number": accountNumber,
        "account_type": accountType,
        "ifsc_code": ifscCode,
        "cheque_copy": chequeCopy,
        "shop_id": shopId,
        "shop_name": shopName,
        "vendor_id": vendorId,
        "vendor_name": vendorName,
      };
}

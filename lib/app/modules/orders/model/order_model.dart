// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  List<OrderDatum> orderData;

  OrderModel({
    required this.orderData,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderData: List<OrderDatum>.from(
            json["order_data"].map((x) => OrderDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_data": List<dynamic>.from(orderData.map((x) => x.toJson())),
      };
}

class OrderDatum {
  int id;
  String orderNumber;
  String status;
  bool paymentStatus;
  int productId;
  String productName;
  String productImage;
  String price;
  String paymentMethod;
  DateTime createdAt;
  UserAddressData userAddressData;

  OrderDatum({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.paymentStatus,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.paymentMethod,
    required this.createdAt,
    required this.userAddressData,
  });

  factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
        id: json["id"],
        orderNumber: json["order_number"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        price: json["price"],
        paymentMethod: json["payment_method"],
        createdAt: DateTime.parse(json["created_at"]),
        userAddressData: UserAddressData.fromJson(json["user_address_data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
        "status": status,
        "payment_status": paymentStatus,
        "product_id": productId,
        "product_name": productName,
        "product_image": productImage,
        "price": price,
        "payment_method": paymentMethod,
        "created_at": createdAt.toIso8601String(),
        "user_address_data": userAddressData.toJson(),
      };
}

class UserAddressData {
  dynamic id;
  dynamic userId;
  dynamic name;
  dynamic phoneNumber;
  dynamic pinCode;
  dynamic city;
  dynamic state;
  dynamic houseName;
  dynamic roadName;
  dynamic landMark;
  dynamic typeOfAddress;

  UserAddressData({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.houseName,
    required this.roadName,
    required this.landMark,
    required this.typeOfAddress,
  });

  factory UserAddressData.fromJson(Map<String, dynamic> json) =>
      UserAddressData(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        pinCode: json["pin_code"],
        city: json["city"],
        state: json["state"],
        houseName: json["house_name"],
        roadName: json["road_name"],
        landMark: json["land_mark"],
        typeOfAddress: json["type_of_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone_number": phoneNumber,
        "pin_code": pinCode,
        "city": city,
        "state": state,
        "house_name": houseName,
        "road_name": roadName,
        "land_mark": landMark,
        "type_of_address": typeOfAddress,
      };
}

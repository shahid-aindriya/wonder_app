// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  OrderData orderData;

  OrderDetailsModel({
    required this.orderData,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        orderData: OrderData.fromJson(json["order_data"]),
      );

  Map<String, dynamic> toJson() => {
        "order_data": orderData.toJson(),
      };
}

class OrderData {
  int id;
  String orderNumber;
  String status;
  bool paymentStatus;
  int productId;
  String productName;
  String productImage;
  int productAttributeId;
  String productAttribute;
  String productAttributeValue;
  String productAttributeImage;
  String price;
  String paymentMethod;
  String quantity;
  DateTime createdAt;
  bool orderReceivedStatus;
  bool orderConfirmedStatus;
  bool readyToBePickUpStatus;
  bool orderOnTheWayStatus;
  bool orderDeliveredStatus;
  bool returnInitiatedStatus;
  bool returnRequestAcceptStatus;
  bool returnProceedStatus;
  UserAddressData userAddressData;

  OrderData({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.paymentStatus,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productAttributeId,
    required this.productAttribute,
    required this.productAttributeValue,
    required this.productAttributeImage,
    required this.price,
    required this.paymentMethod,
    required this.quantity,
    required this.createdAt,
    required this.orderReceivedStatus,
    required this.orderConfirmedStatus,
    required this.readyToBePickUpStatus,
    required this.orderOnTheWayStatus,
    required this.orderDeliveredStatus,
    required this.returnInitiatedStatus,
    required this.returnRequestAcceptStatus,
    required this.returnProceedStatus,
    required this.userAddressData,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        orderNumber: json["order_number"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        productAttributeId: json["product_attribute_id"],
        productAttribute: json["product_attribute"],
        productAttributeValue: json["product_attribute_value"],
        productAttributeImage: json["product_attribute_image"],
        price: json["price"],
        paymentMethod: json["payment_method"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        orderReceivedStatus: json["order_received_status"],
        orderConfirmedStatus: json["order_confirmed_status"],
        readyToBePickUpStatus: json["ready_to_be_pick_up_status"],
        orderOnTheWayStatus: json["order_on_the_way_status"],
        orderDeliveredStatus: json["order_delivered_status"],
        returnInitiatedStatus: json["return_initiated_status"],
        returnRequestAcceptStatus: json["return_request_accept_status"],
        returnProceedStatus: json["return_proceed_status"],
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
        "order_received_status": orderReceivedStatus,
        "order_confirmed_status": orderConfirmedStatus,
        "ready_to_be_pick_up_status": readyToBePickUpStatus,
        "order_on_the_way_status": orderOnTheWayStatus,
        "order_delivered_status": orderDeliveredStatus,
        "return_initiated_status": returnInitiatedStatus,
        "return_request_accept_status": returnRequestAcceptStatus,
        "return_proceed_status": returnProceedStatus,
        "user_address_data": userAddressData.toJson(),
      };
}

class UserAddressData {
  int id;
  int userId;
  String name;
  String phoneNumber;
  String pinCode;
  String city;
  String state;
  String houseName;
  String roadName;
  String landMark;
  String typeOfAddress;

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

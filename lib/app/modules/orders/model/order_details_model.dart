// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:wonder_app/app/modules/orders/model/order_model.dart';

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
  dynamic productId;
  dynamic productName;
  dynamic productImage;
  dynamic productAttributeId;
  dynamic productAttribute;
  dynamic productAttributeValue;
  dynamic productAttributeImage;
  String price;
  String totalAmount;
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
  bool returnCompletedStatus;
  bool returnPeriodOver;
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
    required this.totalAmount,
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
    required this.returnCompletedStatus,
    required this.returnPeriodOver,
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
        totalAmount: json["total_amount"],
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
        returnCompletedStatus: json["return_completed_status"],
        returnPeriodOver: json["return_period_over"],
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
        "product_attribute_id": productAttributeId,
        "product_attribute": productAttribute,
        "product_attribute_value": productAttributeValue,
        "product_attribute_image": productAttributeImage,
        "price": price,
        "payment_method": paymentMethod,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "order_received_status": orderReceivedStatus,
        "order_confirmed_status": orderConfirmedStatus,
        "ready_to_be_pick_up_status": readyToBePickUpStatus,
        "order_on_the_way_status": orderOnTheWayStatus,
        "order_delivered_status": orderDeliveredStatus,
        "return_initiated_status": returnInitiatedStatus,
        "return_request_accept_status": returnRequestAcceptStatus,
        "return_completed_status": returnCompletedStatus,
        "return_period_over": returnPeriodOver,
        "user_address_data": userAddressData.toJson(),
      };
}

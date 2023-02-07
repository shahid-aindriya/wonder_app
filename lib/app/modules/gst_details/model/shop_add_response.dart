// To parse this JSON data, do
//
//     final addshopresponse = addshopresponseFromJson(jsonString);

import 'dart:convert';

Addshopresponse addshopresponseFromJson(String str) =>
    Addshopresponse.fromJson(json.decode(str));

String addshopresponseToJson(Addshopresponse data) =>
    json.encode(data.toJson());

class Addshopresponse {
  Addshopresponse({
    required this.shopId,
    required this.success,
    required this.message,
  });

  dynamic shopId;
  bool success;
  String message;

  factory Addshopresponse.fromJson(Map<String, dynamic> json) =>
      Addshopresponse(
        shopId: json["shop_id"] ?? "null",
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "shop_id": shopId,
        "success": success,
        "message": message,
      };
}

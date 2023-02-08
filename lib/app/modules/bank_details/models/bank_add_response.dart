// To parse this JSON data, do
//
//     final bankaddresponse = bankaddresponseFromJson(jsonString);

import 'dart:convert';

Bankaddresponse bankaddresponseFromJson(String str) =>
    Bankaddresponse.fromJson(json.decode(str));

String bankaddresponseToJson(Bankaddresponse data) =>
    json.encode(data.toJson());

class Bankaddresponse {
  Bankaddresponse({
    required this.bankId,
    required this.success,
    required this.message,
  });

  int bankId;
  bool success;
  String message;

  factory Bankaddresponse.fromJson(Map<String, dynamic> json) =>
      Bankaddresponse(
        bankId: json["bank_id"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "bank_id": bankId,
        "success": success,
        "message": message,
      };
}

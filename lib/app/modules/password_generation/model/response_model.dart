// To parse this JSON data, do
//
//     final sellerRegistrationResponse = sellerRegistrationResponseFromJson(jsonString);

import 'dart:convert';

SellerRegistrationResponse sellerRegistrationResponseFromJson(String str) =>
    SellerRegistrationResponse.fromJson(json.decode(str));

String sellerRegistrationResponseToJson(SellerRegistrationResponse data) =>
    json.encode(data.toJson());

class SellerRegistrationResponse {
  SellerRegistrationResponse({
    required this.userId,
    required this.success,
    required this.isApproved,
    required this.message,
  });

  int userId;
  bool success;
  bool isApproved;
  String message;

  factory SellerRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      SellerRegistrationResponse(
        userId: json["user_id"],
        success: json["success"],
        isApproved: json["is_approved"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "success": success,
        "is_approved": isApproved,
        "message": message,
      };
}

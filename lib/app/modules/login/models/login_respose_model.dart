// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    required this.userId,
    required this.success,
    required this.isApproved,
    required this.haveShop,
    required this.message,
  });

  dynamic userId;
  dynamic success;
  dynamic isApproved;
  dynamic haveShop;
  String message;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        userId: json["user_id"] ?? "null",
        success: json["success"] ?? "null",
        isApproved: json["is_approved"] ?? "null",
        haveShop: json["have_shop"] ?? "null",
        message: json["message"] ?? "null",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "success": success,
        "is_approved": isApproved,
        "have_shop": haveShop,
        "message": message,
      };
}

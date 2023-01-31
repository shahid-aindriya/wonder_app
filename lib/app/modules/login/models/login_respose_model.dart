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
    required this.message,
  });

  dynamic userId;
  bool success;
  dynamic isApproved;
  String message;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        userId: json["user_id"],
        success: json["success"],
        isApproved: json["is_approved"] ?? "null",
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "success": success,
        "is_approved": isApproved,
        "message": message,
      };
}

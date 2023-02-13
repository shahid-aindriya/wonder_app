// To parse this JSON data, do
//
//     final userDataResponse = userDataResponseFromJson(jsonString);

import 'dart:convert';

UserDataResponse userDataResponseFromJson(String str) =>
    UserDataResponse.fromJson(json.decode(str));

String userDataResponseToJson(UserDataResponse data) =>
    json.encode(data.toJson());

class UserDataResponse {
  UserDataResponse({
    required this.userData,
  });

  UserData userData;

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      UserDataResponse(
        userData: UserData.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "user_data": userData.toJson(),
      };
}

class UserData {
  UserData({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  String name;
  String email;
  String phone;
  String image;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
      };
}

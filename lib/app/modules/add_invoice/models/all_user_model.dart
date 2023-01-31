// To parse this JSON data, do
//
//     final allUsersList = allUsersListFromJson(jsonString);

import 'dart:convert';

AllUsersList allUsersListFromJson(String str) =>
    AllUsersList.fromJson(json.decode(str));

String allUsersListToJson(AllUsersList data) => json.encode(data.toJson());

class AllUsersList {
  AllUsersList({
    required this.usersData,
  });

  List<UsersDatum> usersData;

  factory AllUsersList.fromJson(Map<String, dynamic> json) => AllUsersList(
        usersData: List<UsersDatum>.from(
            json["users_data"].map((x) => UsersDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users_data": List<dynamic>.from(usersData.map((x) => x.toJson())),
      };
}

class UsersDatum {
  UsersDatum({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
  });

  int id;
  String name;
  String phone;
  String image;

  factory UsersDatum.fromJson(Map<String, dynamic> json) => UsersDatum(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "image": image,
      };
}

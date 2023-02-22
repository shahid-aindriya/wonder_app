// To parse this JSON data, do
//
//     final notificationresponse = notificationresponseFromJson(jsonString);

import 'dart:convert';

Notificationresponse notificationresponseFromJson(String str) =>
    Notificationresponse.fromJson(json.decode(str));

String notificationresponseToJson(Notificationresponse data) =>
    json.encode(data.toJson());

class Notificationresponse {
  Notificationresponse({
    required this.notificationData,
  });

  List<NotificationDatum> notificationData;

  factory Notificationresponse.fromJson(Map<String, dynamic> json) =>
      Notificationresponse(
        notificationData: List<NotificationDatum>.from(json["notification_data"]
            .map((x) => NotificationDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notification_data":
            List<dynamic>.from(notificationData.map((x) => x.toJson())),
      };
}

class NotificationDatum {
  NotificationDatum({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
  });

  int id;
  int userId;
  String title;
  String description;

  factory NotificationDatum.fromJson(Map<String, dynamic> json) =>
      NotificationDatum(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
      };
}

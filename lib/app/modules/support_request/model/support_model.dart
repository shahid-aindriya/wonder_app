// To parse this JSON data, do
//
//     final supportModel = supportModelFromJson(jsonString);

import 'dart:convert';

SupportModel supportModelFromJson(String str) =>
    SupportModel.fromJson(json.decode(str));

String supportModelToJson(SupportModel data) => json.encode(data.toJson());

class SupportModel {
  List<SupportDatum> supportData;
  int totalPages;

  SupportModel({
    required this.supportData,
    required this.totalPages,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
        supportData: List<SupportDatum>.from(
            json["support_data"].map((x) => SupportDatum.fromJson(x))),
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "support_data": List<dynamic>.from(supportData.map((x) => x.toJson())),
        "total_pages": totalPages,
      };
}

class SupportDatum {
  int id;
  int userId;
  String title;
  String description;
  String status;

  SupportDatum({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.status,
  });

  factory SupportDatum.fromJson(Map<String, dynamic> json) => SupportDatum(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "status": status,
      };
}

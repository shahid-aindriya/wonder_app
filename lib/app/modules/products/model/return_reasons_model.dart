// To parse this JSON data, do
//
//     final returnReasonsModel = returnReasonsModelFromJson(jsonString);

import 'dart:convert';

ReturnReasonsModel returnReasonsModelFromJson(String str) =>
    ReturnReasonsModel.fromJson(json.decode(str));

String returnReasonsModelToJson(ReturnReasonsModel data) =>
    json.encode(data.toJson());

class ReturnReasonsModel {
  List<ReturnReason> returnReasons;

  ReturnReasonsModel({
    required this.returnReasons,
  });

  factory ReturnReasonsModel.fromJson(Map<String, dynamic> json) =>
      ReturnReasonsModel(
        returnReasons: List<ReturnReason>.from(
            json["return_reasons"].map((x) => ReturnReason.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "return_reasons":
            List<dynamic>.from(returnReasons.map((x) => x.toJson())),
      };
}

class ReturnReason {
  int id;
  dynamic title;
  dynamic description;

  ReturnReason({
    required this.id,
    required this.title,
    required this.description,
  });

  factory ReturnReason.fromJson(Map<String, dynamic> json) => ReturnReason(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}

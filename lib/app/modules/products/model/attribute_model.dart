// To parse this JSON data, do
//
//     final attributeModel = attributeModelFromJson(jsonString);

import 'dart:convert';

AttributeModel attributeModelFromJson(String str) =>
    AttributeModel.fromJson(json.decode(str));

String attributeModelToJson(AttributeModel data) => json.encode(data.toJson());

class AttributeModel {
  List<Attribute> attributes;

  AttributeModel({
    required this.attributes,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) => AttributeModel(
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
      };
}

class Attribute {
  int id;
  dynamic title;
  dynamic description;

  Attribute({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
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

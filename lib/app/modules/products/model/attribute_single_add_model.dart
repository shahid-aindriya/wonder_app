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
  dynamic id;
  dynamic attributeId;
  dynamic attribute;
  dynamic value;
  dynamic quantity;
  dynamic price;
  dynamic discountType;
  dynamic discount;
  List<Image> images;

  Attribute({
    required this.id,
    required this.attributeId,
    required this.attribute,
    required this.value,
    required this.quantity,
    required this.price,
    required this.discountType,
    required this.discount,
    required this.images,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        attributeId: json["attribute_id"],
        attribute: json["attribute"],
        value: json["value"],
        quantity: json["quantity"],
        price: json["price"],
        discountType: json["discount_type"],
        discount: json["discount"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attribute_id": attributeId,
        "attribute": attribute,
        "value": value,
        "quantity": quantity,
        "price": price,
        "discount_type": discountType,
        "discount": discount,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  dynamic id;
  dynamic image;

  Image({
    required this.id,
    required this.image,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

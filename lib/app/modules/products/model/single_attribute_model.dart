// To parse this JSON data, do
//
//     final singleAttributeDetailsModel = singleAttributeDetailsModelFromJson(jsonString);

import 'dart:convert';

SingleAttributeDetailsModel singleAttributeDetailsModelFromJson(String str) =>
    SingleAttributeDetailsModel.fromJson(json.decode(str));

String singleAttributeDetailsModelToJson(SingleAttributeDetailsModel data) =>
    json.encode(data.toJson());

class SingleAttributeDetailsModel {
  AttributeData attributeData;

  SingleAttributeDetailsModel({
    required this.attributeData,
  });

  factory SingleAttributeDetailsModel.fromJson(Map<String, dynamic> json) =>
      SingleAttributeDetailsModel(
        attributeData: AttributeData.fromJson(json["attribute_data"]),
      );

  Map<String, dynamic> toJson() => {
        "attribute_data": attributeData.toJson(),
      };
}

class AttributeData {
  int id;
  int attributeId;
  String attribute;
  String value;
  String quantity;
  String price;
  String discountType;
  String discount;
  List<SingleAttributeImage> image;

  AttributeData({
    required this.id,
    required this.attributeId,
    required this.attribute,
    required this.value,
    required this.quantity,
    required this.price,
    required this.discountType,
    required this.discount,
    required this.image,
  });

  factory AttributeData.fromJson(Map<String, dynamic> json) => AttributeData(
        id: json["id"],
        attributeId: json["attribute_id"],
        attribute: json["attribute"],
        value: json["value"],
        quantity: json["quantity"],
        price: json["price"],
        discountType: json["discount_type"],
        discount: json["discount"],
        image: List<SingleAttributeImage>.from(
            json["image"].map((x) => SingleAttributeImage.fromJson(x))),
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
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };
}

class SingleAttributeImage {
  dynamic id;
  dynamic image;

  SingleAttributeImage({
    this.id,
    required this.image,
  });

  factory SingleAttributeImage.fromJson(Map<String, dynamic> json) =>
      SingleAttributeImage(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

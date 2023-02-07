// To parse this JSON data, do
//
//     final shopShopCategoryModel = shopShopCategoryModelFromJson(jsonString);

import 'dart:convert';

ShopShopCategoryModel shopShopCategoryModelFromJson(String str) =>
    ShopShopCategoryModel.fromJson(json.decode(str));

String shopShopCategoryModelToJson(ShopShopCategoryModel data) =>
    json.encode(data.toJson());

class ShopShopCategoryModel {
  ShopShopCategoryModel({
    required this.categories,
  });

  List<ShopCategory> categories;

  factory ShopShopCategoryModel.fromJson(Map<String, dynamic> json) =>
      ShopShopCategoryModel(
        categories: List<ShopCategory>.from(
            json["categories"].map((x) => ShopCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class ShopCategory {
  ShopCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  int id;
  String name;
  String description;
  String image;

  factory ShopCategory.fromJson(Map<String, dynamic> json) => ShopCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
      };
}

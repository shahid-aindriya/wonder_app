// To parse this JSON data, do
//
//     final categoryForAddingProducts = categoryForAddingProductsFromJson(jsonString);

import 'dart:convert';

CategoryForAddingProducts categoryForAddingProductsFromJson(String str) =>
    CategoryForAddingProducts.fromJson(json.decode(str));

String categoryForAddingProductsToJson(CategoryForAddingProducts data) =>
    json.encode(data.toJson());

class CategoryForAddingProducts {
  List<Category> categories;

  CategoryForAddingProducts({
    required this.categories,
  });

  factory CategoryForAddingProducts.fromJson(Map<String, dynamic> json) =>
      CategoryForAddingProducts(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  dynamic name;
  dynamic description;
  dynamic image;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

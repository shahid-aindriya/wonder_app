// To parse this JSON data, do
//
//     final subCategoryForAddingProducts = subCategoryForAddingProductsFromJson(jsonString);

import 'dart:convert';

import 'category_for_add_products.dart';

SubCategoryForAddingProducts subCategoryForAddingProductsFromJson(String str) =>
    SubCategoryForAddingProducts.fromJson(json.decode(str));

String subCategoryForAddingProductsToJson(SubCategoryForAddingProducts data) =>
    json.encode(data.toJson());

class SubCategoryForAddingProducts {
  List<Category> categories;

  SubCategoryForAddingProducts({
    required this.categories,
  });

  factory SubCategoryForAddingProducts.fromJson(Map<String, dynamic> json) =>
      SubCategoryForAddingProducts(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

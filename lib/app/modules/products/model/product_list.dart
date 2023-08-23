// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductListModel {
  List<ProductDatum> productData;

  ProductListModel({
    required this.productData,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        productData: List<ProductDatum>.from(
            json["product_data"].map((x) => ProductDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_data": List<dynamic>.from(productData.map((x) => x.toJson())),
      };
}

class ProductDatum {
  int id;
  dynamic name;
  dynamic sku;
  dynamic price;
  dynamic quantity;
  dynamic categoryId;
  dynamic category;
  dynamic subCategoryId;
  dynamic subCategory;
  dynamic featuredImage;
  dynamic discount;
  dynamic discountType;
  dynamic isFeatured;
  dynamic active;
  dynamic shopId;
  dynamic vendorId;

  ProductDatum({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    required this.quantity,
    required this.categoryId,
    required this.category,
    required this.subCategoryId,
    required this.subCategory,
    required this.featuredImage,
    required this.discount,
    required this.discountType,
    required this.isFeatured,
    required this.active,
    required this.shopId,
    required this.vendorId,
  });

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        price: json["price"],
        quantity: json["quantity"],
        categoryId: json["category_id"],
        category: json["category"],
        subCategoryId: json["sub_category_id"],
        subCategory: json["sub_category"],
        featuredImage: json["featured_image"],
        discount: json["discount"],
        discountType: json["discount_type"],
        isFeatured: json["is_featured"],
        active: json["active"],
        shopId: json["shop_id"],
        vendorId: json["vendor_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku": sku,
        "price": price,
        "quantity": quantity,
        "category_id": categoryId,
        "category": category,
        "sub_category_id": subCategoryId,
        "sub_category": subCategory,
        "featured_image": featuredImage,
        "discount": discount,
        "discount_type": discountType,
        "is_featured": isFeatured,
        "active": active,
        "shop_id": shopId,
        "vendor_id": vendorId,
      };
}
